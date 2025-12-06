//
//  SuperheroViewController.swift
//  Superhero Randomizer
//

import UIKit

final class SuperheroViewController: UIViewController {

    // MARK: - UI
    private let scrollView = UIScrollView()
    private let content = UIStackView()

    private let heroImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 16
        iv.backgroundColor = UIColor.secondarySystemBackground
        iv.heightAnchor.constraint(equalToConstant: 260).isActive = true
        return iv
    }()

    private let nameLabel = UILabel()
    private let fullNameLabel = UILabel()

    /// Горизонтальный контейнер из двух вертикальных колонок
    private let statsGrid = UIStackView()

    private lazy var randomButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Randomize"
        config.cornerStyle = .large
        config.image = UIImage(systemName: "shuffle")
        config.imagePadding = 8
        let b = UIButton(configuration: config, primaryAction: UIAction { [weak self] _ in
            Task { await self?.loadRandom() }
        })
        return b
    }()

    private let activity = UIActivityIndicatorView(style: .large)

    // Храним последнего героя (на будущее, если захочешь расширять)
    private var currentHero: Hero?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Superhero Randomizer"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "About",
            style: .plain,
            target: self,
            action: #selector(showAbout)
        )
        setupLayout()
        Task { await loadRandom() }
    }

    // MARK: - Layout
    private func setupLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        content.translatesAutoresizingMaskIntoConstraints = false

        content.axis = .vertical
        content.alignment = .fill
        content.spacing = 16

        view.addSubview(scrollView)
        scrollView.addSubview(content)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 16),
            content.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 16),
            content.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -16),
            content.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -24),
            content.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -32)
        ])

        // Верхнее изображение
        content.addArrangedSubview(heroImageView)

        // Имя и полное имя
        nameLabel.font = .systemFont(ofSize: 28, weight: .bold)
        nameLabel.numberOfLines = 0

        fullNameLabel.font = .systemFont(ofSize: 16, weight: .medium)
        fullNameLabel.textColor = .secondaryLabel
        fullNameLabel.numberOfLines = 0

        let nameStack = UIStackView(arrangedSubviews: [nameLabel, fullNameLabel])
        nameStack.axis = .vertical
        nameStack.spacing = 4
        content.addArrangedSubview(nameStack)

        // Сетка характеристик (2 колонки)
        statsGrid.axis = .horizontal
        statsGrid.alignment = .fill
        statsGrid.distribution = .fillEqually
        statsGrid.spacing = 12

        let leftCol = UIStackView();  leftCol.axis = .vertical;  leftCol.spacing = 8
        let rightCol = UIStackView(); rightCol.axis = .vertical; rightCol.spacing = 8
        statsGrid.addArrangedSubview(leftCol)
        statsGrid.addArrangedSubview(rightCol)
        content.addArrangedSubview(statsGrid)

        // Кнопка Randomize
        content.addArrangedSubview(randomButton)

        // Индикатор загрузки
        activity.hidesWhenStopped = true
        view.addSubview(activity)
        activity.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activity.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activity.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        // Заполняем колонки плейсхолдерами (по 6 в каждую — всего 12 «карточек»)
        for _ in 0..<6 { leftCol.addArrangedSubview(makeInfoRow(title: "--", value: "--")) }
        for _ in 0..<6 { rightCol.addArrangedSubview(makeInfoRow(title: "--", value: "--")) }
    }

    private func makeInfoRow(title: String, value: String) -> UIView {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        titleLabel.textColor = .secondaryLabel
        titleLabel.text = title

        let valueLabel = UILabel()
        valueLabel.font = .systemFont(ofSize: 16, weight: .regular)
        valueLabel.numberOfLines = 0
        valueLabel.text = value

        let stack = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        stack.axis = .vertical
        stack.spacing = 2
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        stack.backgroundColor = UIColor.secondarySystemBackground
        stack.layer.cornerRadius = 12
        return stack
    }

    // MARK: - Loading state
    @MainActor
    private func setLoading(_ loading: Bool) {
        view.isUserInteractionEnabled = !loading
        loading ? activity.startAnimating() : activity.stopAnimating()
    }

    // MARK: - Render
    @MainActor
    private func render(hero: Hero, image: UIImage) {
        // Кроссфейд изображения
        UIView.transition(with: heroImageView, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.heroImageView.image = image
        })

        // Кроссфейд текстов/карточек
        UIView.transition(with: view, duration: 0.25, options: .transitionCrossDissolve, animations: {
            self.nameLabel.text = hero.name
            self.fullNameLabel.text = (hero.biography.fullName?.isEmpty == false ? hero.biography.fullName! : "—")
            self.updateGrid(with: hero)
        })
        currentHero = hero
    }

    // Обновляем 2-колоночную сетку значениями героя
    private func updateGrid(with hero: Hero) {
        guard statsGrid.arrangedSubviews.count == 2,
              let leftCol = statsGrid.arrangedSubviews[0] as? UIStackView,
              let rightCol = statsGrid.arrangedSubviews[1] as? UIStackView else { return }

        let leftItems: [(String, String)] = [
            ("Intelligence", value(hero.powerstats.intelligence)),
            ("Strength",     value(hero.powerstats.strength)),
            ("Speed",        value(hero.powerstats.speed)),
            ("Durability",   value(hero.powerstats.durability)),
            ("Power",        value(hero.powerstats.power)),
            ("Combat",       value(hero.powerstats.combat))
        ]

        let heightM  = hero.appearance.height?.last ?? "—" // metric
        let weightKg = hero.appearance.weight?.last ?? "—" // kg

        let rightItems: [(String, String)] = [
            ("Gender",          hero.appearance.gender ?? "—"),
            ("Race",            hero.appearance.race ?? "—"),
            ("Height",          heightM),
            ("Weight",          weightKg),
            ("Place of Birth",  hero.biography.placeOfBirth ?? "—"),
            ("First Appearance",hero.biography.firstAppearance ?? "—")
        ]

        func apply(_ items: [(String, String)], to column: UIStackView) {
            for (idx, view) in column.arrangedSubviews.enumerated() {
                guard let stack = view as? UIStackView,
                      stack.arrangedSubviews.count >= 2,
                      let titleLabel = stack.arrangedSubviews[0] as? UILabel,
                      let valueLabel = stack.arrangedSubviews[1] as? UILabel,
                      idx < items.count else { continue }
                titleLabel.text = items[idx].0
                valueLabel.text = items[idx].1
            }
        }

        apply(leftItems,  to: leftCol)
        apply(rightItems, to: rightCol)
    }

    private func value(_ v: Int?) -> String { v.map { String($0) } ?? "—" }

    // MARK: - Actions
    @objc private func showAbout() {
        let msg = "Fetches a random hero from the public SuperHero API and shows ≥10 attributes with image."
        let ac = UIAlertController(title: "Superhero Randomizer", message: msg, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }

    // MARK: - Networking orchestration
    private func loadRandom() async {
        setLoading(true)
        defer { Task { @MainActor in self.setLoading(false) } }

        do {
            let hero = try await SuperheroAPI.shared.randomHero()
            let image = try await ImageLoader.shared.load(hero.images.lg)
            await MainActor.run { self.render(hero: hero, image: image) }
        } catch {
            await MainActor.run { self.presentError(error) }
        }
    }

    @MainActor
    private func presentError(_ error: Error) {
        let message = (error as? LocalizedError)?.errorDescription ?? error.localizedDescription
        let ac = UIAlertController(title: "Oops", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Retry", style: .default, handler: { [weak self] _ in
            Task { await self?.loadRandom() }
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
}

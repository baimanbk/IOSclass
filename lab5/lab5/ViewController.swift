import UIKit

// MARK: - Модель данных
struct Hero: Codable {
    let name: String
    let powerstats: PowerStats?
    let appearance: Appearance?
    let images: Images?
}

struct PowerStats: Codable {
    let intelligence: Int?
    let strength: Int?
    let speed: Int?
    let durability: Int?
    let power: Int?
    let combat: Int?
}

struct Appearance: Codable {
    let gender: String?
    let race: String?
}

struct Images: Codable {
    let lg: String?
}

// MARK: - Основной экран
class ViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var heroNameLabel: UILabel!
    @IBOutlet weak var heroNameLabel2: UILabel!
    @IBOutlet weak var randomizeButton: UIButton!
    

    var heroes: [Hero] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchHeroes()
    }

    // MARK: - Стилизация интерфейса
    func setupUI() {
        view.backgroundColor = UIColor.systemGray6

        // Картинка героя
        image.layer.cornerRadius = 20
        image.layer.shadowColor = UIColor.black.cgColor
        image.layer.shadowOpacity = 0.2
        image.layer.shadowOffset = CGSize(width: 0, height: 5)
        image.layer.shadowRadius = 10
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit

        // Название героя
        heroNameLabel.font = UIFont.boldSystemFont(ofSize: 26)
        heroNameLabel.textColor = .label
        heroNameLabel.textAlignment = .center

        // Описание героя
        heroNameLabel2.font = UIFont.systemFont(ofSize: 18)
        heroNameLabel2.textColor = .darkGray
        heroNameLabel2.textAlignment = .center
        heroNameLabel2.numberOfLines = 0

        // Кнопка
        randomizeButton.setTitle("🎲 Random Hero", for: .normal)
        randomizeButton.backgroundColor = UIColor.systemBlue
        randomizeButton.setTitleColor(.white, for: .normal)
        randomizeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        randomizeButton.layer.cornerRadius = 12
        randomizeButton.layer.shadowColor = UIColor.black.cgColor
        randomizeButton.layer.shadowOpacity = 0.3
        randomizeButton.layer.shadowRadius = 8
        randomizeButton.layer.shadowOffset = CGSize(width: 0, height: 4)
    }

    // MARK: - Загрузка героев
    func fetchHeroes() {
        let url = URL(string: "https://akabab.github.io/superhero-api/api/all.json")!
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Ошибка загрузки: \(error.localizedDescription)")
                return
            }

            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode([Hero].self, from: data)
                    DispatchQueue.main.async {
                        self.heroes = decoded
                        self.showRandomHero()
                    }
                } catch {
                    print("Ошибка декодирования JSON: \(error)")
                }
            }
        }.resume()
    }

    // MARK: - Кнопка Randomize
    @IBAction func randomizeTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                sender.transform = .identity
            }
        }
        showRandomHero()
    }

    // MARK: - Показ случайного героя
    func showRandomHero() {
        guard !heroes.isEmpty else { return }
        let hero = heroes.randomElement()!

        // Имя героя
        heroNameLabel.text = hero.name

        // Теперь Label2 — описание
        var descriptionText = ""
        if let race = hero.appearance?.race, !race.isEmpty {
            descriptionText += "🧬 Race: \(race)\n"
        }
        if let gender = hero.appearance?.gender, !gender.isEmpty {
            descriptionText += "🚻 Gender: \(gender)\n"
        }

        // Добавим немного "AI-био" для стиля
        let phrases = [
            "Defender of peace 🌍",
            "A mysterious hero with hidden power ⚡️",
            "Fights for justice 💥",
            "Protector of the weak 🛡",
            "A legend reborn 🔥"
        ]
        descriptionText += "\n\(phrases.randomElement() ?? "")"

        // Если ничего нет — запасной текст
        if descriptionText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            descriptionText = "Unknown origins... 🕵️‍♂️"
        }

        heroNameLabel2.text = descriptionText

        // Фото героя
        if let urlStr = hero.images?.lg, let url = URL(string: urlStr) {
            loadImage(from: url)
        }
    }

    // MARK: - Загрузка картинки
    func loadImage(from url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image.image = image
                }
            }
        }
    }
}

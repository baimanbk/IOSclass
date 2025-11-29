import UIKit

final class BooksViewController: UITableViewController {

    private var items: [FavoriteItem] = [
        FavoriteItem(
            title: "1984",
            imageName: "b1",
            description: "George Orwell’s chilling vision of a totalitarian future where Big Brother controls every aspect of life. The novel explores themes of surveillance, censorship, and the fragility of truth. It portrays a world where individuality is crushed under the weight of political oppression. The story follows Winston Smith as he secretly rebels against the Party. It’s a haunting warning about the dangers of absolute power and blind conformity.",
            review: "Terrifyingly relevant and brilliantly written."
        ),
        FavoriteItem(
            title: "Animal Farm",
            imageName: "b2",
            description: "A sharp political satire disguised as a simple fable about farm animals rising against their human master. George Orwell uses this allegory to expose the corruption of revolutionary ideals and the rise of tyranny. The characters represent real historical figures from the Russian Revolution. As power shifts, equality fades, and the farm descends into dictatorship. The book’s simplicity hides a timeless and powerful political message.",
            review: "Simple story, deep political truth."
        ),
        FavoriteItem(
            title: "The Sorrows of Satan",
            imageName: "b3",
            description: "Marie Corelli’s Gothic masterpiece follows a struggling writer who encounters the Devil disguised as a charming gentleman. The story explores temptation, morality, and the illusion of success. It questions what people are willing to sacrifice for fame and wealth. Through poetic language and philosophical undertones, Corelli criticizes the superficial values of her time. The novel remains a fascinating blend of moral drama and supernatural allure.",
            review: "Philosophical, dark, and beautifully written."
        ),
        FavoriteItem(
            title: "Crime and Punishment",
            imageName: "b4",
            description: "Fyodor Dostoevsky’s psychological novel delves into the mind of a man torn between morality and survival. Raskolnikov commits murder, believing he can justify his actions through logic and philosophy. The story becomes a deep exploration of guilt, redemption, and human conscience. The tension between right and wrong drives the narrative to its powerful conclusion. It’s a profound study of human suffering and the search for forgiveness.",
            review: "Intense, philosophical, and emotionally gripping."
        ),
        FavoriteItem(
            title: "The Alchemist",
            imageName: "b5",
            description: "Paulo Coelho’s timeless tale of a young shepherd named Santiago who dreams of finding treasure. Along his journey, he learns that true fulfillment lies in following one’s personal legend. The novel blends spirituality, philosophy, and adventure into a poetic narrative. Each encounter teaches Santiago something about destiny and faith. It’s an inspiring reminder that the greatest treasure is found within oneself.",
            review: "Uplifting, wise, and full of wonder."
        ),
        FavoriteItem(
            title: "The Picture of Dorian Gray",
            imageName: "b6",
            description: "Oscar Wilde’s only novel tells the story of a young man who trades his soul for eternal youth and beauty. As Dorian remains flawless, his portrait ages and decays with each sinful act. The book examines vanity, morality, and the corrupting influence of pleasure. Wilde’s wit and poetic prose make every line memorable. It’s both a Gothic horror story and a reflection on the cost of living without conscience.",
            review: "Elegant, haunting, and morally profound."
        ),
        FavoriteItem(
            title: "Sherlock Holmes",
            imageName: "b7",
            description: "Arthur Conan Doyle’s legendary detective stories follow Sherlock Holmes and Dr. Watson as they solve intricate mysteries. Holmes’s sharp intellect and unique methods make him a timeless character. Each case reveals not just clever deductions but insights into human nature. The London atmosphere adds charm and mystery to every story. These tales set the gold standard for detective fiction.",
            review: "Brilliant mysteries with timeless charm."
        ),
        FavoriteItem(
            title: "The Count of Monte Cristo",
            imageName: "b8",
            description: "Alexandre Dumas’s epic tale of betrayal, revenge, and redemption. Edmond Dantès is wrongfully imprisoned and escapes to claim justice against those who destroyed his life. The novel spans years, filled with drama, adventure, and emotion. It explores human resilience, love, and the desire for vengeance. It’s one of literature’s greatest journeys from despair to triumph.",
            review: "Grand, emotional, and endlessly captivating."
        ),
        FavoriteItem(
            title: "The Hunger Games",
            imageName: "b9",
            description: "Suzanne Collins’s dystopian novel set in a future where children are forced to fight to the death for entertainment. Katniss Everdeen becomes a reluctant hero, challenging a cruel system. The story combines survival, strategy, and social commentary on power and inequality. Its fast pace keeps readers on edge from start to finish. It’s a powerful critique of media manipulation and violence as spectacle.",
            review: "Thrilling, bold, and thought-provoking."
        ),
        FavoriteItem(
            title: "Dr. Jekyll and Mr. Hyde",
            imageName: "b10",
            description: "Robert Louis Stevenson’s classic novella exploring the duality of human nature. Dr. Jekyll creates a potion that transforms him into the monstrous Mr. Hyde. The story examines morality, temptation, and the hidden darkness within us all. Its suspenseful tone and moral depth make it unforgettable. A masterpiece of psychological horror and Victorian atmosphere.",
            review: "Short, chilling, and profoundly human."
        )
    ]


    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Books"
        tableView.rowHeight = 80
    }

    // MARK: - DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath)
        let item = items[indexPath.row]

        var content = cell.defaultContentConfiguration()
        content.text = item.title
        content.image = UIImage(named: item.imageName)
        content.imageProperties.maximumSize = CGSize(width: 50, height: 50) // размер иконки
        content.imageProperties.cornerRadius = 8                           // чуть закруглим
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    // MARK: - Delegate (открываем детали)
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let vc = DetailViewController.instantiate()
        vc.item = items[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}


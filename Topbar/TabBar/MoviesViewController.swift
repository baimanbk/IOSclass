import UIKit

final class MoviesViewController: UITableViewController {
    private var items: [FavoriteItem] = [
        FavoriteItem(
            title: "Gone Girl",
            imageName: "m1",
            description: """
    Nick Dunne discovers that the spotlight turns on him when his wife, Amy, goes missing on their fifth wedding anniversary. 
    As media attention grows, cracks begin to show in their seemingly perfect marriage. 
    Detectives uncover inconsistencies in Nick’s story, and the public turns against him. 
    Amy’s disappearance becomes a nationwide sensation fueled by betrayal and lies. 
    It’s a gripping psychological thriller that keeps you guessing until the very end.
    """,
            review: "Dark, sharp, and full of twists — a perfect modern mystery."
        ),
        FavoriteItem(
            title: "Now You See Me",
            imageName: "m2",
            description: """
    Four street magicians form a team called The Four Horsemen to perform incredible heists during their shows. 
    They steal money from corrupt corporations and give it back to their audiences. 
    An FBI agent and an Interpol detective try to catch them but are always one step behind. 
    The illusion deepens as they realize someone else might be controlling the game. 
    It’s a thrilling mix of magic, mystery, and crime.
    """,
            review: "Fast-paced and clever — like a magic trick that never stops surprising you."
        ),
        FavoriteItem(
            title: "Parasite",
            imageName: "m3",
            description: """
    A poor Korean family slowly infiltrates the lives of a wealthy household by posing as skilled workers. 
    At first, everything seems to go perfectly as they enjoy a new life of luxury. 
    But when secrets start to surface, their plans spiral out of control. 
    Beneath the humor and tension lies a deep message about class and inequality. 
    The story explodes into chaos in a shocking, unforgettable climax.
    """,
            review: "Smart, funny, and tragic — a true masterpiece of modern cinema."
        ),
        FavoriteItem(
            title: "Inglourious Basterds",
            imageName: "m4",
            description: """
    In Nazi-occupied France during World War II, a group of Jewish-American soldiers plans to assassinate Nazi leaders. 
    Meanwhile, a young theater owner seeks revenge for her family's murder. 
    Their paths collide in a plan that could change the course of history. 
    The film blends dark humor, intense dialogue, and explosive action. 
    It’s a wild reimagining of war that only Quentin Tarantino could create.
    """,
            review: "Stylish, bold, and wickedly entertaining."
        ),
        FavoriteItem(
            title: "Kill Bill: Vol. 1",
            imageName: "m5",
            description: """
    A former assassin known as The Bride awakens from a four-year coma and seeks revenge on her former team. 
    She travels across the world, leaving a trail of blood and vengeance behind. 
    Every battle brings her closer to her ultimate target: Bill. 
    The film is a love letter to martial arts and samurai cinema. 
    It’s violent, colorful, and absolutely iconic.
    """,
            review: "An action ballet — fierce, stylish, and unforgettable."
        ),
        FavoriteItem(
            title: "The Truman Show",
            imageName: "m6",
            description: """
    Truman Burbank lives a peaceful life in a perfect town — until he begins to suspect something’s wrong. 
    He slowly discovers that his entire life has been broadcast as a reality TV show. 
    Friends, family, and even the sky above are part of an elaborate illusion. 
    His search for the truth becomes a moving story about freedom and identity. 
    The film blends humor, drama, and philosophy in a unique way.
    """,
            review: "Heartwarming, surreal, and thought-provoking — a timeless classic."
        ),
        FavoriteItem(
            title: "Babylon",
            imageName: "m7",
            description: "A visually dazzling exploration of early Hollywood’s chaos and excess. 'Babylon' follows multiple characters chasing fame as silent cinema transforms into the talkies. The film captures the beauty and darkness of ambition, where dreams often come with a price. Its vibrant cinematography and jazz-fueled soundtrack immerse viewers in the madness of the 1920s. Damien Chazelle crafts a wild, emotional tribute to cinema’s rise and moral decay.",
            review: "Ambitious, wild, and visually stunning — a chaotic love letter to film."
        ),
        FavoriteItem(
            title: "Oppenheimer",
            imageName: "m8",
            description: "Christopher Nolan’s epic biographical drama about J. Robert Oppenheimer, the father of the atomic bomb. The film interweaves science, politics, and morality in a tense narrative. Cillian Murphy delivers a haunting performance that captures both genius and guilt. The storytelling moves between triumph and torment, highlighting the burden of creation. With powerful visuals and sound design, it’s a deeply human reflection on responsibility and consequence.",
            review: "Intense, intellectual, and emotionally devastating."
        ),
        FavoriteItem(
            title: "Interstellar",
            imageName: "m9",
            description: "A breathtaking space epic that blends science, love, and survival. 'Interstellar' follows a group of astronauts searching for a new home for humanity beyond the stars. The film explores time dilation, relativity, and the emotional power of human connection. Hans Zimmer’s score and Nolan’s direction create an unforgettable cinematic experience. It’s both a love letter to exploration and a meditation on what makes life meaningful.",
            review: "Visually grand, scientifically deep, and emotionally profound."
        ),
        FavoriteItem(
            title: "The Matrix",
            imageName: "m10",
            description: "A groundbreaking sci-fi masterpiece that redefined modern cinema. 'The Matrix' follows Neo, a hacker who discovers that reality is an illusion controlled by machines. The film blends philosophy, action, and cyberpunk aesthetics in a visionary story. Its slow-motion 'bullet time' effects and existential themes became cultural icons. Beyond its visuals, it challenges viewers to question freedom, control, and the nature of truth.",
            review: "Revolutionary, thought-provoking, and endlessly rewatchable."
        )
    ]




    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies"
        tableView.rowHeight = 80
    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        items.count
//    }
//
//    override func tableView(_ tableView: UITableView,
//                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteCell
//        cell.configure(with: items[indexPath.row])
//        cell.accessoryType = .disclosureIndicator
//        return cell
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let vc = DetailViewController.instantiate()
//        vc.item = items[indexPath.row]
//        navigationController?.pushViewController(vc, animated: true)
//    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->Int {
        return items.count
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

    
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            guard segue.identifier == "showDetails",
//                  let vc = segue.destination as? DetailViewController,
//                  let indexPath = tableView.indexPathForSelectedRow else { return }
//            vc.item = items[indexPath.row]
//            print("prepare: \(items[indexPath.row].title)")
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let vc = DetailViewController.instantiate()
        vc.item = items[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    // MARK: - Navigation

//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "showDetails", sender: indexPath)
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showDetails",
//            let indexPath = sender as? IndexPath,
//            let vc = segue.destination as? DetailViewController {
//            vc.item = items[indexPath.row]
//        }
//    }
}

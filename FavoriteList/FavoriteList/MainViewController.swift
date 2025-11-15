import UIKit

class MainViewController: UITableViewController {
    
    // MARK: - Data
    var data: [[FavoriteItem]] = []
    let sectionTitles = ["Movies", "Music", "Books", "Courses"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: "FavoriteCell")
        
        setupData()
    }
    
    // MARK: - TableView Structure
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    override func tableView(_ tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "FavoriteCell",
            for: indexPath
        ) as! FavoriteCell
        
        let item = data[indexPath.section][indexPath.row]
        cell.configure(with: item)
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        let item = data[indexPath.section][indexPath.row]
        vc.item = item
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // MARK: - Data Setup
    
    func setupData() {
        
        // MARK: Movies
        let movies = [
            FavoriteItem(title: "Titanic",
                         subtitle: "1997 • James Cameron",
                         review: "Один из самых эмоциональных фильмов.",
                         imageName: "titanic"),
            
            FavoriteItem(title: "Iron Man",
                         subtitle: "2008 • Jon Favreau",
                         review: "Фильм, с которого началась MCU.",
                         imageName: "ironman"),
            
            FavoriteItem(title: "Home Alone",
                         subtitle: "1990 • Chris Columbus",
                         review: "Новогодняя классика.",
                         imageName: "homealone"),
            
            FavoriteItem(title: "Inception",
                         subtitle: "2010 • Christopher Nolan",
                         review: "Глубокий фильм про сны.",
                         imageName: "inception"),
            
            FavoriteItem(title: "Interstellar",
                         subtitle: "2014 • Christopher Nolan",
                         review: "Эмоциональная история + музыка Циммера.",
                         imageName: "interstellar")
        ]
        
        // MARK: Music
        let music = [
            FavoriteItem(title: "Shape of You",
                         subtitle: "Ed Sheeran • 2017",
                         review: "Один из самых узнаваемых треков.",
                         imageName: "shape"),
            
            FavoriteItem(title: "Nonstop",
                         subtitle: "Drake • 2018",
                         review: "Мощный бит, заряжает.",
                         imageName: "nonstop"),
            
            FavoriteItem(title: "Girl You Loud",
                         subtitle: "Chris Brown",
                         review: "Мягкий R&B, красивый вокал.",
                         imageName: "girlloud"),
            
            FavoriteItem(title: "Blinding Lights",
                         subtitle: "The Weeknd",
                         review: "Энерджи, драйв, ретровайб.",
                         imageName: "blinding"),
            
            FavoriteItem(title: "Starboy",
                         subtitle: "The Weeknd",
                         review: "Классный бит, стильная подача.",
                         imageName: "starboy")
        ]
        
        // MARK: Books
        let books = [
            FavoriteItem(title: "Самый богатый человек в Вавилоне",
                         subtitle: "Джордж Клейсон",
                         review: "Учёт финансовой дисциплины.",
                         imageName: "babylon"),
            
            FavoriteItem(title: "1984",
                         subtitle: "Джордж Оруэлл",
                         review: "Антиутопия про контроль общества.",
                         imageName: "1984"),
            
            FavoriteItem(title: "Атлант расправил плечи",
                         subtitle: "Айн Рэнд",
                         review: "Философия и мотивация.",
                         imageName: "atlas"),
            
            FavoriteItem(title: "Тонкое искусство пофигизма",
                         subtitle: "Марк Мэнсон",
                         review: "Учёт спокойствия жизни.",
                         imageName: "artofnot"),
            
            FavoriteItem(title: "Война и мир",
                         subtitle: "Лев Толстой",
                         review: "Глубокая классика.",
                         imageName: "warpeace")
        ]
        
        // MARK: Courses
        let courses = [
            FavoriteItem(title: "Algorithms & Data Structures",
                         subtitle: "KBTU",
                         review: "Развитие логического мышления.",
                         imageName: "course"),
            
            FavoriteItem(title: "Golang Application Development",
                         subtitle: "KBTU",
                         review: "Современный язык, быстрый и мощный.",
                         imageName: "course"),
            
            FavoriteItem(title: "Programming Principles I",
                         subtitle: "KBTU",
                         review: "Фундаментальый курс.",
                         imageName: "course"),
            
            FavoriteItem(title: "Abay Studies",
                         subtitle: "KBTU",
                         review: "Культурное развитие.",
                         imageName: "course"),
            
            FavoriteItem(title: "Introduction to Innovation Ecosystem",
                         subtitle: "KBTU",
                         review: "Как работает мир стартапов.",
                         imageName: "course")
        ]
        
        data = [movies, music, books, courses]
    }
    
}

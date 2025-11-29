import UIKit

final class MusicViewController: UITableViewController {

    private var items: [FavoriteItem] = [
        FavoriteItem(
            title: "Pump It",
            imageName: "s1",
            description: "An explosive track by The Black Eyed Peas that blends rock guitar riffs with high-energy hip-hop beats. The song samples the famous surf-rock classic 'Misirlou' and transforms it into a dance-floor anthem. Its driving rhythm and shouted chorus make it perfect for workouts or parties. The lyrics celebrate turning up the volume and living in the moment. Every beat is meant to energize and excite, embodying the spirit of early 2000s pop fusion.",
            review: "Adrenaline-pumping and unforgettable!"
        ),
        FavoriteItem(
            title: "Heard 'Em Say",
            imageName: "s2",
            description: "A soulful collaboration between Kanye West and Adam Levine that blends introspective lyrics with gentle piano melodies. The song reflects on life’s challenges, hope, and the human need for empathy. Its tone is both melancholic and hopeful, giving it emotional depth. The simplicity of production highlights the honesty of the words. It remains one of Kanye’s most heartfelt tracks from his early career.",
            review: "Smooth, thoughtful, and timeless."
        ),
        FavoriteItem(
            title: "Born To Die",
            imageName: "s3",
            description: "Lana Del Rey’s cinematic masterpiece that merges vintage glamour with modern sadness. The orchestral background builds a dreamlike atmosphere, while her haunting vocals narrate themes of love, loss, and fatalism. It feels both nostalgic and contemporary, painting a picture of beauty wrapped in tragedy. The song’s lyrics portray vulnerability and strength in equal measure. It’s a defining piece of Lana’s melancholic artistry.",
            review: "Beautifully dark and emotionally immersive."
        ),
        FavoriteItem(
            title: "Cry Me a River",
            imageName: "s4",
            description: "Justin Timberlake’s iconic breakup ballad that set a new standard for early 2000s R&B. The production, led by Timbaland, features moody synths and layered harmonies that perfectly express heartbreak and betrayal. Timberlake’s performance feels raw and personal, turning pain into art. The dramatic tone and subtle anger make it unforgettable. It’s one of those songs that changed pop music’s emotional landscape.",
            review: "Bittersweet, dramatic, and flawlessly produced."
        ),
        FavoriteItem(
            title: "Feel Good Inc.",
            imageName: "s5",
            description: "Gorillaz’s experimental anthem that mixes funky basslines, eerie laughter, and powerful rap verses. The track critiques consumerism while ironically being incredibly catchy. Its contrast between dark verses and the soaring chorus creates an unforgettable mood. The animated band’s unique sound world shines here more than ever. Even after years, the song still feels futuristic and relevant.",
            review: "Genre-bending brilliance with lasting impact."
        ),
        FavoriteItem(
            title: "Knee Socks",
            imageName: "s6",
            description: "A smooth and sultry track by Arctic Monkeys filled with groove and charm. The guitars flow lazily over a steady beat, and Alex Turner’s lyrics are playful yet poetic. It’s one of those songs that feels effortlessly cool without trying too hard. The retro funk influence makes it both nostalgic and fresh. The rhythm and tone create an intimate yet energetic vibe.",
            review: "Cool, funky, and irresistibly smooth."
        ),
        FavoriteItem(
            title: "Side to Side",
            imageName: "s7",
            description: "Ariana Grande and Nicki Minaj’s vibrant pop collaboration that’s both catchy and empowering. The reggae-inspired rhythm gives the song a relaxed but confident feel. Ariana’s vocals are silky yet strong, while Nicki’s rap adds edge and personality. It’s a perfect mix of pop polish and playful energy. The track became a modern workout and dance anthem worldwide.",
            review: "Fun, flirty, and full of confidence."
        ),
        FavoriteItem(
            title: "Do I Wanna Know?",
            imageName: "s8",
            description: "A moody, hypnotic rock track from Arctic Monkeys that captures late-night thoughts and unspoken feelings. The slow, heavy guitar riff instantly hooks the listener. Alex Turner’s lyrics explore obsession, vulnerability, and self-doubt. The minimalist production emphasizes emotion over noise. It’s an anthem for introspective nights and overthinking hearts.",
            review: "Seductive, atmospheric, and unforgettable."
        ),
        FavoriteItem(
            title: "All That She Wants",
            imageName: "s9",
            description: "Ace of Base’s classic 90s hit that blends reggae-pop rhythms with haunting melodies. The song tells the story of a free-spirited woman seeking independence, not commitment. Its unique sound helped define an entire decade of pop music. The beat is smooth but mysterious, giving it a hypnotic quality. Even today, it remains one of the most recognizable songs of its era.",
            review: "Catchy, nostalgic, and endlessly replayable."
        ),
        FavoriteItem(
            title: "Therefore I Am",
            imageName: "s10",
            description: "Billie Eilish’s confident anthem that combines sarcasm with swagger. The minimalist beat supports her laid-back but assertive delivery. The lyrics reject judgment and gossip, asserting control over her own identity. It’s both playful and powerful, showing Billie’s signature mix of rebellion and cool restraint. The song feels effortless but packs serious attitude.",
            review: "Clever, confident, and hypnotic."
        )
    ]


    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Music"
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

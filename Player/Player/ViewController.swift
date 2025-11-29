import UIKit
import AVFoundation

struct Track {
    let title: String
    let artist: String
    let coverName: String
    let fileName: String
}

enum RepeatMode: Int {
    case off, all, one
    var next: RepeatMode {
        RepeatMode(rawValue: (rawValue + 1) % 3)!
    }
}

final class ViewController: UIViewController {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var progressSlider: UISlider!

    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!

    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var repeatButton: UIButton!

    @IBOutlet weak var volumeDown: UIButton!
    @IBOutlet weak var volumeUp: UIButton!
    @IBOutlet weak var volumeSlider: UISlider!

    private let tracks: [Track] = [
        Track(title: "Четырнадцать", artist: "Rem Digga", coverName: "cover", fileName: "track1.mp3"),
        Track(title: "Из окон", artist: "Rem Digga", coverName: "cover", fileName: "track2.mp3"),
        Track(title: "Танцы на краю", artist: "Rem Digga", coverName: "cover", fileName: "track3.mp3"),
        Track(title: "Я или он", artist: "Rem Digga", coverName: "cover", fileName: "track4.mp3"),
        Track(title: "Тринадцатый", artist: "Rem Digga", coverName: "cover", fileName: "track5.mp3"),
        Track(title: "На юг", artist: "Rem Digga", coverName: "cover", fileName: "track6.mp3"),
        Track(title: "Тюльпан", artist: "Rem Digga", coverName: "cover", fileName: "track7.mp3")
    ]

    private let playback = PlaybackManager()
    private var timer: Timer?
    private var currentIndex = 0 { didSet { if currentIndex < 0 { currentIndex = tracks.count - 1 } else if currentIndex >= tracks.count { currentIndex = 0 } } }
    
    private var isShuffling = false { didSet { updateShuffleUI() } }
    private var repeatMode: RepeatMode = .off { didSet { updateRepeatUI() } }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureVolume()
        configureButtons()
        loadTrack(at: currentIndex, autoPlay: false)
    }

    private func configureUI() {
        progressSlider.minimumValue = 0
        currentTimeLabel.text = "0:00"
        durationLabel.text = "0:00"
    }

    private func configureVolume() {
        volumeSlider.minimumValue = 0
        volumeSlider.maximumValue = 1
        volumeSlider.value = 0.7
        playback.setVolume(0.7)
    }

    private func configureButtons() {
        prevButton.setImage(UIImage(systemName: "backward.fill"), for: .normal)
        nextButton.setImage(UIImage(systemName: "forward.fill"), for: .normal)
        playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)

        shuffleButton.setImage(UIImage(systemName: "shuffle"), for: .normal)
        updateRepeatUI()
    }

    private func loadTrack(at index: Int, autoPlay: Bool) {
        let t = tracks[index]
        titleLabel.text = t.title
        artistLabel.text = t.artist
        
        coverImageView.image = UIImage(named: t.coverName)
        
        do {
            try playback.load(fileName: t.fileName)
            progressSlider.maximumValue = Float(playback.duration)
            durationLabel.text = formatTime(playback.duration)
            currentTimeLabel.text = "0:00"
            progressSlider.value = 0

            autoPlay ? play() : setPlayButton(false)
        } catch {
            print("Ошибка загрузки файла:", t.fileName)
        }
    }

    private func play() {
        playback.play()
        setPlayButton(true)
        startTimer()
    }

    private func pause() {
        playback.pause()
        setPlayButton(false)
        stopTimer()
    }

    private func setPlayButton(_ playing: Bool) {
        let name = playing ? "pause.fill" : "play.fill"
        playPauseButton.setImage(UIImage(systemName: name), for: .normal)
    }

    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.progressSlider.value = Float(self.playback.currentTime)
            self.currentTimeLabel.text = self.formatTime(self.playback.currentTime)
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    private func formatTime(_ t: Double) -> String {
        let m = Int(t) / 60
        let s = Int(t) % 60
        return String(format: "%d:%02d", m, s)
    }

    // MARK: - ACTIONS

    @IBAction func prevTapped(_ sender: UIButton) {
        currentIndex -= 1
        loadTrack(at: currentIndex, autoPlay: playback.isPlaying)
    }

    @IBAction func playPauseTapped(_ sender: UIButton) {
        playback.isPlaying ? pause() : play()
    }

    @IBAction func nextTapped(_ sender: UIButton) {
        currentIndex += 1
        loadTrack(at: currentIndex, autoPlay: playback.isPlaying)
    }

    @IBAction func shuffleTapped(_ sender: UIButton) {
        isShuffling.toggle()
    }

    @IBAction func repeatTapped(_ sender: UIButton) {
        repeatMode = repeatMode.next
    }

    @IBAction func progressSliderChanged(_ sender: UISlider) {
        playback.seek(to: Double(sender.value))
        currentTimeLabel.text = formatTime(Double(sender.value))
    }

    @IBAction func volumeSliderChanged(_ sender: UISlider) {
        playback.setVolume(sender.value)
    }

    @IBAction func volumeDownTapped(_ sender: UIButton) {
        volumeSlider.value = max(0, volumeSlider.value - 0.1)
        playback.setVolume(volumeSlider.value)
    }

    @IBAction func volumeUpTapped(_ sender: UIButton) {
        volumeSlider.value = min(1, volumeSlider.value + 0.1)
        playback.setVolume(volumeSlider.value)
    }

    private func updateShuffleUI() {
        shuffleButton.tintColor = isShuffling ? .systemBlue : .label
    }

    private func updateRepeatUI() {
        let symbol = repeatMode == .one ? "repeat.1" : "repeat"
        repeatButton.setImage(UIImage(systemName: symbol), for: .normal)
        repeatButton.tintColor = repeatMode == .off ? .label : .systemBlue
    }
}

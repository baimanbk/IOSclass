import AVFoundation

final class PlaybackManager {
    private var player: AVAudioPlayer?

    var duration: Double { player?.duration ?? 0 }
    var currentTime: Double { player?.currentTime ?? 0 }
    var isPlaying: Bool { player?.isPlaying ?? false }

    var isFinished: Bool {
        guard let p = player else { return true }
        return !p.isPlaying && abs(p.currentTime - p.duration) < 0.1
    }

    func load(fileName: String) throws {
        let ns = fileName as NSString
        let name = ns.deletingPathExtension
        let ext = ns.pathExtension.isEmpty ? "mp3" : ns.pathExtension

        guard let url = Bundle.main.url(forResource: name, withExtension: ext) else {
            throw NSError(domain: "PlaybackManager", code: 1,
                          userInfo: [NSLocalizedDescriptionKey: "File not found: \(fileName)"])
        }

        player = try AVAudioPlayer(contentsOf: url)
        player?.prepareToPlay()
    }

    func play()  { player?.play() }
    func pause() { player?.pause() }

    func seek(to time: Double) {
        guard let p = player else { return }
        player?.currentTime = max(0, min(time, p.duration))
    }

    func setVolume(_ value: Float) {
        player?.volume = value
    }
}

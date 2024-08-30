//
//  VideoPlayerView.swift
//  SwiftUIInfiniteView
//
//  Created by Davidyoon on 8/30/24.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    @Binding var currentId: String
    let bannerModel: BannerModel
    @ObservedObject var playerManager: PlayerManager
    
    @State private var player: AVPlayer?
    
    var body: some View {
        VideoPlayerUIView(player: $player)
            .aspectRatio(contentMode: .fill)
            .onAppear {
                setupPlayer()
            }
            .onChange(of: currentId) { newValue in
                if newValue == bannerModel.id.uuidString {
                    setupPlayer()
                } else {
                    player?.pause()
                    player = nil
                }
            }
            .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: player)
    }
    
    private func setupPlayer() {
        if currentId == bannerModel.id.uuidString {
            player = AVPlayer(url: bannerModel.url)
            playerManager.currentPlayer = player
            player?.play()
        }
    }
}

#Preview {
    VideoPlayerView(currentId: .constant("0000"), bannerModel: .items[0], playerManager: PlayerManager())
}


struct VideoPlayerUIView: UIViewRepresentable {
    @Binding var player: AVPlayer?

    func makeUIView(context: Context) -> UIView {
        return VideoPlayerUIViewInternal(player: $player)
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        if let videoView = uiView as? VideoPlayerUIViewInternal {
            videoView.updatePlayer(player)
        }
    }
}

class VideoPlayerUIViewInternal: UIView {
    private var playerLayer: AVPlayerLayer?
    @Binding var player: AVPlayer?

    init(player: Binding<AVPlayer?>) {
        self._player = player
        super.init(frame: .zero)
        setupPlayer()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupPlayer() {
        playerLayer = AVPlayerLayer()
        playerLayer?.videoGravity = .resize
        layer.addSublayer(playerLayer!)
    }

    func updatePlayer(_ player: AVPlayer?) {
        playerLayer?.player = player
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.playerLayer?.frame = self.bounds
        }
    }
}

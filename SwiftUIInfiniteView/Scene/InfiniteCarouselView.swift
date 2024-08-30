//
//  InfiniteCarouselView.swift
//  SwiftUIInfiniteView
//
//  Created by Davidyoon on 8/30/24.
//

import SwiftUI
import AVKit

struct InfiniteCarouselView: View {
    @State private var currentPage: String = ""
    @State private var listOfBanners: [BannerModel] = BannerModel.items
    @State private var fakedBanners: [BannerModel] = []
    
    @StateObject private var playerManager = PlayerManager()
    
    private let carouselHeight: CGFloat = 500

    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            TabView(selection: $currentPage) {
                ForEach(fakedBanners) { bannerModel in
                    VideoPlayerView(currentId: $currentPage, bannerModel: bannerModel, playerManager: playerManager)
                        .frame(width: size.width, height: carouselHeight)
                        .tag(bannerModel.id.uuidString)
                        .offsetX(currentPage == bannerModel.id.uuidString) { rect in
                            let minX = rect.minX
                            let pageOffset = minX - (size.width * CGFloat(fakeIndex(bannerModel)))
                            let pageProgress = pageOffset / size.width

                            if -pageProgress < 1.0 {
                                if fakedBanners.indices.contains(fakedBanners.count - 1) {
                                    currentPage = fakedBanners[fakedBanners.count - 1].id.uuidString
                                }
                            }

                            if -pageProgress > CGFloat(fakedBanners.count - 1) {
                                if fakedBanners.indices.contains(1) {
                                    currentPage = fakedBanners[1].id.uuidString
                                }
                            }
                        }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: carouselHeight)
            .overlay(alignment: .bottom) {
                PageControl(currentPage: originalIndex(currentPage), totalPage: listOfBanners.count)
                    .offset(y: -5)
            }
        }
        .frame(height: carouselHeight)
        .onAppear {
            guard fakedBanners.isEmpty else { return }

            fakedBanners.append(contentsOf: listOfBanners)

            if var firstBanner = listOfBanners.first, var lastBanner = listOfBanners.last {
                currentPage = firstBanner.id.uuidString

                firstBanner.id = .init()
                lastBanner.id = .init()

                fakedBanners.append(firstBanner)
                fakedBanners.insert(lastBanner, at: 0)
            }
        }
    }

    func fakeIndex(_ of: BannerModel) -> Int {
        fakedBanners.firstIndex(of: of) ?? 0
    }

    func originalIndex(_ id: String) -> Int {
        listOfBanners.firstIndex { banner in
            banner.id.uuidString == id
        } ?? 0
    }
}

#Preview {
    InfiniteCarouselView()
}

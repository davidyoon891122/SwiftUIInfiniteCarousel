//
//  BannerModel.swift
//  SwiftUIInfiniteView
//
//  Created by Davidyoon on 8/30/24.
//

import Foundation

struct BannerModel: Identifiable, Hashable {

    var id = UUID()
    let image: String
    let url: URL

}

extension BannerModel {

    static let items: [Self] = [
        .init(image: "banner1", url: URL(string: "https://dywhtlvtiow1a.cloudfront.net/outputs/jeju_cbr.m3u8")!),
        .init(image: "banner2", url: URL(string: "https://dywhtlvtiow1a.cloudfront.net/outputs/refik+anadol_cbr.m3u8")!)
    ]

}

//
//  PageControl.swift
//  SwiftUIInfiniteView
//
//  Created by Davidyoon on 8/30/24.
//

import SwiftUI

struct PageControl: UIViewRepresentable {

    let currentPage: Int
    let totalPage: Int

    func makeUIView(context: Context) -> UIPageControl {
        let pageControl = UIPageControl()
        pageControl.currentPage = currentPage
        pageControl.numberOfPages = totalPage
        pageControl.backgroundStyle = .prominent
        pageControl.allowsContinuousInteraction = false
        pageControl.isUserInteractionEnabled = false

        return pageControl
    }

    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.numberOfPages = totalPage
        uiView.currentPage = currentPage
    }

}

#Preview {
    PageControl(currentPage: 0, totalPage: 5)
}

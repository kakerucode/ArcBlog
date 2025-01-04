//
//  ArticleView.swift
//  ArcBlog
//
//  Created by 刘翔 on 2025/1/4.
//

import SwiftUI

struct ArticleView: View {
    let url: URL
    var body: some View {
        WebView(url: url)
            .ignoresSafeArea()
    }
}

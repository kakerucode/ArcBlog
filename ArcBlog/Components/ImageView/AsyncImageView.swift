//
//  AsyncImageView.swift
//  ArcBlog
//
//  Created by 刘翔 on 2025/1/3.
//

import SwiftUI

struct AsyncImageView: View {
    let url: URL?
    @State var imageLoader: ImageDownloader = ImageDownloader()
    
    var body: some View {
        VStack {
            if url == nil {
                imagePlaceHolder()
            } else {
                if imageLoader.isLoading {
                    imagePlaceHolder()
                } else if let image: UIImage = imageLoader.image {
                    Image(uiImage: image)
                        .resizable()
                        .cornerRadius(5)
                } else {
                    Text("Failed to load image")
                }
            }
        }
        .onAppear {
            if let url: URL = url {
                imageLoader.loadImage(from: url)
            }
        }
    }
}

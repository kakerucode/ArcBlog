//
//  LoadingView.swift
//  ArcBlog
//
//  Created by 刘翔 on 2025/1/3.
//

import SwiftUI

struct LoadingView: View {
    
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(1...10, id: \.self) { _ in
                    itemView
                }
            }
        }
        .scrollDisabled(true)
    }
    
    private var itemView: some View {
        VStack {
            imagePlaceHolder()
            Text("---------------------------------------------------------------------")
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.caption)
                .lineLimit(2)
            Text("xxxx年xx月xx日")
                .font(.caption2)
                .foregroundStyle(Color.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .redacted(reason: .placeholder)
    }
    
}

struct imagePlaceHolder: View {
    var body: some View {
        Rectangle()
            .foregroundStyle(Color("tag_color"))
            .aspectRatio(16 / 9, contentMode: .fit)
            .frame(height: 140)
            .cornerRadius(5)
    }
}

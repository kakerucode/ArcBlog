//
//  TagListView.swift
//  ArcBlog
//
//  Created by 刘翔 on 2025/1/4.
//

import SwiftUI

struct TagListView: View {
    
    let tags: [String]
    
    var body: some View {
        HStack {
            TagListLayout {
                ForEach(tags, id: \.self) { tag in
                    tagView(tag)
                }
            }
            Spacer()
        }
        
    }

    func tagView(_ tag: String) -> some View {
        Text(tag)
            .font(.caption2)
            .lineLimit(1)
            .padding(.horizontal, 4)
            .padding(.vertical, 1)
            .background(Capsule().foregroundStyle(Color("tag_color")))
    }
}

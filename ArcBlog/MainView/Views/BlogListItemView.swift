//
//  BlogListItemView.swift
//  ArcBlog
//
//  Created by 刘翔 on 2025/1/3.
//

import SwiftUI

struct BlogListItemView: View {
    
    let item: BlogListItem
    private let imageHeight: CGFloat = 140
    private let imageRatio: CGFloat = 16 / 9
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack(spacing: 0) {
            AsyncImageView(url: item.imageURL)
                .aspectRatio(imageRatio, contentMode: .fit)
                .frame(height: imageHeight)
                .clipped()
            Text(item.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.caption)
                .lineLimit(2)
                .padding(.bottom, 2)
            if let tags: [String] = item.labels {
                let filteredTags = tags.filter { !$0.hasPrefix("assign:") } // 过滤掉"assign:z1VhejtzVzeCSXPdCAks5x2p5BUJQhzi4SE"这种数据。不确定label在web是如何映射的。顾临时做这种处理。
                TagListView(tags: filteredTags)
            }
           
            Spacer()
            if let updateAt: String = item.updatedAt,
               let dateString: String = Date.chineseYearMonthDay(fromISO8601DateString: updateAt) {
                Text(dateString)
                    .font(.caption2)
                    .foregroundStyle(Color.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
            }
            
        }
        .onTapGesture {
            path.append(item)
        }
    }
}

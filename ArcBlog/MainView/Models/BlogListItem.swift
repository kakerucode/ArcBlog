//
//  BlogListItem.swift
//  ArcBlog
//
//  Created by 刘翔 on 2025/1/3.
//

import Foundation

let imageHost: String = "https://www.arcblock.io/blog/uploads"

struct BlogListItem: Decodable, Hashable {
    let id: String
    let title: String
    let originLink: String?
    let cover: String?
    let excerpt: String?
    let author: String?
    let topicId: String?
    let boardId: String
    let type: String
    let status: String?
    let parentId: String?
    let pinnedAt: String?
    let featured: String?
    let lastCommentedAt: String?
    let commentCount: Int
    let publishTime: String
    let views: Int?
    let contentVersion: Int?
    let slug: String?
    let accessType: String?
    let deletedAt: String?
    let createdAt: String?
    let updatedAt: String?
    let labels: [String]?
    let locale: String
    
    var imageURL: URL? {
        guard let cover = cover else {
            return nil
        }
        let url: URL? = URL(string: imageHost + cover)
        return url
    }
    
}

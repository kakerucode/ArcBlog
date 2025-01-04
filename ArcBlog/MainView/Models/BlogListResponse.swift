//
//  BlogListResponse.swift
//  ArcBlog
//
//  Created by 刘翔 on 2025/1/2.
//

import Foundation

struct BlogListResponse: Decodable {
    let latestCommenters: [String]?
    let meta: BlogListMeta?
    let data: [BlogListItem]
    let total: Int
}

struct BlogListMeta: Decodable, Sendable {
    let explicitSlug: Bool?
    let unpublishedChanges: Int?
}


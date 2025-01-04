//
//  BlogListRequest.swift
//  ArcBlog
//
//  Created by 刘翔 on 2025/1/2.
//

import Foundation

struct BlogListRequest: Request {
    var header: [String: Any]?
    var endPoint: EndPoint = .articleList
    var queryItems: [String: Any]? {
        ["page": page,
         "size": size,
         "locale": locale
        ]
    }
    var page: Int
    var size: Int
    var locale: String = "zh"
}

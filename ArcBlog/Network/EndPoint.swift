//
//  BaseURL.swift
//  ArcBlog
//
//  Created by 刘翔 on 2025/1/2.
//

import Foundation

enum EndPoint: String {
    case articleList = "/api/blogs"
    
//    https://www.arcblock.io/blog/api/blogs?page=1&size=20&locale=zh
    
    static let baseHost: String = "https://www.arcblock.io/blog"

    
    var path: URL? {
        guard let baseURL: URL = URL(string: EndPoint.baseHost) else {
            fatalError("Can not set up base url.")
        }
        return baseURL.appending(path: self.rawValue)
    }
}

struct URLParameterEncoder {
    
    func encodeURLParameters(urlRequest: URLRequest, parameters: [String: Any]) {
        
    }
}

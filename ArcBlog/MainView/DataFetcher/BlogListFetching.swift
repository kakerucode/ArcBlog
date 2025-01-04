//
//  BlogListFetching.swift
//  ArcBlog
//
//  Created by 刘翔 on 2025/1/2.
//

import Foundation

protocol BlogListFetching {
    
    func blogListFetcher(page: Int, size: Int) async throws -> BlogListResponse
}

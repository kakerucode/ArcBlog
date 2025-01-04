//
//  blogListFetcher.swift
//  ArcBlog
//
//  Created by 刘翔 on 2025/1/2.
//

import Foundation

struct BlogListFetcher: BlogListFetching {
  
    private let requestSender: RequestSending
    
    init(requestSender: RequestSending = RequestSender()) {
        self.requestSender = requestSender
    }
  
    func blogListFetcher(page: Int, size: Int) async throws -> BlogListResponse {
        let request: BlogListRequest = .init(page: page, size: size)
        return try await blogListFetcher(request: request)
    }
    
    private func blogListFetcher(request: BlogListRequest) async throws -> BlogListResponse {
        do {
            let response: BlogListResponse = try await requestSender.fetchData(from: request)
            return response
        } catch {
            throw error
        }
    }
}

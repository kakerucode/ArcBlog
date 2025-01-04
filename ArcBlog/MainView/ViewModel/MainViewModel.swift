//
//  MainViewModel.swift
//  ArcBlog
//
//  Created by 刘翔 on 2025/1/2.
//

import Foundation

@Observable
class MainViewModel {
    
    private let fetcher: BlogListFetching
    private var currentPage: Int = 1
    private let size: Int = 20

    private var response: BlogListResponse?
    private(set) var viewState: ViewState = .loading
    private var isLoadingMoreData: Bool = false
    
    private var totalCount: Int {
        response?.total ?? 0
    }
    
    private var isNextPageAvailable: Bool {
        blogListItems.count < totalCount
    }
    
    var blogListItems: [BlogListItem] = []
    var lastButOneID: String? {
        guard blogListItems.count > 1 else { return nil }
        return blogListItems[blogListItems.count - 2].id
    }
    
    init(fetcher: BlogListFetching) {
        self.fetcher = fetcher
    }
    
    func loadData() async {
        viewState = .loading
        currentPage = 1
        do {
            response = try await fetcher.blogListFetcher(page: 1, size: size)
            blogListItems = response?.data ?? []
            viewState = .success
        } catch {
            debugPrint(error.localizedDescription)
            viewState = .failure
        }
    }
    
    @MainActor
    func loadNextPageData() async {
        if isNextPageAvailable {
            currentPage += 1
            isLoadingMoreData = true
            do {
                let response: BlogListResponse = try await fetcher.blogListFetcher(page: currentPage, size: size)
                blogListItems.append(contentsOf: response.data)
                isLoadingMoreData = false
            } catch {
                isLoadingMoreData = false
                debugPrint(error.localizedDescription)
            }
        }
    }
}

enum ViewState {
    case loading
    case success
    case failure
    case noData
}

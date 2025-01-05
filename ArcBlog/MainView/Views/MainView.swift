//
//  ContentView.swift
//  ArcBlog
//
//  Created by 刘翔 on 2025/1/2.
//

import SwiftUI

struct MainView: View {
    @State private var viewModel: MainViewModel = MainViewModel(fetcher: BlogListFetcher())
    @State private var path: NavigationPath = .init()
    @State private var position: ScrollPosition = .init(idType: String.self)
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                switch viewModel.viewState {
                case .loading:
                    LoadingView()
                        .padding(.horizontal, 16)
                case .success:
                    contentView(item: viewModel.blogListItems) 
                case .failure:
                    networkFailureView
                case .noData:
                    networkFailureView
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationDestination(for: BlogListItem.self) { item in
                if let slug: String = item.slug,
                   let baseURL: URL = URL(string: EndPoint.baseHost)?.appending(path: "/zh") {
                    ArticleView(url: baseURL.appending(path: slug))
                        .navigationTitle(item.title)
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("logo-rect")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
            .onChange(of: position) { oldValue, newValue in
                if newValue.viewID(type: String.self) == viewModel.lastButOneID {
                    debugPrint("scroll to bottom")
                    Task {
                        await viewModel.loadNextPageData()
                    }
                }
            }
        }
        .task {
            await viewModel.loadData()
        }
    }
    
    private func contentView(item: [BlogListItem]) -> some View {
        let columns = [GridItem(.flexible()), GridItem(.flexible())]
       
        return ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.blogListItems, id: \.self.id) { item in
                    BlogListItemView(item: item, path: $path)
                }
            }
            .scrollTargetLayout()
            .padding(.horizontal, 16)
        }
        .scrollPosition($position, anchor: .bottom)
        .refreshable {
            await viewModel.loadData()
        }
    }
    
    private var networkFailureView: some View {
        VStack(alignment: .center) {
            Text("A network issue has been encountered, please tap retry.")
                .multilineTextAlignment(.center)
            Button {
                Task {
                    await viewModel.loadData()
                }
            } label: {
                Text("Retry")
                    .font(.title)
                    .foregroundStyle(Color.black)
                    .padding()
            }
           
        }
        .frame(maxHeight: .infinity)
        
    }
}


#Preview {
    MainView()
}

//
//  RequestSender.swift
//  ArcBlog
//
//  Created by 刘翔 on 2025/1/2.
//

import Foundation

struct RequestSender: RequestSending {

    private let session: URLSession
    private let timeoutInterval: TimeInterval = 15.0
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchData<T>(from request: any Request) async throws -> T where T : Decodable {
        do {
            let urlRequest: URLRequest = try encode(request: request)
            let (data, urlResponse) = try await session.data(for: urlRequest)
            if let httpResponse: HTTPURLResponse = urlResponse as? HTTPURLResponse, httpResponse.statusCode == 200 {
                let decodeData: T = try JSONDecoder().decode(T.self, from: data)
                return decodeData
            } else {
                throw NetworkError.requestError
            }
        } catch let error {
            throw error
        }
    }
    
    private func encode(request: Request) throws -> URLRequest {
        guard let requestURL: URL = request.endPoint.path else {
            throw NetworkError.requestMissed
        }
        var urlRequest: URLRequest = URLRequest(url: requestURL, timeoutInterval: timeoutInterval)
        if var urlComponent: URLComponents = URLComponents(url: requestURL, resolvingAgainstBaseURL: false), let queryItems = request.queryItems {
            urlComponent.queryItems = [URLQueryItem]()
            for (key, value) in queryItems {
                
                let queryItem: URLQueryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponent.queryItems?.append(queryItem)
            }
            debugPrint(urlComponent.url ?? "Empty url")
            urlRequest.url = urlComponent.url
        }
        return urlRequest
    }
    
}

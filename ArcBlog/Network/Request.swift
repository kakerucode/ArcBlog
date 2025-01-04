//
//  Request.swift
//  ArcBlog
//
//  Created by 刘翔 on 2025/1/2.
//

import Foundation

protocol Request {
    var endPoint: EndPoint { get }
    var httpMethod: HTTPMethod { get }
    var queryItems: [String: Any]? { get }
    var header: [String: Any]? { set get }
    var body: Codable? { set get }
}

extension Request {
    var httpMethod: HTTPMethod {
        .get
    }
    var queryItems: [String: Any]? {
        nil
    }
    var header: [String: Any]? {
        get {
            nil
        }
        set {
            header = newValue
        }
    }
    var body: Codable? {

        get {
            nil
        }
        set {
            body = newValue
        }
    }
}

//
//  Endpoint.swift
//  SuperApp
//
//  Created by Abimanyu Pramukti on 22/08/23.
//

import Foundation
import Then

protocol Endpoint {
    var host: String { get set }
    var path: String { get set }
    var queryItems: [URLQueryItem] { get set }
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("invalid URL components: \(components)")
        }
        return url
    }
}

//
//  OpenDotaEndpoint.swift
//  SuperApp
//
//  Created by Abimanyu Pramukti on 23/08/23.
//

import Foundation

struct OpenDotaEndpoint: Endpoint {
    var host: String = "api.opendota.com"
    var path: String
    var queryItems: [URLQueryItem]
}

extension OpenDotaEndpoint {
    static var heroStats: OpenDotaEndpoint {
        OpenDotaEndpoint(path: "/api/heroStats", queryItems: [])
    }
    
    static var heroes: OpenDotaEndpoint {
        OpenDotaEndpoint(path: "/api/heroes", queryItems: [])
    }
    
    static func image(path: String) -> OpenDotaEndpoint {
        let formattedPath = path.replacingOccurrences(of: "?", with: "")
        return OpenDotaEndpoint(path: formattedPath, queryItems: [])
    }
}

//
//  OpenDotaAPIService.swift
//  SuperApp
//
//  Created by Abimanyu Pramukti on 18/08/23.
//

import Foundation

struct OpenDotaAPIService {
    
    private let session = URLSession.shared
    
    func fetch(_ openDotaEndpoint: OpenDotaEndpoint, completionHandler: @escaping URLSession.Handler) {
        session.dataTask(openDotaEndpoint, completionHandler: completionHandler)
    }
    
    func fetchPublisher(_ openDotaEndpoint: OpenDotaEndpoint, completionHandler: @escaping URLSession.Handler) -> URLSession.DataTaskPublisher {
        session.dataTaskPublisher(openDotaEndpoint)
    }
}

//
//  UIKit+Extensions.swift
//  SuperApp
//
//  Created by Abimanyu Pramukti on 11/08/23.
//

import UIKit
import Combine

extension UIView {
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach{ addSubview($0) }
    }
}

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach{ addArrangedSubview($0) }
    }
}

extension UIImageView {
    func setImage(from endPoint: Endpoint) {
        URLSession.shared.dataTask(endPoint) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
                
            case .failure(let error):
                print("image data not found: \(error.localizedDescription)")
            }
        }
    }
}

extension URLSession {
    typealias Handler = (Result<Data, Error>) -> Void
    
    func dataTask(_ endPoint: Endpoint, completionHandler: @escaping Handler) {
        dataTask(with: endPoint.url) { data, response, error in
            if let error = error {
                completionHandler(.failure(error))
                
            } else if let httpResponse = response as? HTTPURLResponse {
                
                guard let data = data, httpResponse.statusCode == 200 else {
                    let error = NSError(domain: httpResponse.description, code: httpResponse.statusCode)
                    completionHandler(.failure(error))
                    return
                }
                
                completionHandler(.success(data))
                
            } else {
                let error = NSError(domain: "invalid url response", code: 0)
                completionHandler(.failure(error))
            }
        }.resume()
    }
    
    func dataTaskPublisher(_ endPoint: Endpoint) -> URLSession.DataTaskPublisher {
        dataTaskPublisher(for: endPoint.url)
    }
}

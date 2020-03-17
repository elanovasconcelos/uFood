//
//  Cache.swift
//  uFood
//
//  Created by Elano on 16/03/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

final class Cache: NSObject {
    static let shared = Cache()
    private let cache = NSCache<NSString, UIImage>()
    private let server: RequestImage
    
    init(server: RequestImage = PlaceModel()) {
        self.server = server
    }
    
    func image(for url: URL?, completionHandler: @escaping (Result<UIImage, ServerError>) -> Void) {
        
        guard let url = url else {
            completionHandler(.failure(.url))
            return
        }
        let key = url.absoluteString as NSString
        
        if let oldImage = cache.object(forKey: key) {
            completionHandler(.success(oldImage))
            return
        }
        
        server.image(url: url) { [weak self] (result) in
            switch result {
            case .failure(let error): completionHandler(.failure(error))
            case .success(let newImage):
                self?.cache.setObject(newImage, forKey: key)
                completionHandler(.success(newImage))
            }
        }
    }
}

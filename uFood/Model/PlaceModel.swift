//
//  PlaceModel.swift
//  uFood
//
//  Created by Elano on 12/03/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

final class PlaceModel: NSObject {

    static let basePlaceUrlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
    static let okStatus = "OK"
    
    private let key: String
    
    //MARK: -
    init(key: String = "AIzaSyB8bJvTYtxgxdZlf2yf9TrMNgfHIcq7CYQ") { //TODO: the key should not be here in a real project
        self.key = key
    }
    
    //MARK: -
    func completePlaceUrl(with location: Location, type: RequestPlacesType = .restaurant) -> URL? {
        //TODO: improve configuration, export fields for customisation
        //location=-33.8670522,151.1957362&radius=1500&type=restaurant&keyword=cruise&key=YOUR_API_KEY
        let radius = "&radius=1500"
        let type = "&type=\(type.rawValue)"
        //let keyword = "keyword=restaurant"
        let locationString = "location=\(location.latitude),\(location.longitude)"
        let placeConfigUrlString = locationString + radius + type
        
        return completeUrl(for: PlaceModel.basePlaceUrlString + placeConfigUrlString)
    }
    
    private func completeUrl(for urlString: String) -> URL? {
        let keyString = "&key=\(key)"
        
        return URL(string: urlString + keyString)
    }
    
    private func requestModel<T: Decodable>(url: URL?, completionHandler: @escaping (Result<T, ServerError>) -> Void) {
        request(url: url) { (result) in
            switch result {
            case .failure(let error): completionHandler(.failure(error))
            case .success(let data):
                do {
                    let values = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(.success(values))
                } catch {
                    print("[PlaceModel|requestModel]: \(error.localizedDescription)")
                    completionHandler(.failure(.decoder))
                }
            }
        }
    }
    
    private func request(url: URL?, completionHandler: @escaping (Result<Data, ServerError>) -> Void) {
        guard let url = url else {
            completionHandler(.failure(.url))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completionHandler(.failure(.api))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200..<299 ~= response.statusCode else {
                completionHandler(.failure(.respone))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.noData))
                return
            }
            
            completionHandler(.success(data))
            
        }.resume()
    } 
}

//MARK: - RequestPlaces
extension PlaceModel: RequestPlaces {
    func places(at location: Location, types: [RequestPlacesType] = [.bar, .restaurant, .cafe], completionHandler: @escaping (Result<PlaceResponse, ServerError>) -> Void) {
        var lastError: ServerError?
        var places = [Place]()
        
        let placeDispatchGroup = DispatchGroup()
        let queue = DispatchQueue(label: "\(ThreadHelper.baseQueueName).places", attributes: .concurrent)
        let requestCompletionHandler: (Result<PlaceResponse, ServerError>) -> Void = { result in
            queue.async(flags: .barrier) {
                switch result {
                case .failure(let resultErro): lastError = resultErro
                case .success(let response):
                    if response.status == PlaceModel.okStatus {
                        places.append(contentsOf: response.places)
                    }else {
                        lastError = .status
                    }
                }
                placeDispatchGroup.leave()
            }
        }
        //make a request for each place type
        for type in types {
            placeDispatchGroup.enter()
            queue.async() { [weak self] in
                let url = self?.completePlaceUrl(with: location, type: type)
                self?.requestModel(url: url, completionHandler: requestCompletionHandler)
            }
        }
        //aftet complete all the request, retuns an error or a sorted result
        placeDispatchGroup.notify(queue: .global(qos: .background)) {
            if let error = lastError {
                completionHandler(.failure(error))
                return
            }

            let response = PlaceResponse(places: places.sorted().reversed(), status: PlaceModel.okStatus)
            completionHandler(.success(response))
        }
    }
    
    func details(for placeId: String, completionHandler: @escaping (Result<DetailResponse, ServerError>) -> Void) {
        //https://maps.googleapis.com/maps/api/place/details/json?place_id=ChIJN1t&fields=name,rating&key=YOUR_API_KEY
        let baseDetailsUrl = "https://maps.googleapis.com/maps/api/place/details/json"
        let fields = "&fields=name,rating,address_component,adr_address,photo,vicinity,review,opening_hours"
        let placeIdField = "?place_id=\(placeId)"
        let keyField = "&key=\(key)"
        let url = URL(string: baseDetailsUrl + placeIdField + fields + keyField)
        
        print("url: \(String(describing: url))")
        requestModel(url: url, completionHandler: completionHandler)
    }
}

//MARK: - RequestImage
extension PlaceModel: RequestImage {
    func image(photoReference: String, maxWidth: Int = 750, completionHandler: @escaping (Result<UIImage, ServerError>) -> Void) {
        //https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=CnRtAAAAT&key=YOUR_API_KEY
        
        let baseImageUrl = "https://maps.googleapis.com/maps/api/place/photo"
        let url = URL(string: baseImageUrl + "?maxwidth=\(maxWidth)&photoreference=\(photoReference)&key=\(key)")
        
        request(url: url) { (result) in
            switch result {
            case .failure(let error): completionHandler(.failure(error))
            case .success(let data):
                guard let newImage = UIImage(data: data) else {
                    completionHandler(.failure(.image))
                    return
                }

                completionHandler(.success(newImage))
            }
        }
    }
}

//MARK: - Enum
enum ServerError: Error {
    case api
    case url
    case respone
    case noData
    case decoder
    case image
    case status
}



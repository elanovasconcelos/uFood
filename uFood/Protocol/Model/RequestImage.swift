//
//  RequestImage.swift
//  uFood
//
//  Created by Elano on 12/03/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

protocol RequestImage {
    func image(photoReference: String, maxWidth: Int, completionHandler: @escaping (Result<UIImage, ServerError>) -> Void)
    func image(url: URL?, completionHandler: @escaping (Result<UIImage, ServerError>) -> Void)
}

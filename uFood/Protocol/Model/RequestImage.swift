//
//  RequestImage.swift
//  uFood
//
//  Created by Elano on 12/03/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

protocol RequestImage {
    func image(url: URL?, completionHandler: @escaping (Result<UIImage, ServerError>) -> Void)
}

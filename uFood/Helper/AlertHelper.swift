//
//  AlertHelper.swift
//  uFood
//
//  Created by Elano on 17/03/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

final class AlertHelper: NSObject {
    static func showSimpleAlert(_ controller: UIViewController?, title: String? = nil, message: String, completionHandler: @escaping () -> Void = { })
    {
        ThreadHelper.main {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                completionHandler()
            }))
            
            present(controller: controller, alert: alert)
        }
    }
    
    private static func present(controller: UIViewController?, alert: UIAlertController)
    {
        controller?.present(alert, animated: true, completion: nil)
    }
}

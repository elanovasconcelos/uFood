//
//  ThreadHelper.swift
//  uFood
//
//  Created by Elano on 13/03/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

final class ThreadHelper: NSObject {
    
    static let baseQueueName = "com.elanovasconcelos.uFood"
    
    static func background(function: @escaping () -> Void)
    {
        DispatchQueue.global(qos: .background).async(execute: function)
    }
    
    static func main(function: @escaping () -> Void)
    {
        DispatchQueue.main.async(execute: function)
    }
}

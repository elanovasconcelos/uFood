//
//  UITableViewExtension.swift
//  uFood
//
//  Created by Elano on 14/03/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

extension UITableView {
    func register(nibName: String, forCellReuseIdentifier identifier: String) {
        register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    func register(nibNameAndIdentifier: String) {
        register(nibName: nibNameAndIdentifier, forCellReuseIdentifier: nibNameAndIdentifier)
    }
}

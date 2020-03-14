//
//  CellViewModel.swift
//  uFood
//
//  Created by Elano on 11/03/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

protocol CellViewModel {
    static var cellIdentifier: String { get }
    
    func configure(cell: UITableViewCell)
}

//MARK: -
class Observable<T> {
    var value: T {
        didSet {
            ThreadHelper.main {
                self.valueChanged?(self.value)
            }
        }
    }
    var valueChanged: ((T) -> Void)?
    
    init(_ value: T) {
        self.value = value
    }
}

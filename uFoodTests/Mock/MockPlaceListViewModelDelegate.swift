//
//  MockPlaceListViewModelDelegate.swift
//  uFoodTests
//
//  Created by Elano on 18/03/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit
@testable import uFood

final class MockPlaceListViewModelDelegate: NSObject, PlaceListViewModelDelegate {
    
    private let completionHandler: (MockPlaceListViewModelDelegate) -> Void
    private(set) var callCount = 0
    
    var error: ServerError?

    init(completionHandler: @escaping (MockPlaceListViewModelDelegate) -> Void) {
        self.completionHandler = completionHandler
    }
    
    func placeListViewModel(_ placeListViewModel: PlaceListViewModel, didReceived error: ServerError) {
        self.error = error
        self.callCount += 1
        
        completionHandler(self)
    }
}

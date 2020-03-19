//
//  MockRequestLocation.swift
//  uFoodTests
//
//  Created by Elano on 18/03/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit
@testable import uFood

final class MockRequestLocation: NSObject, RequestLocation {
    weak var delegate: RequestLocationDelegate?
    
    private func callDelegate() {
        delegate?.locationModel(self, didChange: Location(latitude: 1, longitude: 2))
    }
    
    func requestWhenInUseAuthorization() {
        callDelegate()
    }
    
    func updateLocation() {
        callDelegate()
    }
    
    func stopUpdateLocation() {
        
    }
}

//
//  PlaceModelTests.swift
//  uFoodTests
//
//  Created by Elano on 13/03/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import XCTest
@testable import uFood

class PlaceModelTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRequestPlace() {
        let expectation = self.expectation(description: "places")
        let location = Location(latitude: -33.8670522, longitude: 151.1957362)
        let placeModel = PlaceModel()
        
        placeModel.places(at: location) { (result) in
            switch result {
            case .failure(let error): XCTAssertTrue(false, "error received: \(error)")
            case .success(let result):
                XCTAssertEqual(result.status, PlaceModel.okStatus)
                XCTAssertFalse(result.places.isEmpty)
                
                if !result.places.isEmpty {
                    let place = result.places[0]
                    
                    XCTAssertFalse(place.address.isEmpty)
                    XCTAssertFalse(place.name.isEmpty)
                    XCTAssertFalse(place.photos.isEmpty)
                    XCTAssertTrue(place.rating > 0)
                    
                    if let lastRating = result.places.last?.rating {
                        XCTAssertTrue(place.rating > lastRating)
                    }
                }
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

}

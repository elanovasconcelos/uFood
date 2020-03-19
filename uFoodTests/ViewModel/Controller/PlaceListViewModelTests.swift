//
//  PlaceListViewModelTests.swift
//  uFoodTests
//
//  Created by Elano on 18/03/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import XCTest
@testable import uFood

class PlaceListViewModelTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testModels() {
        let expectation = self.expectation(description: "models")
        let viewModel = newPlaceListViewModel()
        
        viewModel.cellModels.valueChanged = { models in
            XCTAssertEqual(models.count, 10)
            
            expectation.fulfill()
        }
        
        viewModel.requestLocation()
        
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testGetError() {
        let expectation = self.expectation(description: "delegate")
        let viewModel = newPlaceListViewModel(returnError: true)
        let mockDelegate = MockPlaceListViewModelDelegate() { delegate in
            XCTAssertEqual(delegate.callCount, 1)
            XCTAssertEqual(delegate.error, ServerError.api)
            
            expectation.fulfill()
        }
        
        viewModel.delegate = mockDelegate
        viewModel.requestLocation()
        
        waitForExpectations(timeout: 1, handler: nil)
    }

    private func newPlaceListViewModel(returnError: Bool = false) -> PlaceListViewModel {
        return PlaceListViewModel(server: MockRequestPlaces(returnError: returnError), location: MockRequestLocation())
    }
}

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
                    
                    XCTAssertFalse(place.placeId.isEmpty)
                    XCTAssertFalse(place.address.isEmpty)
                    XCTAssertFalse(place.name.isEmpty)
                    XCTAssertFalse(place.photos?.isEmpty ?? true)
                    XCTAssertNotNil(place.rating)
                    
                    if let rating = place.rating {
                        XCTAssertTrue(rating > 0)
                    }

                    if let rating = place.rating,
                       let lastRating = result.places.last?.rating {
                        XCTAssertTrue(rating > lastRating)
                    }
                }
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testRequestImage() {
        let photoReference = "CnRtAAAATLZNl354RwP_9UKbQ_5Psy40texXePv4oAlgP4qNEkdIrkyse7rPXYGd9D_Uj1rVsQdWT4oRz4QrYAJNpFX7rzqqMlZw2h2E2y5IKMUZ7ouD_SlcHxYq1yL4KbKUv3qtWgTK0A6QbGh87GB3sscrHRIQiG2RrmU_jF4tENr9wGS_YxoUSSDrYjWmrNfeEHSGSc3FyhNLlBU"
        let expectation = self.expectation(description: "image")
        let placeModel = PlaceModel()
        
        placeModel.image(photoReference: photoReference) { (result) in
            switch result {
            case .failure(let error): XCTAssertTrue(false, "error received: \(error)")
            case .success(let image):
                XCTAssertNotNil(image.jpegData(compressionQuality: 1))
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testRequestDetail() {
        let placeId = "ChIJN1t_tDeuEmsRUsoyG83frY4"
        let expectation = self.expectation(description: "detail")
        let placeModel = PlaceModel()
        
        placeModel.details(for: placeId) { (result) in
            switch result {
            case .failure(let error): XCTAssertTrue(false, "error received: \(error)")
            case .success(let result):
                let place = result.place
                
                XCTAssertFalse(place.placeId.isEmpty)
                XCTAssertEqual(result.status, PlaceModel.okStatus)
                XCTAssertFalse(place.address.isEmpty)
                XCTAssertFalse(place.name.isEmpty)
                XCTAssertFalse(place.photos?.isEmpty ?? true)
                XCTAssertNotNil(place.reviews)
                XCTAssertNotNil(place.rating)
                
                if let rating = place.rating {
                    XCTAssertTrue(rating > 0)
                }
                
                if let reviews = place.reviews {
                    XCTAssertFalse(reviews.isEmpty)
                }
                
                if let review = place.reviews?.first {
                    XCTAssertFalse(review.authorName.isEmpty)
                    XCTAssertFalse(review.profilePhotoUrl.isEmpty)
                    XCTAssertFalse(review.relativeTimeDescription.isEmpty)
                    XCTAssertFalse(review.text.isEmpty)
                    XCTAssertTrue(review.rating > 0)
                }
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
}

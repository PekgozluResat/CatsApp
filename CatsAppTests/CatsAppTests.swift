//
//  CatsAppTests.swift
//  CatsAppTests
//
//  Created by Resat Pekgozlu on 16/02/2024.
//

import XCTest
@testable import CatsApp

final class CatsAppTests: XCTestCase {

    var viewController: CatListViewController!
        
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "CatListViewController") as? CatListViewController
        viewController.loadViewIfNeeded()
    }
               
    override func tearDown() {
       
        viewController = nil
        super.tearDown()
    }

    func testExample() throws {
        
        // Create an expectation for a network request
        let expectation = XCTestExpectation(description: "Fetch cat breeds")
                               
        // Call the fetchCatBreeds method
        viewController.fetchCatBreeds()
                               
        // Wait for a response for a reasonable amount of time
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            // Check if catBreeds array is not empty after fetching
            XCTAssertFalse(self.viewController.catBreeds.isEmpty, "Cat breeds array should not be empty after fetching")
                    
            // Fulfill the expectation
            expectation.fulfill()
        }
               
        // Wait until the expectation is fulfilled or timeout occurs
        wait(for: [expectation], timeout: 10.0)
    }
}

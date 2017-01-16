//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Hiromichi Ema on 2017/01/12.
//  Copyright © 2017年 Hiromichi Ema. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    
    // MARK: Meal Class Tests
    
    // Confirm that the Meal initializer returns a Meal object when passed valid paramaters
    func testMealInitializationSucceeds(){
        let zeroRatingMeal = Meal.init(name: "Zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRatingMeal)
        
        let highestRatingMeal = Meal.init(name: "Positive", photo: nil, rating: 5)
        XCTAssertNotNil(highestRatingMeal)
    }
    
    // Confirm that the Meal initializer returns nil when passed a negative raiting pr a empty name
    func testMealInitializationFailds(){
        let negativeRatingMeal = Meal.init(name: "Negative", photo: nil, rating: -1)
        XCTAssertNil(negativeRatingMeal)
        
        let largeRatingMeal = Meal.init(name: "Large", photo: nil, rating: 6)
        XCTAssertNil(largeRatingMeal)
        
        let emptyRatingMeal = Meal.init(name: "", photo: nil, rating: 0)
        XCTAssertNil(emptyRatingMeal)
    }
}

//
//  NearbySearchTests.swift
//  NearbySearchTests
//
//  Created by Michal Iwanski on 19/03/2020.
//  Copyright © 2020 michalronin.com. All rights reserved.
//

import XCTest
@testable import NearbySearch

class NearbySearchTests: XCTestCase {

    override func setUp() {
        
    }

    override func tearDown() {
        
    }
    
    func testDecoding() throws {
        let bundle = Bundle(for: type(of: self))
        let fileUrl = bundle.url(forResource: "places", withExtension: "json")
        let data = try Data(contentsOf: fileUrl!)
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        XCTAssertNoThrow(try jsonDecoder.decode(GoogleResponse.self, from: data))
    }
}

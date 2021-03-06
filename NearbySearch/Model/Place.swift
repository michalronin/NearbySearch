//
//  Place.swift
//  NearbySearch
//
//  Created by Michal Iwanski on 15/03/2020.
//  Copyright © 2020 michalronin.com. All rights reserved.
//

import Foundation

struct GoogleResponse: Codable {
    let results: [Place]
    
    struct Place: Codable {
        let name: String
        let rating: Double
        var openingHours: OpeningHours?
        var photos: [Photo]?
        let vicinity: String
        
        struct OpeningHours: Codable {
            let openNow: Bool
        }
        
        struct Photo: Codable {
            let photoReference: String
        }
    }
    
    
}





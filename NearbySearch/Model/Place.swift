//
//  Place.swift
//  NearbySearch
//
//  Created by Michal Iwanski on 15/03/2020.
//  Copyright © 2020 michalronin.com. All rights reserved.
//

import Foundation

struct GoogleResponse: Codable, Hashable {
    let results: [Place]
    
    struct Place: Codable, Hashable {
        let name: String
        let rating: Double
        var openingHours: OpeningHours?
        var photos: [Photo]?
        let vicinity: String
        
        struct OpeningHours: Codable, Hashable {
            let openNow: Bool
        }
        
        struct Photo: Codable, Hashable {
            let photoReference: String
        }
    }
    
    
}





//
//  Place.swift
//  NearbySearch
//
//  Created by Michal Iwanski on 15/03/2020.
//  Copyright © 2020 michalronin.com. All rights reserved.
//

import Foundation

struct Place: Codable {
    let name: String
    let rating: Int
    let openingHours: OpeningHours
}

struct OpeningHours: Codable {
    let openNow: Bool
}

//
//  PlaceDetailViewController.swift
//  NearbySearch
//
//  Created by Michal Iwanski on 16/03/2020.
//  Copyright © 2020 michalronin.com. All rights reserved.
//

import UIKit

class PlaceDetailViewController: UIViewController {
    var place: GoogleResponse.Place!

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
    }
}

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
    var placeImageView = PlaceImageView(frame: .zero)

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
        adjustLargeTitleSize()
        guard let photo = place.photos?.first?.photoReference else { return }
        placeImageView.downloadImage(from: photo)
        
        view.addSubview(placeImageView)
        let padding: CGFloat = 20
        NSLayoutConstraint.activate([
            placeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            placeImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            placeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            placeImageView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}

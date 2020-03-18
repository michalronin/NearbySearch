//
//  PlaceDetailContainerViewController.swift
//  NearbySearch
//
//  Created by Michal Iwanski on 18/03/2020.
//  Copyright © 2020 michalronin.com. All rights reserved.
//

import UIKit

class PlaceDetailContainerViewController: UIViewController {
    var place: GoogleResponse.Place!
    let locationImageView = UIImageView()
    let locationLabel = BodyLabel(textAlignment: .left)
    let ratingImageView = UIImageView()
    let ratingLabel = BodyLabel(textAlignment: .left)
    let locationStackView = UIStackView()
    let ratingStackView = UIStackView()
    
    init(place: GoogleResponse.Place) {
        super.init(nibName: nil, bundle: nil)
        self.place = place
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStackViews()
        configureConstraints()
        configureUIElements()
    }
    
    private func configureStackViews() {
        locationStackView.translatesAutoresizingMaskIntoConstraints = false
        ratingStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(locationStackView)
        view.addSubview(ratingStackView)
        locationStackView.addArrangedSubview(locationImageView)
        locationStackView.addArrangedSubview(locationLabel)
        ratingStackView.addArrangedSubview(ratingImageView)
        ratingStackView.addArrangedSubview(ratingLabel)
        
        locationStackView.axis = .horizontal
        locationStackView.distribution = .fillProportionally
        locationStackView.alignment = .center
        locationStackView.spacing = 16
        
        ratingStackView.axis = .horizontal
        ratingStackView.distribution = .fillProportionally
        ratingStackView.alignment = .center
        ratingStackView.spacing = 16
    }
    
    let padding: CGFloat = 20
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            
            ratingImageView.widthAnchor.constraint(equalToConstant: 20),
            ratingImageView.heightAnchor.constraint(equalToConstant: 20),
            
            ratingStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            ratingStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            ratingStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            ratingStackView.heightAnchor.constraint(equalToConstant: 30),
            
            locationStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            locationStackView.topAnchor.constraint(equalTo: ratingStackView.bottomAnchor, constant: padding),
            locationStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            locationStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding)
        ])
    }
    
    private func configureUIElements() {
        if #available(iOS 13.0, *) {
            locationImageView.image = UIImage(systemName: "mappin.and.ellipse")
        } else {
            // Fallback on earlier versions
        }
        locationLabel.text = place.name // TODO: replace to actual address
        if #available(iOS 13.0, *) {
            ratingImageView.image = UIImage(systemName: "star")
        } else {
            // Fallback on earlier versions
        }
        ratingLabel.text = "Overall ratings: \(String(place.rating))"
    }
}

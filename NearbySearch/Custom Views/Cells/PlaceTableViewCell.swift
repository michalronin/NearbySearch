//
//  PlaceTableViewCell.swift
//  NearbySearch
//
//  Created by Michal Iwanski on 15/03/2020.
//  Copyright © 2020 michalronin.com. All rights reserved.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {
    static let reuseID = "PlaceCell"
    let nameLabel = TitleLabel(textAlignment: .left, fontSize: 16)
    let openNowLabel = BodyLabel(textAlignment: .left)
    let ratingLabel = BodyLabel(textAlignment: .center)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
        selectionStyle = .none
        configureNameLabel()
        configureStackView()
    }
    
    func set(place: GoogleResponse.Place) {
        nameLabel.text = place.name
        if let openNow = place.openingHours?.openNow {
            openNowLabel.text = openNow ? "Open now" : "Closed now"
            openNowLabel.textColor = openNow ? .systemGreen : .systemRed
        } else {
            openNowLabel.text = "Unknown"
        }
        
        ratingLabel.text = "Rating: \(String(place.rating))"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureNameLabel() {
        addSubview(nameLabel)
        
        let padding: CGFloat = 8
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            nameLabel.widthAnchor.constraint(equalTo: widthAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func configureStackView() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 16
        
        stackView.addArrangedSubview(openNowLabel)
        stackView.addArrangedSubview(ratingLabel)
        
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 8
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            stackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding),
            stackView.widthAnchor.constraint(equalTo: widthAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ])
    }
}


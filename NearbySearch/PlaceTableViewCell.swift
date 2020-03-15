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
    let ratingLabel = BodyLabel(textAlignment: .left)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureNameLabel()
    }
    
    func set(place: Place) {
        nameLabel.text = place.name
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
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 8
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            stackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding),
            stackView.widthAnchor.constraint(equalTo: widthAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}


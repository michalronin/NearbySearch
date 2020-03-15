//
//  SearchViewController.swift
//  NearbySearch
//
//  Created by Michal Iwanski on 15/03/2020.
//  Copyright © 2020 michalronin.com. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    let searchLabel = TitleLabel(textAlignment: .center, fontSize: 24)
    let searchButton = SearchButton(backgroundColor: .systemTeal, title: "Search Nearby")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @objc func pushPlacesListViewController() {
        let placesListVC = PlacesListViewController()
        placesListVC.title = "Nearby Places"
        navigationController?.pushViewController(placesListVC, animated: true)
    }
    
    private func configure() {
        view.addSubview(searchLabel)
        view.addSubview(searchButton)
        searchLabel.text = "Tap the button to find Places of Interest near you!"
        searchLabel.numberOfLines = 2
        
        let padding: CGFloat = 12
        NSLayoutConstraint.activate([
            searchLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            searchLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            searchLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            searchButton.topAnchor.constraint(equalTo: searchLabel.bottomAnchor, constant: padding),
            searchButton.centerXAnchor.constraint(equalTo: searchLabel.centerXAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 200),
            searchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

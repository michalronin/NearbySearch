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
    let detailView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureImageView()
        layoutUI()
        DispatchQueue.main.async {
            self.add(childVC: PlaceDetailContainerViewController(place: self.place), to: self.detailView)
        }
    }
    
    private func configureImageView() {
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        adjustLargeTitleSize()
        guard let photo = place.photos?.first?.photoReference else { return }
        placeImageView.downloadImage(from: photo)
        
        
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    func layoutUI() {
        view.addSubview(placeImageView)
        view.addSubview(detailView)
        let padding: CGFloat = 20
        detailView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            detailView.backgroundColor = .secondarySystemBackground
        } else {
            detailView.backgroundColor = .lightGray
        }
        detailView.layer.cornerRadius = 20
        NSLayoutConstraint.activate([
            placeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            placeImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            placeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            placeImageView.heightAnchor.constraint(equalToConstant: 300),
            
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            detailView.topAnchor.constraint(equalTo: placeImageView.bottomAnchor, constant: padding),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            detailView.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
}

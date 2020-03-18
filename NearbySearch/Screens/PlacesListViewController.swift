//
//  PlacesListViewController.swift
//  NearbySearch
//
//  Created by Michal Iwanski on 15/03/2020.
//  Copyright © 2020 michalronin.com. All rights reserved.
//

import UIKit
import CoreLocation

class PlacesListViewController: UIViewController {
    var locationManager: CLLocationManager?
    var currentLocation: CLLocation?
    var tableView: UITableView!
    
    var places: [GoogleResponse.Place] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        configureLocationManager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func configureViewController() {
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        if #available(iOS 13.0, *) {
            tableView.backgroundColor = .systemBackground
        } else {
            tableView.backgroundColor = .white
        }
        tableView.register(PlaceTableViewCell.self, forCellReuseIdentifier: PlaceTableViewCell.reuseID)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func configureLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        locationManager?.distanceFilter = 50
        locationManager?.requestLocation()
    }
    
    func pushPlaceDetailViewController(place: GoogleResponse.Place) {
        let detailVC = PlaceDetailViewController()
        detailVC.place = place
        detailVC.title = place.name
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func getPlaces(for location: CLLocation) {
        showLoadingView()
        NetworkManager.shared.getPlaces(for: location, type: .restaurant) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let places):
                self.places.append(contentsOf: places)
                self.places.sort { $0.rating > $1.rating }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                
            }
        }
        
        NetworkManager.shared.getPlaces(for: location, type: .bar) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let places):
                self.places.append(contentsOf: places)
                self.places.sort { $0.rating > $1.rating }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
        
        NetworkManager.shared.getPlaces(for: location, type: .cafe) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let places):
                self.places.append(contentsOf: places)
                self.places.sort { $0.rating > $1.rating }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}

// MARK: - UITableViewDataSource && UITableViewDelegate
extension PlacesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlaceTableViewCell.reuseID) as! PlaceTableViewCell
        cell.set(place: places[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushPlaceDetailViewController(place: places[indexPath.row])
    }
}

// MARK: - CLLocationManagerDelegate
extension PlacesListViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         print("error: \(error.localizedDescription)")
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager?.requestLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.first != nil {
            currentLocation = locations.first
            getPlaces(for: currentLocation!)
        }
    }
}

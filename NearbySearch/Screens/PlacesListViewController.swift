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
        locationManager?.startUpdatingLocation()
    }
    
    func getPlaces(for location: CLLocation) {
        NetworkManager.shared.getPlaces(for: location) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let places):
                self.places = places
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error loading: \(error.rawValue)")
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
}

// MARK: - CLLocationManagerDelegate
extension PlacesListViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         print("error: \(error.localizedDescription)")
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
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

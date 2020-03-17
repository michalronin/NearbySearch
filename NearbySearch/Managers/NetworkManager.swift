//
//  NetworkManager.swift
//  NearbySearch
//
//  Created by Michal Iwanski on 15/03/2020.
//  Copyright © 2020 michalronin.com. All rights reserved.
//

import UIKit
import CoreLocation

class NetworkManager {
    static let shared = NetworkManager()
    let cache = NSCache<NSString, UIImage>()
    
    private let apiKey = "&key=AIzaSyDMJixaDksmb__33XzQiTjL3mRjoxcjcek"
    private let baseUrl = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?types=restaurant"
    
    private init() {}
    
    func getPlaces(for location: CLLocation, completed: @escaping (Result<[GoogleResponse.Place], ErrorMessage>) -> Void) {
        let lat = String(location.coordinate.latitude)
        let lon = String(location.coordinate.longitude)
        let endpoint = baseUrl + "&location=" + lat + "," + lon + "&radius=500" + apiKey
        print(endpoint)
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let googleResponse = try decoder.decode(GoogleResponse.self, from: data)
                completed(.success(googleResponse.results))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
}

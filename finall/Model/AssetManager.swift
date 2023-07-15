//
//  AssetManager.swift
//  finall
//
//  Created by רם צמח on 15/07/2023.
//

import Foundation
import CoreLocation

protocol aWeatherManagerDelegate {
    func didUpdate(Manager: AssetManager, weather: [Asset])
    func didFailWithError(error: String)
}

struct AssetManager {
    var WeatherBaseUrl = "https://api.openweathermap.org/data/2.5/weather?appid=4074af71b160b4666319d2632b6992a5&units=metric"
    var delegate: aWeatherManagerDelegate?
    let URL_GET_ALL_MARKETS = "/market/getAllMarkets"
    let URL_BASE = "https://local.inx.services:3010/mobile"
    
    func fetchWeatherByCity(cityName: String){
        let urlString = "\(WeatherBaseUrl)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func fetchMarkets(){
//        let urlString = "https://run.mocky.io/v3/3f4f0344-7207-40ac-aa91-99dbd2e2efbf"
        let urlString = "https://run.mocky.io/v3/d3d275db-c8b6-4b4a-86f0-b05d5038369e"
//        let urlString = "https://run.mocky.io/v3/45fbcbce-dfbb-43c4-bbf3-5e39562f586e"

        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, respons, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: "error!")
                    return
                }
                if let safeData = data {
                    if let response = Asset.parse(json: safeData ) {
                        self.delegate?.didUpdate(Manager: self, weather: response)

                    //    completion(true, response, "")
                        NSLog("Get All Markets service success")
                    }
                }
            }
            task.resume()
        }
    }
}


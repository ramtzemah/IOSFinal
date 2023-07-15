//
//  Manager.swift
//  finall
//
//  Created by רם צמח on 15/07/2023.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdate(Manager: Manager, weather: [Market])
    func didFailWithError(error: String)
}

struct Manager {
    var WeatherBaseUrl = "https://api.openweathermap.org/data/2.5/weather?appid=4074af71b160b4666319d2632b6992a5&units=metric"
    var delegate: WeatherManagerDelegate?
    let URL_GET_ALL_MARKETS = "/market/getAllMarkets"
    let URL_BASE = "https://local.inx.services:3010/mobile"
    
    func fetchWeatherByCity(cityName: String){
        let urlString = "\(WeatherBaseUrl)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func fetchMarkets(){
//        let urlString = "https://run.mocky.io/v3/3f4f0344-7207-40ac-aa91-99dbd2e2efbf"
        let urlString = "https://run.mocky.io/v3/c14cdc89-d231-4f02-b1f6-a4ae6b91138a"
//        let urlString = "https://run.mocky.io/v3/17d19624-15f9-4621-a9fb-bb0d43b52367"
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
                    if let response = Market.parse(json: safeData ) {
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

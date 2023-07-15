//
//  Payload.swift
//  finall
//
//  Created by רם צמח on 15/07/2023.
//

import Foundation

struct Payload: Codable {
    var asset: String?
    var assetName: String?
    var lastPricePercentageChange: Float64?
    var low: Float64?
    var high: Float64?
    var volume: Float64?
    var lastPrice: Float64?
//    var graphData: [GraphData]?
//    var currentHour: GraphData?
//    var removedPointsTimestamps: [GraphData]?
    
    static func parse(json: String) -> Payload? {
        let decoder = JSONDecoder()
        let data = json.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
        do {
            let payload: Payload = try decoder.decode(Payload.self, from: data)
            return payload
        } catch {
            print("Unexpected error: \(error).")
            return nil
        }
    }
}

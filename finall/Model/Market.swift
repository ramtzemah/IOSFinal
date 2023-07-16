//
//  Market.swift
//  finall
//
//  Created by רם צמח on 15/07/2023.
//

import Foundation

struct Market: Codable {
    var _id: String?
    var isActive: Bool?
    var asset1: String?
    var asset2: String?
    var lastPrice: Float64?
    var minOrderQuantity: Float64?
    var maxOrderQuantity: Float64?
    var minOrderPrice: Float64?
    var maxOrderPrice: Float64?
    var maxOrderNotionalValue: Float64?
    var maxPriceDecimals: Int?
    var __v: Float?
    var createdAt: String?
    var updatedAt: String?
    var marketName: String?
    var id: String?
    var iconLink: String?
    var vol: Int?
    var per: Double?

    static func parse(json: Data) -> [Market]? {
        let decoder = JSONDecoder()
       // let data = json.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
        do {
            var vMarkets: [Market] = try decoder.decode([Market].self, from: json)
            for (index, item) in vMarkets.enumerated() {
                vMarkets[index].vol = Int.random(in: 0...3000000)
                let randomPer = Double.random(in: -10.0...10.0)
                vMarkets[index].per = (randomPer * 100).rounded() / 100
            }
            return vMarkets
        } catch {
            print("Unexpected error: \(error).")
            return nil
        }
    }
}

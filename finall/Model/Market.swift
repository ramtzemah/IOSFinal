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

    static func parse(json: Data) -> [Market]? {
        let decoder = JSONDecoder()
       // let data = json.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
        do {
            let vMarkets: [Market] = try decoder.decode([Market].self, from: json)
            return vMarkets
        } catch {
            print("Unexpected error: \(error).")
            return nil
        }
    }
}

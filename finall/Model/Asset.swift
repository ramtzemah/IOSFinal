//
//  Asset.swift
//  finall
//
//  Created by רם צמח on 15/07/2023.
//
import Foundation

enum AssetTypes: String {
    case Crypto = "crypto"
    case Fiat = "fiat"
}

struct Asset: Codable {
    var _id: String?
    var type: String?
    var symbol: String?
    var fullName: String?
    var depositFee: Float64?
    var withdrawFee: Float64?
    var cryptoConfirmationCount: Int?
    var depositThreshold: Float64?
    var exploreLink: String?
    var isERC20Token: Bool?
    // FIXME Do we need this value?
//    var baseUnitMultiplier: Any?
    var minCryptoWithdrawAmount: Float64?
    var cryptoType: String?
    var __v: Int?
    var createdAt: String?
    var updatedAt: String?
    var id: String?
    var decimalPoints: Int?
    var iconLink: String?
    var minFiatWithdrawFee: Float64?
    var minFiatWithdrawAmount: Float64?
    var minFiatDepositAmount: Float64?
    
    static func parse(json: Data) -> [Asset]? {
        let decoder = JSONDecoder()
//        let data = json.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
        do {
            var vAssets: [Asset] = try decoder.decode([Asset].self, from: json)
            for (index, item) in vAssets.enumerated() {
                let newLink = item.iconLink?.replacingOccurrences(of: "/svg/", with: "/png/")
                vAssets[index].iconLink = newLink?.replacingOccurrences(of: ".svg", with: ".png")
            }
            
            return vAssets
        } catch {
            print("Unexpected error: \(error).")
            return nil
        }
    }
    
//    static func getAssetName(code: String?) -> String {
//        if let asset = SessionManager.getAssetsNames().first(where: { item in
//            item.0.lowercased() == code?.lowercased()
//        }) {
//            return asset.1
//        } else {
//            return ""
//        }
//    }
}

//
//  Error.swift
//  finall
//
//  Created by רם צמח on 15/07/2023.
//

import Foundation

struct Error: Codable {
    var status: Int?
    var error: String?
    var msg: String?
    var errorEnum: String?
    
    enum CodingKeys: String, CodingKey {
        case status
        case error
        case msg = "message"
        case errorEnum
    }
    
    static func parse(json: String) -> Error? {
        let decoder = JSONDecoder()
        let data = json.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
        do {
            let error: Error = try decoder.decode(Error.self, from: data)
            return error
        } catch {
            print("Unexpected error: \(error).")
            return nil
        }
    }
}

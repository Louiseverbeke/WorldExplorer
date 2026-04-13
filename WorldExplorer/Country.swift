//
//  Country.swift
//  WorldExplorer
//
//  Created by Louise Verbeke on 13/04/2026.
//
import Foundation

struct Country: Codable, Identifiable {
    let id = UUID().uuidString
    var name: Name
    var flag: String
    
    enum CodingKeys: CodingKey{
        case id, name, flag
    }
}
struct Name: Codable{
    var common: String
}

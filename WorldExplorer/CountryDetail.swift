//
//  CountryDetail.swift
//  WorldExplorer
//
//  Created by Louise Verbeke on 13/04/2026.
//
import Foundation

struct CountryDetail: Codable{
    
    var subregion: String = ""
    var capital: [String] = []
    var flags = Flags()
    var coatOfArms = CoatOfArms()
    
    struct Flags: Codable{
        var png = ""
    }
    struct CoatOfArms: Codable{
        var png: String? = ""
    }
}

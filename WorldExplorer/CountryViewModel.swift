//
//  CountryViewModel.swift
//  WorldExplorer
//
//  Created by Louise Verbeke on 13/04/2026.
//
import Foundation

@MainActor
@Observable
class CountryViewModel{
    var countries: [Country] = []
    var region = "europe"
    var urlString = "https://restcountries.com/v3.1/region/europe"
    
    func getData() async {
        urlString = "https://restcountries.com/v3.1/region/\(region)"
        print("We are accessing the data")
        guard let url = URL(string: urlString) else {
            print("Error accessing Url")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let countries = try? JSONDecoder().decode([Country].self, from: data) else {
                print("JSON Decoding error")
                return
            }
            self.countries = countries
        }catch{
            print("ERROR")
        }
    }
}

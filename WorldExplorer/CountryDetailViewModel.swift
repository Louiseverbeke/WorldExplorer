//
//  CountryDetailViewModel.swift
//  WorldExplorer
//
//  Created by Louise Verbeke on 13/04/2026.
//
import Foundation

@MainActor
@Observable
class CountryDetailViewModel{
    var countryDetail = CountryDetail()
    var countryName = "Germany"
    var urlString = "https://restcountries.com/v3.1/name/south%20africa"
    
    func getData() async {
        urlString = "https://restcountries.com/v3.1/name/\(countryName)"
        print("We are accessing the data")
        guard let url = URL(string: urlString) else {
            print("Error accessing Url")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let countryDetail = try? JSONDecoder().decode([CountryDetail].self, from: data) else {
                print("JSON Decoding error")
                return
            }
            self.countryDetail = countryDetail.first ?? CountryDetail()
        }catch{
            print("ERROR")
        }
    }
}

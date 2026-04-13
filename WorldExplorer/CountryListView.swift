//
//  CountryListView.swift
//  WorldExplorer
//
//  Created by Louise Verbeke on 13/04/2026.
//
import SwiftUI

struct CountryListView: View {
    enum Regions: String, CaseIterable{
        case africa = "Africa"
        case americas = "Americas"
        case asia = "Asia"
        case europe = "Europe"
        case oceania = "Oceania"
    }
    @State private var countryVM = CountryViewModel()
    @State private var selectedRegion: Regions = .europe
    var body: some View {
        NavigationStack{
            HStack{
                Text("Selected region")
                Spacer()
                Picker("", selection: $selectedRegion) {
                    ForEach(Regions.allCases, id: \.self) { region in
                        Text(region.rawValue) 
                    }
                }
                .onChange(of: selectedRegion){
                    Task{
                        countryVM.region = selectedRegion.rawValue
                        await countryVM.getData()
                        countryVM.countries.sort{$0.name.common < $1.name.common}
                    }
                }
            }
            .padding(.horizontal)
            List(countryVM.countries) { country in
                NavigationLink{
                    DetailView(country: country)
                }
                label:{
                    HStack{
                        Text(country.flag)
                        Text(country.name.common)
                    }
                    .font(.title)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Countries:")
            .task{
                await countryVM.getData()
                countryVM.countries.sort{$0.name.common < $1.name.common} // sorting by name
            }
        }
    }
}
#Preview {
    CountryListView()
}

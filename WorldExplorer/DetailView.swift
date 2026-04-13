//
//  DetailView.swift
//  WorldExplorer
//
//  Created by Louise Verbeke on 13/04/2026.
//
import SwiftUI

struct DetailView: View {
    @State var country: Country
    @State private var countryDetailVM = CountryDetailViewModel()
    var body: some View {
        VStack(alignment: .leading){
            Text(country.name.common)
                .fontWeight(.bold)
                .font(.title)
            Rectangle()
                .stroke(.gray, lineWidth: 2)
                .frame(height: 1)
            HStack{
                VStack(alignment: .leading){
                    Text("Region:")
                    Text("Capital:")
                }
                .bold()
                VStack(alignment: .leading){
                    Text(countryDetailVM.countryDetail.subregion)
                    Text(countryDetailVM.countryDetail.capital.joined(separator: ", "))
                }
            }
            Text("Flag:")
                .bold()
            flagImage
            if (countryDetailVM.countryDetail.coatOfArms.png != nil){
                Text("Coat of Arms:")
                    .bold()
                coatImage
            }
            Spacer()
        }
        .padding(.horizontal)
        .task{
            countryDetailVM.countryName = country.name.common
            await countryDetailVM.getData()
        }
    }
}
extension DetailView{
    var flagImage: some View{
        AsyncImage(url: URL(string: countryDetailVM.countryDetail.flags.png)) { phase in
            if let image = phase.image{
                image
                    .resizable()
                    .scaledToFit()
                    .shadow(radius: 8)
            } else if phase.error != nil{
                Image(systemName: "questionmark.square.dashed")
                    .resizable()
                    .scaledToFit()
            } else {
                ProgressView()
                    .tint(.red)
                    .scaleEffect(4)
            }
        }
        .padding(.trailing)
    }
    var coatImage: some View{
        AsyncImage(url: URL(string: countryDetailVM.countryDetail.coatOfArms.png ?? "")) { phase in
            if let image = phase.image{
                image
                    .resizable()
                    .scaledToFit()
                    .shadow(radius: 8)
            } else if phase.error != nil{
                Image(systemName: "questionmark.square.dashed")
                    .resizable()
                    .scaledToFit()
                    .shadow(radius: 8)
            } else {
                ProgressView()
                    .tint(.red)
                    .scaleEffect(4)
            }
        }
        .padding(.trailing)
    }
}
#Preview {
    DetailView(country: Country(name: Name(common: "Canada"), flag: "🇨🇦"))
}

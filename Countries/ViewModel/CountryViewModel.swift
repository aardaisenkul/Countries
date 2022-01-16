//
//  CountryViewModel.swift
//  Countries
//
//  Created by Ali Arda İsenkul on 16.01.2022.
//

import Foundation

struct CountryListViewModel {
    let countryList: [CountryData]
    
    func numberOfRowsInSection() -> Int {
         return self.countryList.count
     }
     
     func countryAtIndex(_ index: Int) -> CountryViewModel {
         let country = self.countryList[index]
         return CountryViewModel(country)
     }
}

struct CountryViewModel {
    let currentCountry: CountryData
    
    init(_ country: CountryData) {
        self.currentCountry = country
    }
    
    var name: String {
        return self.currentCountry.name
    }
    
    var code: String {
        return self.currentCountry.code
    }
    var wikiID: String {
        return self.currentCountry.wikiDataID
    }
}

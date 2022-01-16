//
//  DetailViewModel.swift
//  Countries
//
//  Created by Ali Arda İsenkul on 16.01.2022.
//

import Foundation

struct DetailViewModel {
    let currentCountry: DetailedCountry
    
    init(_ country: DetailedCountry) {
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
    var link: String{
        return self.currentCountry.flagImageURI
    }
}

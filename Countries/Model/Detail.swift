//
//  Detail.swift
//  Countries
//
//  Created by Ali Arda İsenkul on 16.01.2022.
//

import Foundation

// MARK: - DetailedData
struct DetailedData: Codable {
    let data: DetailedCountry
}

// MARK: - DetailedCountry
struct DetailedCountry: Codable {
    let capital: String?
    let code, callingCode: String
    let currencyCodes: [String]
    let flagImageURI: String
    let name: String
    let numRegions: Int
    let wikiDataID: String

    enum CodingKeys: String, CodingKey {
        case capital, code, callingCode, currencyCodes
        case flagImageURI = "flagImageUri"
        case name, numRegions
        case wikiDataID = "wikiDataId"
    }
}


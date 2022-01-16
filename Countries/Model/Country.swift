//
//  CountryData.swift
//  Countries
//
//  Created by Ali Arda İsenkul on 16.01.2022.
//

import Foundation

// MARK: - FetchData
struct FetchData: Codable {
    let data:[CountryData]
    let links: [Links]
    let metadata: MetaData
}
// MARK: - Links
struct Links: Codable {
    let rel, href: String
}
// MARK: - Metadata
struct MetaData: Codable{
    let currentOffset, totalCount: Int
    
}
// MARK: - CountryData
struct CountryData: Codable {
    let code: String
    let currencyCodes: [String]
    let name, wikiDataID: String

    enum CodingKeys: String, CodingKey {
        case code, currencyCodes, name
        case wikiDataID = "wikiDataId"
    }
}


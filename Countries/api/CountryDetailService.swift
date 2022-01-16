//
//  CountryDetailService.swift
//  Countries
//
//  Created by Ali Arda İsenkul on 16.01.2022.
//

import Foundation

class CountryDetailService {
    static let shared = CountryDetailService()
    func parseJSON() ->DetailedCountry? {
        guard let url = Bundle.main.url(forResource: "detail", withExtension: "json") else {
            return nil
        }
        
        do {
           
            let jsonData = try Data(contentsOf: url)
            print(jsonData)
            let data = try JSONDecoder().decode(DetailedData.self, from: jsonData)
            print(data)
            var country:DetailedCountry?
            country = data.data
            
            return country
        }
        catch {
            print("\n====> error: \(error)" )
            return nil
        }
    }
    func parseCountryJSON() ->[CountryData]? {
        guard let url = Bundle.main.url(forResource: "countries", withExtension: "json") else {
            return nil
        }
        
        do {
           
            let jsonData = try Data(contentsOf: url)
            print(jsonData)
            let data = try JSONDecoder().decode(FetchData.self, from: jsonData)
            print(data)
            var country:[CountryData]?
            country = data.data
            
            return country
        }
        catch {
            print("\n====> error: \(error)" )
            return nil
        }
    }
}

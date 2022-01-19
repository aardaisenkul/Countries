//
//  CountriesTests.swift
//  CountriesTests
//
//  Created by Ali Arda İsenkul on 15.01.2022.
//

import XCTest
@testable import Countries
//MARK: Added 2 tests before running the app. Checks the consistency of data
class CountriesTests: XCTestCase {

    //MARK: Test for fetching country data if it succeed, it has to give me 10 country name
    func testCountryFetch() throws {
        let limit = 10 // as you asked for
        let url = URL(string: "https://wft-geo-db.p.rapidapi.com/v1/geo/countries?limit=\(limit)&rapidapi-key=eef67dcbacmsha0afe59474c638ep1a66f9jsn3e66a84ab8fb")!
        
        Webservice().fetchCountries(url: url) { countries in
            if let countries = countries {
                XCTAssertGreaterThan(5, countries.count)
            }
        }
    }
    
  
    //MARK: Test for fetching country detail if it succeed, it has to give me a name of country
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        let code = "VA"
        let url = URL(string: "https://wft-geo-db.p.rapidapi.com/v1/geo/countries/\(code)?rapidapi-key=eef67dcbacmsha0afe59474c638ep1a66f9jsn3e66a84ab8fb")!
        
        Webservice().fetchDetail(url: url) { details in
            if let details = details {
                XCTAssertNotNil(details.name)
            }
        }
    }
    

}

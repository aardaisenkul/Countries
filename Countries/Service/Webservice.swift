//
//  Webservice.swift
//  Countries
//
//  Created by Ali Arda İsenkul on 16.01.2022.
//

import Foundation

class Webservice {
    
    func fetchCountries(url: URL, completion: @escaping ([CountryData]?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                let result = try? JSONDecoder().decode(FetchData.self, from: data)
                if let result = result {
                    completion(result.data)
                }
                
            }
            
        }.resume()
        
    }
    func fetchDetail(url: URL, completion: @escaping (DetailedCountry?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                do{
                    
                    let result = try JSONDecoder().decode(DetailedData.self, from: data)
                    completion(result.data)
                }catch{
                    print("Failed to parse data!")
                    completion(nil)
                }
                
                
                
            }
            
        }.resume()
        
    }
    
}

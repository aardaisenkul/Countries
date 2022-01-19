//
//  CountryViewModel.swift
//  Countries
//
//  Created by Ali Arda İsenkul on 16.01.2022.
//

import Foundation
import CoreData
import UIKit

// MARK: - Country List
struct CountryListViewModel {
    var countryList: [CountryData]
}
// MARK: - Country Model
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
// MARK: - Country Methods


extension CountryListViewModel {
    
    func numberOfRowsInSection() -> Int {
         return self.countryList.count
     }
    
    func countryAtIndex(_ index: Int) -> CountryViewModel {
        let country = self.countryList[index]
        return CountryViewModel(country)
    }
    // MARK: - Saved Country Lists
    func savedCountries() -> [String] {
        var savedCountryNames = [String]()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedCountries")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let code = result.value(forKey: "countryCode") as? String {
                        savedCountryNames.append(code)
                    }
                }
            }
        } catch {
            print("error while fetching coredata")
        }
        return savedCountryNames
    }
    // MARK: - Country Favorited or not
    func isFavorited(code:String) -> Bool {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedCountries")
        fetchRequest.predicate = NSPredicate(format: "countryCode = %@", code)
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
           let results = try context.fetch(fetchRequest)
            
            if results.count > 0 {
                return true
            }else{
                    return false
              }
        } catch{
            print("core data check favorited object method error ")
        }
        return false
    }
    // MARK: - Change Country Favorite Status
    func changeFavoriteStatus(code:String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedCountries")
        fetchRequest.predicate = NSPredicate(format: "countryCode = %@", code)
        fetchRequest.returnsObjectsAsFaults = false
        do {
           let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    context.delete(result)
                }
            }else{
                let newCountryCode = NSEntityDescription.insertNewObject(forEntityName: "SavedCountries", into: context)
                newCountryCode.setValue(code, forKey: "countryCode")
            }
            do {
                try context.save()
                print("successfully saved")
            }
            catch {
                print("error while coredata saving for favorite process")
            }
        } catch{
            print("core data fetching favorited object")
        }
      
    }
     
    
}

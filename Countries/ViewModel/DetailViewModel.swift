//
//  DetailViewModel.swift
//  Countries
//
//  Created by Ali Arda İsenkul on 16.01.2022.
//

import Foundation
import UIKit
import CoreData

// MARK: - Detailed Country View Model


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

extension DetailViewModel {
    
   
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
        DispatchQueue.main.async {
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
}


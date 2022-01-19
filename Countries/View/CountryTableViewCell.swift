//
//  CountryTableViewCell.swift
//  Countries
//
//  Created by Ali Arda İsenkul on 15.01.2022.
//

import UIKit
import CoreData

class CountryTableViewCell: UITableViewCell {


    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var countryFavImage: UIImageView!
    var countryCode = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    let tapGestureRecognizer = UITapGestureRecognizer(
        target: self,
        action: #selector(addToFavorite(tapGestureRecognizer:)))
        countryFavImage.isUserInteractionEnabled = true
        countryFavImage.addGestureRecognizer(tapGestureRecognizer)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @objc func addToFavorite(tapGestureRecognizer: UITapGestureRecognizer)
    {
        
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        if tappedImage.alpha < 1 {
            tappedImage.alpha = 1.0
        } else{
            tappedImage.alpha = 0.2
        }
        self.changeFavoriteStatus(code:countryCode)
       // NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadData"), object: nil)

        
       
    }

}

// MARK: - Change Country Favorite Status
extension CountryTableViewCell {
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

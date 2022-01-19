//
//  SavedViewController.swift
//  Countries
//
//  Created by Ali Arda İsenkul on 15.01.2022.
//

// MARK: - THERE ARE ONE ADDITIONAL METHOD WHICH SHARTS WITH LOCALE, IT IS MY TEST METHOD FOR PARSING JSON DATA SINCE THERE IS A LIMITATION OF 1000 REQUEST TO API
// MARK: - THIS CLASS IS VERY SIMILAR TO VIEWCONTROLLER, TO INCREASE READABILITY AND MORE PROFESSIONALLY, A MAIN CLASS CAN BE WRITTEN AND REPRODUCE THERE 2 PAGES FROM IT

import UIKit
import CoreData

class SavedViewController: UIViewController {


    @IBOutlet weak var savedTableView: UITableView!
    var savedCountryArray = [CountryData]()
    var savedCountryCodes = [String]()
    var selectedCode:String = ""
    var savedCountryListViewModel : CountryListViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        savedTableView.delegate = self
        savedTableView.dataSource = self
        savedTableView.separatorStyle = .none
        savedTableView.showsVerticalScrollIndicator = false
        //getLocaleCountries()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        savedCountryCodes = savedCountries()
        getCountries()
    }
    // MARK: - FETCH COUNTRTIES DATA

    func getCountries(){
        var favC = [CountryData]()
        let url = URL(string: "https://wft-geo-db.p.rapidapi.com/v1/geo/countries?limit=10&rapidapi-key=eef67dcbacmsha0afe59474c638ep1a66f9jsn3e66a84ab8fb")!
        
        Webservice().fetchCountries(url: url) { countries in
            // MARK: - MAIN DIFFERENCE IS HERE TO GET INTERSECTION OF SAVED COUNTRIES AND THE ONES WHICH FETCHED
            if let countries = countries {
                for item in countries {
                    if self.savedCountryCodes.contains(item.code){
                        favC.append(item)
                    }
                }
                self.savedCountryListViewModel = CountryListViewModel(countryList: favC)
                
                DispatchQueue.main.async {
                    self.savedTableView.reloadData()
                }
            }
        }
    }
   
    // MARK: - LOCALE FETCH CALL
    func getLocaleCountries(){
        var favC = [CountryData]()
        savedCountryArray = CountryDetailService.shared.parseCountryJSON()!
        for item in savedCountryArray {
            if savedCountryCodes.contains(item.code){
                favC.append(item)
            }
        }
       
        self.savedCountryListViewModel = CountryListViewModel(countryList: favC)
        DispatchQueue.main.async {
            self.savedTableView.reloadData()
        }
       
       }
    // MARK: - SAVED COUNTRIES FROM VIEW MODEL
    @objc func getSavedCountryNames(){ // METHOD FOR FIRST CONTROL TO CHECK FAVORITED COUNTRIES
       
        DispatchQueue.main.async {
            self.savedCountryCodes = self.savedCountryListViewModel.savedCountries()
            self.savedTableView.reloadData()
        }
       
    }
    
}

// MARK: - SAME EXTENSION AS VIEW CONTROLLER
extension SavedViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.savedCountryListViewModel == nil ? 0 : self.savedCountryListViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.savedTableView.dequeueReusableCell(withIdentifier: "countryCell") as! CountryTableViewCell
        let country = self.savedCountryListViewModel.countryAtIndex(indexPath.row)
        cell.countryLabel.text = country.name
        cell.countryFavImage.alpha =  1 
        cell.countryCode = country.code
        cell.countryView.layer.borderColor = UIColor.black.cgColor
        cell.currentTableView = self.savedTableView
        cell.countryView.layer.borderWidth = 2.0
        cell.countryView.layer.cornerRadius = 8
        cell.page = "Saved"
        cell.listViewModel = self.savedCountryListViewModel
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCode = self.savedCountryListViewModel.countryAtIndex(indexPath.row).code
        performSegue(withIdentifier: "showDetail", sender: nil)
        savedTableView.deselectRow(at: indexPath, animated: true)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.selectedCountryCode = selectedCode
            
        }
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

}

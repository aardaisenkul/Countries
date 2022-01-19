//
//  SavedViewController.swift
//  Countries
//
//  Created by Ali Arda İsenkul on 15.01.2022.
//

import UIKit
import CoreData

class SavedViewController: UIViewController {


    @IBOutlet weak var savedTableView: UITableView!
    var savedCountryArray = [CountryData]()
    var savedCountryCodes = [String]()
    var selectedCode:String = ""
    private var savedCountryListViewModel : CountryListViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableViewData), name: NSNotification.Name(rawValue: "reloadData"),object: nil)
        savedTableView.delegate = self
        savedTableView.dataSource = self
        savedCountryCodes = savedCountries()
        savedTableView.separatorStyle = .none
        savedTableView.showsVerticalScrollIndicator = false
        //getLocaleCountries()
        getCountries()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        savedTableView.reloadData()
    }
    @objc func reloadTableViewData() {
//        var favC = [CountryData]()
//            self.savedCountryCodes = savedCountries()
//        for item in savedCountryArray {
//            if savedCountryCodes.contains(item.code){
//                favC.append(item)
//            }
//        }
//        self.savedCountryListViewModel = CountryListViewModel(countryList: favC)
        savedTableView.reloadData()
    }
    func getCountries(){
        var favC = [CountryData]()
        let url = URL(string: "https://wft-geo-db.p.rapidapi.com/v1/geo/countries?limit=10&rapidapi-key=eef67dcbacmsha0afe59474c638ep1a66f9jsn3e66a84ab8fb")!
        
        Webservice().fetchCountries(url: url) { countries in
            
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
                self.getSavedCountryNames()
            }
        }
    }
    
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
    
    @objc func getSavedCountryNames(){ // METHOD FOR FIRST CONTROL TO CHECK FAVORITED COUNTRIES
       
        DispatchQueue.main.async {
            self.savedCountryCodes = self.savedCountryListViewModel.savedCountries()
            self.savedTableView.reloadData()
        }
       
    }
    
}

// SAME EXTENSION AS MAIN VIEW
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
        cell.countryView.layer.borderWidth = 2.0
        cell.countryView.layer.cornerRadius = 8
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

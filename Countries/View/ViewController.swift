//
//  ViewController.swift
//  Countries
//
//  Created by Ali Arda İsenkul on 15.01.2022.
//

// MARK: - THERE ARE ONE ADDITIONAL METHOD WHICH SHARTS WITH LOCALE, IT IS MY TEST METHOD FOR PARSING JSON DATA SINCE THERE IS A LIMITATION OF 1000 REQUEST TO API

import UIKit
import CoreData

class ViewController: UIViewController {

  
    @IBOutlet weak var tableView: UITableView!
    var selectedCode:String = ""
    var countryArray = [CountryData]()
    private var countryListViewModel : CountryListViewModel!
    var savedCountries : [String] = []
    
    override func viewDidLoad() {
       
       // getLocaleCountries()
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }
    override func viewWillAppear(_ animated: Bool) {
        getCountries()
       
    }
    // MARK: -
    @objc func getCountries(){
        let url = URL(string: "https://wft-geo-db.p.rapidapi.com/v1/geo/countries?limit=10&rapidapi-key=eef67dcbacmsha0afe59474c638ep1a66f9jsn3e66a84ab8fb")!
        
        Webservice().fetchCountries(url: url) { countries in
            
            if let countries = countries {
                self.countryListViewModel = CountryListViewModel(countryList: countries)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                self.getSavedCountryNames()
            }
        }
    }
    // MARK: - LOCALE FETCH
    func getLocaleCountries(){
        countryArray = CountryDetailService.shared.parseCountryJSON()!
        self.countryListViewModel = CountryListViewModel(countryList: countryArray)
        self.tableView.reloadData()
       }
    // MARK: - GET SAVED COUNTRES FROM VIEWMODEL CLASS
    @objc func getSavedCountryNames(){ // METHOD FOR FIRST CONTROL TO CHECK FAVORITED COUNTRIES
        DispatchQueue.main.async {
            self.savedCountries = self.countryListViewModel.savedCountries()
            self.tableView.reloadData()
        }
       
    }
    
}

// MARK: - SAME EXTENSION AS DETAILED VIEW
extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countryListViewModel == nil ? 0 : self.countryListViewModel.numberOfRowsInSection()
    }
    
    // MARK: - CREATING PART OF CUSTOM CELL
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell") as! CountryTableViewCell
        let country = self.countryListViewModel.countryAtIndex(indexPath.row)
        cell.countryLabel.text = country.name
        cell.countryCode = country.code
        cell.currentTableView = self.tableView
        // 1.0 for fill 0.2 for empty
        cell.countryFavImage.alpha = self.savedCountries.contains(country.code) ? 1 : 0.2
        cell.countryView.layer.borderColor = UIColor.black.cgColor
        cell.countryView.layer.borderWidth = 2.0
        cell.page = "Main"
        cell.countryView.layer.cornerRadius = 8
        return cell
    }
    // MARK: - TABLE VIEW METHOD, ADDED DESELECTROW TO FIX SELECTION PROBLEM WHEN I GO BACK FROM DETAIL TO MAIN PAGE
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCode = self.countryListViewModel.countryAtIndex(indexPath.row).code
        performSegue(withIdentifier: "showDetail", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
      

    }
    // MARK: - SEGUE PROCESS
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.selectedCountryCode = selectedCode
        }
    }
}

// MARK: - TRYING TO ADD AN EXTENSION TO TRIGGER VIEWCONTROLLER FROM CUSTOM CELL INSTANTLY BUT I DID NOT HAVE ENOUGH TIME AND LACK OF KNOWLEDGE 
extension UITableViewCell {
    var tableView: UITableView? {
        return (next as? UITableView) ?? (parentViewController as? UITableViewController)?.tableView
    }

    var indexPath: IndexPath? {
        return tableView?.indexPath(for: self)
    }
}


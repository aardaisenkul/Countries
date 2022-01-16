//
//  ViewController.swift
//  Countries
//
//  Created by Ali Arda İsenkul on 15.01.2022.
//

import UIKit

class ViewController: UIViewController {

  
    @IBOutlet weak var tableView: UITableView!
    var selectedCode:String = ""
    var countryArray = [CountryData]()
    private var countryListViewModel : CountryListViewModel!
    
    override func viewDidLoad() {
        getNewCountries()
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }
    
    func getNewCountries(){
        
        let url = URL(string: "https://wft-geo-db.p.rapidapi.com/v1/geo/countries?limit=10&rapidapi-key=eef67dcbacmsha0afe59474c638ep1a66f9jsn3e66a84ab8fb")!
        
        Webservice().fetchCountries(url: url) { countries in
            
            if let countries = countries {
                
                self.countryListViewModel = CountryListViewModel(countryList: countries)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

// SAME EXTENSION AS DETAILED VIEW
extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countryListViewModel == nil ? 0 : self.countryListViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell") as! CountryTableViewCell
        let country = self.countryListViewModel.countryAtIndex(indexPath.row)
        cell.countryLabel.text = country.name
        // 1.0 for fill 0.2 for empty
        cell.countryFavImage.alpha = 0.2
        cell.countryView.layer.borderColor = UIColor.black.cgColor
        cell.countryView.layer.borderWidth = 2.0
        cell.countryView.layer.cornerRadius = 8
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCode = self.countryListViewModel.countryAtIndex(indexPath.row).code
        performSegue(withIdentifier: "showDetail", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
      

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.selectedCountryCode = selectedCode
        }
    }
}


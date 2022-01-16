//
//  SavedViewController.swift
//  Countries
//
//  Created by Ali Arda İsenkul on 15.01.2022.
//

import UIKit

class SavedViewController: UIViewController {


    @IBOutlet weak var savedTableView: UITableView!
    var savedCountryArray = [CountryData]()
    var selectedCode = ""
    private var savedCountryListViewModel : CountryListViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        savedTableView.delegate = self
        savedTableView.dataSource = self
        
        savedTableView.separatorStyle = .none
        savedTableView.showsVerticalScrollIndicator = false

        // Do any additional setup after loading the view.
    }
    func getNewCountries(){
        
        let url = URL(string: "https://wft-geo-db.p.rapidapi.com/v1/geo/countries?limit=10&rapidapi-key=eef67dcbacmsha0afe59474c638ep1a66f9jsn3e66a84ab8fb")!
        
        Webservice().fetchCountries(url: url) { countries in
            
            if let countries = countries {
                
                self.savedCountryListViewModel = CountryListViewModel(countryList: countries)
                
                DispatchQueue.main.async {
                    self.savedTableView.reloadData()
                }
            }
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
        cell.countryFavImage.alpha = 1
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

}

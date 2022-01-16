//
//  ViewController.swift
//  Countries
//
//  Created by Ali Arda İsenkul on 15.01.2022.
//

import UIKit

class ViewController: UIViewController {

  
    @IBOutlet weak var tableView: UITableView!
    var countries = ["Ardasadasd","Arcasdasdan"]
    var countryArray = [CountryData]()
    
    override func viewDidLoad() {
        //getCountries()
        getNewCountries()
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        // Do any additional setup after loading the view.
       
        
    }
    func getNewCountries(){
        countryArray = CountryDetailService.shared.parseCountryJSON()!
    }
    func getCountries() {
        
        let url = URL(string:"https://wft-geo-db.p.rapidapi.com/v1/geo/countries?limit=10&rapidapi-key=eef67dcbacmsha0afe59474c638ep1a66f9jsn3e66a84ab8fb")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                let users = try JSONDecoder().decode(FetchData.self, from: data!)
                DispatchQueue.main.async {
                    self.countryArray = users.data
                    self.tableView.reloadData()
                }
              
            }
            catch{
                print("error")
            }
        }.resume()
    }

}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell") as! CountryTableViewCell
        let country = countryArray[indexPath.row]
        cell.countryLabel.text = country.name
        // 1.0 for fill 0.3 for empty
        cell.countryFavImage.alpha = 0.2
        cell.countryView.layer.borderColor = UIColor.black.cgColor
        cell.countryView.layer.borderWidth = 2.0
        cell.countryView.layer.cornerRadius = 8
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: countryArray[indexPath.row].code)
        tableView.deselectRow(at: indexPath, animated: true)

    }
}


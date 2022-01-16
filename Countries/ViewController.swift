//
//  ViewController.swift
//  Countries
//
//  Created by Ali Arda İsenkul on 15.01.2022.
//

import UIKit

struct FetchData: Codable {
    let data:[CountryData]
    let links: [Links]
    let metadata: MetaData
}
struct Links: Codable {
    let rel: String
    let href: String
}
struct MetaData: Codable{
    let currentOffset : Int
    let totalCount: Int
    
}
struct CountryData: Codable {
    let code:String
    let name:String
    var currencyCodes: [String]?
    let wikiDataId: String
}
struct Veriler:Codable {
    var userId:Int
    var id:Int
    var title:String
    var body:String
    
}

class ViewController: UIViewController {

  
    @IBOutlet weak var tableView: UITableView!
    var countries = ["Ardasadasd","Arcasdasdan"]
    var countryArray = [CountryData]()
    
    override func viewDidLoad() {
        getCountries()
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        // Do any additional setup after loading the view.
       
        
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
        performSegue(withIdentifier: "showDetail", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)

    }
}


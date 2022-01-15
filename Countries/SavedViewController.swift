//
//  SavedViewController.swift
//  Countries
//
//  Created by Ali Arda İsenkul on 15.01.2022.
//

import UIKit

class SavedViewController: UIViewController {


    @IBOutlet weak var savedTableView: UITableView!
    var countries = ["saved1","saved2"]
    override func viewDidLoad() {
        super.viewDidLoad()
        savedTableView.delegate = self
        savedTableView.dataSource = self
        
        savedTableView.separatorStyle = .none
        savedTableView.showsVerticalScrollIndicator = false

        // Do any additional setup after loading the view.
    }
    
}

extension SavedViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = savedTableView.dequeueReusableCell(withIdentifier: "countryCell") as! CountryTableViewCell
        let country = countries[indexPath.row]
        cell.countryLabel.text = country
        // 1.0 for fill 0.3 for empty
        cell.countryFavImage.alpha = 1
        cell.countryView.layer.borderColor = UIColor.black.cgColor
        cell.countryView.layer.borderWidth = 2.0
        cell.countryView.layer.cornerRadius = 8
        
        return cell
    }
}

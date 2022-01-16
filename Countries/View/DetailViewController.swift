//
//  DetailViewController.swift
//  Countries
//
//  Created by Ali Arda İsenkul on 15.01.2022.
//

import UIKit
import SDWebImage
import SDWebImageSVGCoder
import CoreData

class DetailViewController: UIViewController , UINavigationBarDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var countryCodeLabel: UILabel!
    var countryDetail : DetailedCountry?
    private var detailViewModel : DetailViewModel!
    var selectedCountryCode : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        navigationController?.navigationBar.tintColor = .label
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"),  style: .done, target: self, action: #selector(goBack))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"),  style: .done, target: self, action: #selector(setFavorite))
        getDetails(code: self.selectedCountryCode)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        prepareImg(urlString:detailViewModel.link,countryCode: detailViewModel.code,title: detailViewModel.name)
    }
    
    
//    func getDetails(code:String){
//            let url = URL(string:"https://wft-geo-db.p.rapidapi.com/v1/geo/countries/\(code)?rapidapi-key=eef67dcbacmsha0afe59474c638ep1a66f9jsn3e66a84ab8fb")!
//            URLSession.shared.dataTask(with: url) { data, response, error in
//                do {
//                    let details = try JSONDecoder().decode(DetailedData.self, from: data!)
//                    DispatchQueue.main.async {
//                        self.countryDetail = details.data
//                    }
//                }
//                catch{
//                    print("error")
//                }
//            }.resume()
//
//    }
    func getDetails(code:String){
        let url = URL(string: "https://wft-geo-db.p.rapidapi.com/v1/geo/countries/\(code)?rapidapi-key=eef67dcbacmsha0afe59474c638ep1a66f9jsn3e66a84ab8fb")!
        Webservice().fetchDetail(url: url) { details in
            
            if let details = details {
                
                self.detailViewModel = DetailViewModel(details)
            }
        }
    }
    
    @objc func goBack(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func setFavorite(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newCountryCode = NSEntityDescription.insertNewObject(forEntityName: "SavedCountries", into: context)
        
        // Attributes
        
        newCountryCode.setValue(selectedCountryCode, forKey: "countryCode")
        self.navigationItem.rightBarButtonItem!.image = UIImage(systemName: "star.fill")
        do {
            try context.save()
            print("successfully saved")
        }
        catch {
            print("error")
        }
    }

    @IBAction func moreInfoClicked(_ sender: Any) {
        if let url = URL(string: "https://www.wikidata.org/wiki/\(detailViewModel.wikiID)") {
                  UIApplication.shared.open(url)
              }
    }
    private func prepareImg(urlString: String?, countryCode: String,title: String) {
       
        if let countryImageURL = urlString,
           let url = URL(string: countryImageURL) {
            DispatchQueue.main.async {
                self.title = title
                self.imageView.sd_setImage(with: url)
                self.countryCodeLabel.text = countryCode
            }
           
        }
       
    }
}


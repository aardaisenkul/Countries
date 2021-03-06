//
//  DetailViewController.swift
//  Countries
//
//  Created by Ali Arda İsenkul on 15.01.2022.
//

// MARK: - THERE ARE ONE ADDITIONAL METHOD WHICH SHARTS WITH LOCALE, IT IS MY TEST METHOD FOR PARSING JSON DATA SINCE THERE IS A LIMITATION OF 1000 REQUEST TO API

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
        getDetails(code: self.selectedCountryCode)
        //getLocaleDetails()
        view.backgroundColor = .systemGray6
        navigationController?.navigationBar.tintColor = .label
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"),  style: .done, target: self, action: #selector(goBack))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"),  style: .done, target: self, action: #selector(changeFavorite))
    }
    // MARK: - FETCHING DETAIL INFORMATIONS OF SPECIFIC COUNTRY
    func getDetails(code:String){
        let url = URL(string: "https://wft-geo-db.p.rapidapi.com/v1/geo/countries/\(code)?rapidapi-key=eef67dcbacmsha0afe59474c638ep1a66f9jsn3e66a84ab8fb")!
        
        Webservice().fetchDetail(url: url) { details in
            if let details = details {
                self.detailViewModel = DetailViewModel(details)
             
               // self.prepareImg(urlString:details.flagImageURI,countryCode: details.code)
            }
            self.prepareImg(urlString:self.detailViewModel.link,countryCode: self.detailViewModel.code, title: self.detailViewModel.name )
        }
      
    }
    // MARK: - LOCAL FETCHING FUNCTION
    func getLocaleDetails(){
        let countryDetail2 = CountryDetailService.shared.parseJSON()!
        self.detailViewModel = DetailViewModel(countryDetail2)
        self.title = countryDetail2.name
    }
  
    @objc func goBack(){
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: - CHANGE FAVORITE PROP WHICH CONSISTS OF CHECK FAVORITE OR NOT THEN HANDLE COREDATA ACTIONS AND LASTLY CHANGE OPACITY OF STAR ICON
    @objc func changeFavorite(){
     
            let favorited = self.detailViewModel.isFavorited(code: self.selectedCountryCode)
            self.detailViewModel.changeFavoriteStatus(code: self.selectedCountryCode)
        self.navigationItem.rightBarButtonItem!.image = UIImage(systemName: favorited ? "star" : "star.fill" )
    }
    // MARK: - OPENS WIKIPEDIA
    @IBAction func moreInfoClicked(_ sender: Any) {
                if let url = URL(string: "https://www.wikidata.org/wiki/\(detailViewModel.wikiID)") {
                          UIApplication.shared.open(url)
                      }
    }
    // MARK: - FETCHING DETAIL INFORMATIONS AND SET IMAGE VIEW TO THAT SPECIFIC SVG
    private func prepareImg(urlString: String?, countryCode: String, title: String) {
        DispatchQueue.main.async {
            let favorited = self.detailViewModel.isFavorited(code: self.selectedCountryCode)
        
        if let countryImageURL = urlString,
           let url = URL(string: countryImageURL) {
           
                self.imageView.sd_setImage(with: url)
                self.title = title
                self.countryCodeLabel.text = countryCode
                self.navigationItem.rightBarButtonItem!.image = UIImage(systemName: favorited ? "star.fill" : "star")
            }
            
        }
        
    }
    
}


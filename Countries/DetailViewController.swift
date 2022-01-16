//
//  DetailViewController.swift
//  Countries
//
//  Created by Ali Arda İsenkul on 15.01.2022.
//

import UIKit
import SDWebImage
import SDWebImageSVGCoder

class DetailViewController: UIViewController , UINavigationBarDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var countryCodeLabel: UILabel!
    var countryDetail : DetailedCountry?
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
      countryDetail = CountryDetailService.shared.parseJSON()!
      configureUI()
    }
    
    func configureUI() {
        print(countryDetail!)
        title = countryDetail?.name
        prepareImg(urlString:  countryDetail?.flagImageURI,countryCode: countryDetail!.code)
        view.backgroundColor = .systemGray6
        navigationController?.navigationBar.tintColor = .label
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"),  style: .done, target: self, action: #selector(goBack))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"),  style: .done, target: self, action: #selector(goBack))
        
       
    }
    
    @objc func goBack(){
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func moreInfoClicked(_ sender: Any) {
        if let url = URL(string: "https://www.wikidata.org/wiki/\(countryDetail!.wikiDataID as String)") {
                  UIApplication.shared.open(url)
              }
//        if let url = URL(string: "https://www.wikidata.org/wiki/Q43") {
//            UIApplication.shared.open(url)
//        }
    }
    private func prepareImg(urlString: String?, countryCode: String) {
        if let countryImageURL = urlString,
           let url = URL(string: countryImageURL) {
            imageView.sd_setImage(with: url)
        }
        countryCodeLabel.text = countryCode
    }
}


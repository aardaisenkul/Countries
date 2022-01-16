//
//  DetailViewController.swift
//  Countries
//
//  Created by Ali Arda İsenkul on 15.01.2022.
//

import UIKit

class DetailViewController: UIViewController , UINavigationBarDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var countryCodeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Country Name"
        view.backgroundColor = .systemGray6
        navigationController?.navigationBar.tintColor = .label
        configureNavBar()
        // Do any additional setup after loading the view.
    }
    
    private func configureNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"),  style: .done, target: self, action: #selector(goBack))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"),  style: .done, target: self, action: #selector(goBack))
        
       
    }
    @objc func goBack(){
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func moreInfoClicked(_ sender: Any) {
        
    }
}

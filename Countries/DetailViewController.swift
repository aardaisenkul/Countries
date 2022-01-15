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
        configureNavBar()
        // Do any additional setup after loading the view.
    }
    
    private func configureNavBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
    }

    @IBAction func moreInfoClicked(_ sender: Any) {
        
    }
}

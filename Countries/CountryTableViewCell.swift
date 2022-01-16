//
//  CountryTableViewCell.swift
//  Countries
//
//  Created by Ali Arda İsenkul on 15.01.2022.
//

import UIKit
import CoreData

class CountryTableViewCell: UITableViewCell {


    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var countryFavImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    let tapGestureRecognizer = UITapGestureRecognizer(
        target: self,
        action: #selector(addToFavorite(tapGestureRecognizer:)))
        countryFavImage.isUserInteractionEnabled = true
        countryFavImage.addGestureRecognizer(tapGestureRecognizer)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @objc func addToFavorite(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        if tappedImage.alpha < 1 {
            tappedImage.alpha = 1.0
        } else{
            tappedImage.alpha = 0.2
        }
       
    }

}

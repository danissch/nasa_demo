//
//  ApodListCollectionViewCell.swift
//  nasa
//
//  Created by Daniel Durán Schütz on 6/09/20.
//  Copyright © 2020 Daniel Durán Schütz. All rights reserved.
//

import Foundation
import UIKit

class ApodListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageApodCell: UIImageView!
    @IBOutlet weak var titleApodCell: UILabel!
    @IBOutlet weak var dateApodCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(title:String, date:String, imageUrl:String){
        //setImageFromUrl(imageUrl: imageUrl)
        imageApodCell.setImageFromUrl(imageUrl: imageUrl)
        titleApodCell.text = title
        dateApodCell.text = date
    }
    
    
}

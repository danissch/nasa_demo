//
//  ApodDetailMediaTableViewCell.swift
//  nasa
//
//  Created by Daniel Durán Schütz on 8/09/20.
//  Copyright © 2020 Daniel Durán Schütz. All rights reserved.
//

import UIKit

class ApodDetailMediaTableViewCell: UITableViewCell {

    @IBOutlet var detailedImage: UIImageView!
    
    @IBOutlet weak var imageButton: UIButton!
    var currentController: UIViewController?
    var vc = ImageDetailViewController.instantiateFromXIB() as ImageDetailViewController
    var detailVCTitle = ""
    @IBAction func actionButtonImage(_ sender: Any) {
        
            
            currentController?.pushVc(vc, navigationBarIsHidden: false)
            vc.title = detailVCTitle
            
            vc.backButton()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(imageUrl:String = "", cVc:UIViewController, detailTitle:String = ""){
        detailedImage.setImageFromUrl(imageUrl: imageUrl)
        currentController = cVc
        vc.setImage(imageUrl: imageUrl)
        detailVCTitle = detailTitle
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        // Configure the view for the selected state
//    }
    
}

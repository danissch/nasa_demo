//
//  ImageDetailViewController.swift
//  nasa
//
//  Created by Daniel Durán Schütz on 9/09/20.
//  Copyright © 2020 Daniel Durán Schütz. All rights reserved.
//

import Foundation
import UIKit

class ImageDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var url:String? = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.setImageFromUrl(imageUrl: self.url ?? "")
        imageView.enableZoom()
    }
    
    func setImage(imageUrl:String = ""){
        self.url = imageUrl
    }
    
}

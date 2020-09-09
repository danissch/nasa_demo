//
//  UIImageViewExtension.swift
//  nasa
//
//  Created by Daniel Durán Schütz on 8/09/20.
//  Copyright © 2020 Daniel Durán Schütz. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func setImageFromUrl(imageUrl:String = String("")){
        if imageUrl == "" {
            self.image = UIImage(named: "placeholder")
        }else{
            let url = URL(string: imageUrl)
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url!){
                    DispatchQueue.main.async {
                        self.image = UIImage(data: data)
                    }
                } //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            }
        }
    }
    
    func enableZoom() {
      let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startZooming(_:)))
      isUserInteractionEnabled = true
      addGestureRecognizer(pinchGesture)
    }

    @objc private func startZooming(_ sender: UIPinchGestureRecognizer) {
      let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
      guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
      sender.view?.transform = scale
      sender.scale = 1
    }
}

//
//  ViewController.swift
//  nasa
//
//  Created by Daniel Durán Schütz on 4/09/20.
//  Copyright © 2020 Daniel Durán Schütz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ApodViewModelDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    lazy var apodViewModel:ApodViewModel = {
       return ApodViewModel()
    }()
    var apodlist:[ApodModel]? = [] {
        didSet {
            //print("appflow: apodlist.count = \(apodlist?.count)")
            if !(apodlist?.isEmpty ?? false) {
                collectionView.reloadData()
            }
        }
    }
    var estimateWidth = 110.0
    var cellMarginSize = 10.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.register(UINib(nibName: "ApodListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ApodListCollectionViewCell")
        
        setTabBarLogoItem()
        self.calendarButton()
        
        setupGridView()
        apodViewModel.delegate = self
        
        apodViewModel.fillApodList()
        apodViewModel.requestApodList()
    }
    
    
    
    func setupGridView(){
        let flow = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        flow.minimumInteritemSpacing = CGFloat(self.cellMarginSize)
        flow.minimumLineSpacing = CGFloat(self.cellMarginSize)
    }
    

    func apodRequestFinished(apodlist: [ApodModel]?) {
        self.apodlist = apodlist
    }
    
}


extension ViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apodlist?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ApodListCollectionViewCell", for: indexPath) as? ApodListCollectionViewCell else {
            fatalError("Wrong cell class dequeued")
        }
        
        
        if let dataItem = apodlist?[indexPath.row] {
            itemCell.setData(title: dataItem.title ?? "", date: dataItem.date ?? "", imageUrl: dataItem.url ?? "")
            
            itemCell.bringSubviewToFront(itemCell.titleApodCell)
            itemCell.bringSubviewToFront(itemCell.dateApodCell)
            
            itemCell.contentView.layer.cornerRadius = 5.0
            itemCell.contentView.layer.borderWidth = 1.0
            itemCell.layer.shadowRadius = 5.0
        }
        return itemCell
    }
    
    
}
extension ViewController:UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var vc = ApodDetailTableViewController.instantiateFromXIB() as ApodDetailTableViewController
        if let dataItem = apodlist?[indexPath.row] {
            vc.title = "Apod: \(dataItem.date ?? "No date")"
            vc.installListener()
            vc.requestRow(apodDetailDate: dataItem.date ?? "")
            self.pushVc(vc, navigationBarIsHidden: false)
            vc.backButton()
            vc.calendarButton()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.calculateWidth()
        return CGSize(width: width, height: width)
    }
    
    func calculateWidth() -> CGFloat {
        let estimatedWidth = CGFloat(estimateWidth)
        let cellCount = floor(CGFloat(self.view.frame.size.width / estimatedWidth))
        let margin = CGFloat(cellMarginSize * 2)
        let width = (self.view.frame.size.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) / cellCount
        return width
    }
    
}


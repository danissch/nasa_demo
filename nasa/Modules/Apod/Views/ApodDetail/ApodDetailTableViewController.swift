//
//  ApodDetailTableViewController.swift
//  nasa
//
//  Created by Daniel Durán Schütz on 7/09/20.
//  Copyright © 2020 Daniel Durán Schütz. All rights reserved.
//

import UIKit

class ApodDetailTableViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var apodRow:ApodModel? {
        didSet{
                tableView.reloadData()
        }
    }
    var heightForMedia:CGFloat = 160.0
    var heightForContet:CGFloat = 400.0
    var estimatedHeightForContent:CGFloat = 600
    
    lazy var apodViewModel: ApodViewModel = {
       return ApodViewModel()
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(UINib(nibName: "ApodDetailMediaTableViewCell", bundle: nil), forCellReuseIdentifier: "ApodDetailMediaTableViewCell")
        self.tableView.register(UINib(nibName: "ApodDetailContentTableViewCell", bundle: nil), forCellReuseIdentifier: "ApodDetailContentTableViewCell")
        
        self.tableView.estimatedRowHeight = estimatedHeightForContent
        self.tableView.rowHeight = UITableView.automaticDimension
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//            installListener()
//            requestRow()
    }
    
    
    func installListener(){
        apodViewModel.listenerSingleApod = { apodRes in
            if let apodItem = apodRes as ApodModelRes? {
                self.apodRow = ApodModel(copyright: apodItem.copyright, date: apodItem.date, explanation: apodItem.explanation, hdurl: apodItem.hdurl, media_type: apodItem.media_type, service_version: apodItem.service_version, title: apodItem.title, url: apodItem.url)
            }
        }
    }
    func requestRow(apodDetailDate:String){
        self.apodViewModel.requestSingleApod(date: apodDetailDate ?? "", hd: false)
    }
    
}

extension ApodDetailTableViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat = 0
        switch indexPath.row {
            case 0:
                height = heightForMedia
            case 1:
                height = heightForContet
            default: break
                
        }
        return height
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat = 0
        switch indexPath.row {
            case 0:
                height = heightForMedia
            case 1:
                height = UITableView.automaticDimension
                //height = heightForContet
            default: break
                
        }
        return height
    }
}

extension ApodDetailTableViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        switch indexPath.row {
        case 0:
            let newcell = tableView.dequeueReusableCell(withIdentifier: "ApodDetailMediaTableViewCell", for: indexPath) as! ApodDetailMediaTableViewCell
            if let item = apodRow {
                newcell.setData(imageUrl: item.url ?? "", cVc: self, detailTitle: item.title ?? "")
            }
            cell = newcell
        case 1:
            let newCell = tableView.dequeueReusableCell(withIdentifier: "ApodDetailContentTableViewCell", for: indexPath) as! ApodDetailContentTableViewCell
            if let item = apodRow {
                newCell.setData(title: item.title ?? "No title", date: item.date ?? "No date", description: item.explanation ?? "No description")
            }
            cell = newCell
            let indexPath = IndexPath(item: indexPath.row, section: 0)
            tableView.reloadRows(at: [indexPath], with: .fade)
        default: break
    
        }
        
        
        return cell
    }

}

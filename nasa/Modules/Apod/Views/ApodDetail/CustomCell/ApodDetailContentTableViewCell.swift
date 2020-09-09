//
//  ApodDetailContentTableViewCell.swift
//  nasa
//
//  Created by Daniel Durán Schütz on 8/09/20.
//  Copyright © 2020 Daniel Durán Schütz. All rights reserved.
//

import UIKit

class ApodDetailContentTableViewCell: UITableViewCell {


    @IBOutlet weak var tableView: UITableView!
    var title:String?
    var date:String?
    var explanation:String?
    
    let cellReuseIdentifier = "cell"
    let explanationEstimatedRowHeight:CGFloat = 900
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        // Initialization code
        self.tableView.estimatedRowHeight = explanationEstimatedRowHeight
        self.tableView.rowHeight = UITableView.automaticDimension
    }

    func setData(title:String, date:String, description:String){
        self.title = title
        self.date = date
        self.explanation = description
        tableView.reloadData()
    }
    
}
extension ApodDetailContentTableViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat = 0
        switch indexPath.row {
            case 0:
                height = UITableView.automaticDimension
            case 1:
                height = UITableView.automaticDimension
            default: break
                
        }
        return height
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat = 0
        switch indexPath.row {
            case 0:
                height = UITableView.automaticDimension
            case 1:
                height = UITableView.automaticDimension
            
            default: break
                
        }
        return height
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
        footerView.backgroundColor = UIColor.white
        return footerView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60.0
    }
}

extension ApodDetailContentTableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell? ?? UITableViewCell()
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = self.title
            cell.textLabel?.lineBreakMode = .byWordWrapping
            cell.textLabel?.numberOfLines = 0;
            cell.textLabel?.font = UIFont(name: "Helvetica", size: 17.0)
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
            
        case 1:
            cell.textLabel?.text = self.explanation
            cell.textLabel?.lineBreakMode = .byWordWrapping
            cell.textLabel?.numberOfLines = 0;
            cell.textLabel?.font = UIFont(name: "Helvetica", size: 15.0)
            
        default:
            cell.textLabel?.text = ""
            break
        }
        // set the text from the data model
        
        
        return cell
    }
    
    
}

//
//  BottomSheetDatePickerViewController.swift
//  nasa
//
//  Created by Daniel Durán Schütz on 8/09/20.
//  Copyright © 2020 Daniel Durán Schütz. All rights reserved.
//

import Foundation
import UIKit

protocol BottomSheetDatePickerViewControllerDelegate: UIViewController {
    func dateSelected(date:String?)
}

class BottomSheetDatePickerViewController: UIViewController {
    var delegate:BottomSheetDatePickerViewControllerDelegate?
    
    @IBOutlet weak var bottomSheetViewContainer: UIView!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!

    @IBOutlet weak var viewHeightCtr: NSLayoutConstraint!
    @IBOutlet weak var viewBottomCtr: NSLayoutConstraint!
    var dateForPicker:String? = ""
    
    struct BottomSheetConstants {
        static let viewBottomOrTopConstant:CGFloat = 360
        static let finalHeight:CGFloat = 360
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setHeightToBottomView()
        
        
        datePicker.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)
        datePicker.maximumDate = Date()
        datePicker.setDate(Date(), animated: false)
        dateForPicker = datePicker.date.getFormattedDate(format: "yyyy-MM-dd")
        print("appflow:: viewDidLoad():: dateForPicker \(dateForPicker)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showAnimatedOptions()
    }
    
    private func setHeightToBottomView(){
        let heightForAll = BottomSheetConstants.finalHeight
        viewHeightCtr.constant = heightForAll
    }
    
    private func showAnimatedOptions(){
        viewBottomCtr.constant = .zero
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    @IBAction func actionCloseButton(_ sender: Any) {
        close()
    }
    
    func close(){
        viewBottomCtr.constant = BottomSheetConstants.viewBottomOrTopConstant
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        }, completion: { finished in
            self.dismiss(animated: true)
        })
    }
    
    @IBAction func actionDoneButton(_ sender: Any) {
        datePickerChanged()
        delegate?.dateSelected(date: dateForPicker)
        close()
    }
    
    
    
    @objc func datePickerChanged() {
        dateForPicker = datePicker.date.getFormattedDate(format: "yyyy-MM-dd")
        print("appflow::datePickerChanged dateForPicker : \(dateForPicker)")
    }
    
    
}

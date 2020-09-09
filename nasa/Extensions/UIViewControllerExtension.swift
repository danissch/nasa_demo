//
//  UIViewControllerExtension.swift
//  nasa
//
//  Created by Daniel Durán Schütz on 7/09/20.
//  Copyright © 2020 Daniel Durán Schütz. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController: BottomSheetDatePickerViewControllerDelegate {
    
    
    func presentWithStyle1(vcFrom:UIViewController, vcTo:UIViewController, animated:Bool = true, presentStyle:UIModalPresentationStyle = .fullScreen, transitionStyle:UIModalTransitionStyle = .coverVertical){
        vcTo.modalPresentationStyle = presentStyle
        vcTo.modalTransitionStyle = transitionStyle
        vcFrom.present(vcTo, animated: true, completion: nil)
    }
    
    func pushVc(_ uiViewController: UIViewController, animated:Bool = true, navigationBarIsHidden:Bool, presentStyle:UIModalPresentationStyle = .fullScreen, transitionStyle:UIModalTransitionStyle = .coverVertical){
        uiViewController.modalPresentationStyle = presentStyle
        
        
        self.navigationController?.modalPresentationStyle = presentStyle
        self.navigationController?.modalTransitionStyle = transitionStyle
        
        if navigationBarIsHidden{
            self.navigationController?.navigationBar.isHidden = true
        }else{
            self.navigationController?.navigationBar.isTranslucent = false
            self.navigationController?.navigationBar.barTintColor = UIColor.black
            self.navigationController?.navigationBar.tintColor = UIColor.white
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 16)]
        }
        
        self.navigationController?.pushViewController(uiViewController, animated: animated)

    }
    
    
    
    
    internal class func instantiateFromXIB<T:UIViewController>() -> T{
        let xibName = T.stringRepresentation
        let vc = T(nibName: xibName, bundle: nil)
        return vc
    }
    
    func setTabBarLogoItem(image:String = "nasa_logo"){
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: image), for: .normal)
        button.tintColor = UIColor.red
        //button.addTarget(self, action: #selector(openBottomSheetDatePicker), for: .touchUpInside)

        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 82).isActive = true
        navigationItem.leftBarButtonItem = menuBarItem
         
    }
    
    
    @objc internal func backButton(image:String = "arrow-left-white"){
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: image), for: .normal)
        button.addTarget(self, action: #selector(navigateBack), for: .touchUpInside)

        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true
        navigationItem.leftBarButtonItem = menuBarItem
    }
    
    @objc internal func calendarButton(image:String = "calendar"){
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: image), for: .normal)
        button.tintColor = UIColor.white
        button.addTarget(self, action: #selector(openBottomSheetDatePicker), for: .touchUpInside)

        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true
        navigationItem.rightBarButtonItem = menuBarItem
    }
    
    @objc func openBottomSheetDatePicker(){
        let vc = BottomSheetDatePickerViewController.instantiateFromXIB() as BottomSheetDatePickerViewController
        guard let vcOf = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        vc.delegate = self
        //vc.delegate = vcOf as! BottomSheetDatePickerViewControllerDelegate
        //pushVc(vc, animated:true, navigationBarIsHidden:false, presentStyle:.overCurrentContext, transitionStyle: .crossDissolve)
        
        presentWithStyle1(vcFrom: vcOf, vcTo: vc, animated: true, presentStyle: .overCurrentContext, transitionStyle: .crossDissolve)
    }
    
    func dateSelected(date: String?) {
        var vc = ApodDetailTableViewController.instantiateFromXIB() as ApodDetailTableViewController
        print("appflow::actionDoneButton:: BottomSheetDatePickerViewControllerDelegate:: dateSelected date:: \(date)")
        vc.title = "Apod: \(date ?? "No date")"
        vc.installListener()
        vc.requestRow(apodDetailDate: date ?? "")
        self.pushVc(vc, navigationBarIsHidden: false)
        vc.backButton()
        vc.calendarButton()
        
    }
    
    @objc internal func navigateBack(){
        if isModal {
            dismiss(animated: true, completion: nil)
        }else{
            _ = navigationController?.popViewController(animated: true)
        }
    }
    
    var isModal:Bool {
        if presentingViewController != nil {
            return true
        }
        if presentingViewController?.presentedViewController == self {
            return true
        }
        if navigationController?.presentingViewController?.presentedViewController == navigationController {
            return true
        }
        if tabBarController?.presentingViewController is UITabBarController {
            return true
        }
        
        return false
    }
}

//
//  ContainerVC.swift
//  GoogleKeep
//
//  Created by admin on 17/04/21.
//

import UIKit

class ContainerVC: UIViewController {
    
    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!
    
    var sideMenuOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(showSideMenu), name: NSNotification.Name("showSideMenu"), object: nil)
        
    }
    
    @objc func showSideMenu(){
        if sideMenuOpen {
            sideMenuOpen = false
            sideMenuConstraint.constant = -240
    
        }else{
            sideMenuOpen = true
            sideMenuConstraint.constant = 0
            
        }
        UIView.animate(withDuration: 0.3){
            self.view.layoutIfNeeded()
        }
    }

 
}

//
//  MainVC.swift
//  GoogleKeep
//
//  Created by admin on 17/04/21.
//

import UIKit

class MainVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(showNote), name: NSNotification.Name("showNote"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showReminder), name: NSNotification.Name("showReminder"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showSignIn), name: NSNotification.Name("showSignIn"), object: nil)
        
    }
    
    @objc func showNote() {
       performSegue(withIdentifier: "showNote", sender: nil)
    }
    
    @objc func showReminder() {
        performSegue(withIdentifier: "showReminder", sender: nil)
    }
    
    @objc func showSignIn() {
        performSegue(withIdentifier: "showSignIn", sender: nil)
    }

    
   
    @IBAction func onMoreTapped(){
        print("menu bar ")
        NotificationCenter.default.post(name: NSNotification.Name("showSideMenu"), object: nil)
    }

}

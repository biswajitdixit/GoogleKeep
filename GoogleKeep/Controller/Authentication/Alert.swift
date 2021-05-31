//
//  Alert.swift
//  GoogleKeep
//
//  Created by admin on 11/04/21.
//

import Foundation
import UIKit
class Alert {
    
    static func createAlertController(title: String, message: String) -> UIAlertController {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                alert.dismiss(animated: true, completion: nil)
            }
            
            alert.addAction(okAction)
            
            return alert
        }
    }



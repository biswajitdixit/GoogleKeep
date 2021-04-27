//
//  CustomButton.swift
//  GoogleKeep
//
//  Created by admin on 20/04/21.
//

import Foundation
import UIKit
class CustomButton: UIButton{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setRadiusAndShadow()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        setRadiusAndShadow()
    }
    func setRadiusAndShadow(){
        layer.cornerRadius = 20
        clipsToBounds = true
        layer.masksToBounds = false
        layer.shadowRadius = 10
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize(width: 3, height: 3)
        //layer.shadowColor = UIColor.blue.cgColor
    }
}


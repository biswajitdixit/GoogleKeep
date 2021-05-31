//
//  RoundButton.swift
//  GoogleKeep
//
//  Created by admin on 12/05/21.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {

   @IBInspectable var roundButton:Bool = false {
        didSet {
            if roundButton {
                layer.cornerRadius = frame.height / 2
            }
        }
    }
    override  func prepareForInterfaceBuilder() {
        if roundButton {
            layer.cornerRadius = frame.height / 2
        }
    }
}

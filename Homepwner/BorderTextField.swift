//
//  BorderTextField.swift
//  Homepwner
//
//  Created by 신현욱 on 2021/03/01.
//

import UIKit

class BorderTextFiled : UITextField
{
    override func becomeFirstResponder() -> Bool {
        self.borderStyle = .line
        return super.becomeFirstResponder()
    }
//
    override func resignFirstResponder() -> Bool {
        self.borderStyle = .roundedRect

        return super.resignFirstResponder()
    }
}

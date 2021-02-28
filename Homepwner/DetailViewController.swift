//
//  DetailViewController.swift
//  Homepwner
//
//  Created by 신현욱 on 2021/03/01.
//

import UIKit

class DetailViewConroller : UIViewController {
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialNumberField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    
    var item: Item!
    
    let numberFormatter : NumberFormatter = {
        let formmater = NumberFormatter()
        formmater.numberStyle = .decimal
        formmater.minimumFractionDigits = 2
        formmater.maximumFractionDigits = 2
        return formmater
    }()
    
    let dateFormatter : DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialNumberField.text = item.serialNumber
//        valueField.text = "\(item.valueInDollars)"
//        dateLabel.text = "\(item.dateCreated)"
        valueField.text = numberFormatter.string(from: NSNumber(integerLiteral: item.valueInDollars) )
        dateLabel.text = dateFormatter.string(from: item.dateCreated as Date)
    }
}

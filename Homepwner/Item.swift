//
//  Item.swift
//  Homepwner
//
//  Created by 신현욱 on 2021/02/25.
//

import UIKit

class Item: NSObject, NSCoding {

    var name: String
    var valueInDollars: Int
    var serialNumber: String?
    let dateCreated: NSDate
    let itemKey: String
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(dateCreated, forKey: "dateCreated")
        coder.encode(serialNumber, forKey: "serialNumber")
        coder.encode(itemKey, forKey: "itemKey")
        coder.encode(valueInDollars, forKey: "valueInDollars")
    }
    
    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as! String
        dateCreated = coder.decodeObject(forKey: "dateCreated") as! NSDate
        serialNumber = coder.decodeObject(forKey: "serialNumber") as? String
        itemKey = coder.decodeObject(forKey: "itemKey") as! String
        valueInDollars = coder.decodeInteger(forKey: "valueInDollars") 
        
        super.init()
    }
    
    init(name: String, serialNumber: String?, valueInDollars: Int) {
        self.name = name
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        self.dateCreated = NSDate()
        self.itemKey = NSUUID().uuidString
        
        super.init()
    }
    
    convenience init(random: Bool = false) {
        if random {
            let adjectives = ["Fluffy", "Rusty", "Shiny"]
            let nonus = ["Bear", "Spork", "Mac"]
            
            var idx = arc4random_uniform(UInt32(adjectives.count))
            let randomAdjective = adjectives[Int(idx)]
            
            idx = arc4random_uniform(UInt32(nonus.count))
            let randomNoun = nonus[Int(idx)]
            
            let randomName = "\(randomAdjective) \(randomNoun)"
            let randomValue = Int(arc4random_uniform(100))
            let randomSerialNumber = NSUUID().uuidString.components(separatedBy: "-").first!
            
            self.init(name: randomName, serialNumber: randomSerialNumber, valueInDollars: randomValue)
        }
        else {
            self.init(name:"", serialNumber: nil, valueInDollars: 0)
        }
    }
}

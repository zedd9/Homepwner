//
//  ImageStore.swift
//  Homepwner
//
//  Created by 신현욱 on 2021/03/01.
//

import UIKit

class ImageStore {
    let cache = NSCache<AnyObject, AnyObject>()
    
    func setImage(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func imageForKey(key: String) -> UIImage? {
        return cache.object(forKey: key as NSString) as! UIImage?
    }
    
    func deleteImageForKey(key: String) {
        cache.removeObject(forKey: key as NSString)
    }
}

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
        
        let imageURL = imageURLForKey(key: key)
        
        if let data = image.jpegData(compressionQuality: 0.5) {
            try! data.write(to: imageURL, options: .atomic)
        }
    }
    
    func imageForKey(key: String) -> UIImage? {
        if let existingImage = cache.object(forKey: key as NSString) as? UIImage {
            return existingImage
        }
        
        let imageURL = imageURLForKey(key: key)
        guard let imageFromDisk = UIImage(contentsOfFile: imageURL.path ) else {
            return nil
        }
        
        cache.setObject(imageFromDisk, forKey: key as NSString)
        return imageFromDisk
    }
    
    func deleteImageForKey(key: String) {
        cache.removeObject(forKey: key as NSString)
        
        let imageURL = imageURLForKey(key: key)
        do {
            try FileManager.default.removeItem(at: imageURL)
        } catch let deleteError {
            print("Error removing the image form disk: \(deleteError)")
        }
    }
    
    func imageURLForKey(key: String) -> URL {
        let documentsDirecories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirecotry = documentsDirecories.first!
        
        return documentDirecotry.appendingPathComponent(key)
    }
}

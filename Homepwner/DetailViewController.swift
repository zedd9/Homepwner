//
//  DetailViewController.swift
//  Homepwner
//
//  Created by 신현욱 on 2021/03/01.
//

import UIKit

class DetailViewConroller : UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialNumberField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }
    
    var imageStore: ImageStore!
    
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
        
        view.endEditing(true)
        
        nameField.text = item.name
        serialNumberField.text = item.serialNumber
//        valueField.text = "\(item.valueInDollars)"
//        dateLabel.text = "\(item.dateCreated)"
        valueField.text = numberFormatter.string(from: NSNumber(integerLiteral: item.valueInDollars) )
        dateLabel.text = dateFormatter.string(from: item.dateCreated as Date)
        
        let key = item.itemKey
        
        let imageToDisplay = imageStore.imageForKey(key: key)
        imageView.image = imageToDisplay
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        item.name = nameField.text ?? ""
        item.serialNumber = serialNumberField.text
        
        if let valueText = valueField.text, let value = numberFormatter.number(from: valueText) {
            item.valueInDollars = value.intValue
        } else {
            item.valueInDollars = 0
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func tackPicture(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        
        imagePicker.allowsEditing = true
        
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        if imageView.image != nil {
            let key = item.itemKey
            imageStore.deleteImageForKey(key: key)
        }
        
        imageStore.setImage(image: image, forKey: item.itemKey)
        
        imageView.image = image
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteImage(_ sender: UIBarButtonItem) {
        if imageView.image != nil {
            let key = item.itemKey
            imageStore.deleteImageForKey(key: key)
            imageView.image = nil
        }
    }
}

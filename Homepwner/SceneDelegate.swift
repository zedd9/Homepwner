//
//  SceneDelegate.swift
//  Homepwner
//
//  Created by 신현욱 on 2021/02/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var itemStore: ItemStore = ItemStore()

    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        let imageStore = ImageStore()
        
        //let itemsController = window!.rootViewController as! ItemsViewController
        let navController = window!.rootViewController as! UINavigationController
        let itemsController = navController.topViewController as! ItemsViewController
        itemsController.itemStore = itemStore
        itemsController.imageStore = imageStore        
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    @available(iOS 13.0, *)
    func sceneDidEnterBackground(_ scene: UIScene) {
        let success = itemStore.saveChanges()
        if success {
            print("Saved all of the Items")
        } else {
            print("Could not save any of the Items")
        }
    }
}


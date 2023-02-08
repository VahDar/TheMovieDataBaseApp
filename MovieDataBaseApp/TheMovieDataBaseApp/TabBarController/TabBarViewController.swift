//
//  TabBarViewController.swift
//  TheMovieDataBaseApp
//
//  Created by Vakhtang on 28.01.2023.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func SignOutButton(_ sender: Any) {
        Task { @MainActor in
            
            let result = AuthenticalNetworking.shared.logOut
            if try await result().success {
                DispatchQueue.main.async {
                    let storybord = UIStoryboard(name: "Main", bundle: nil)
                    let authVC = storybord.instantiateViewController(withIdentifier: "AuthenticalViewController")
                    self.view.window?.rootViewController = authVC
                    self.view.window?.makeKeyAndVisible()
                }
            }
        }
    }
}
    


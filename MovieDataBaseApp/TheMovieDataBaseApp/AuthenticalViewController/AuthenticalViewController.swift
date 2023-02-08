//
//  AuthenticalViewController.swift
//  TheMovieDataBaseApp
//
//  Created by Vakhtang on 17.01.2023.
//

import UIKit

class AuthenticalViewController: ViewController {
    
    var authViewModel = AuthentionViewModel()
   
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logInButton(_ sender: Any) {
        
        Task { @MainActor in
            try await authViewModel.logIn(usernameTextField.text ?? "", passwordTextField.text ?? "")
            
            if authViewModel.isLogin {
                
                let navigationControllerId = storyboard?.instantiateViewController(withIdentifier: "navigationCotnrollerID")
                self.view.window?.rootViewController = navigationControllerId
                self.view.window?.makeKeyAndVisible()
                
            }
        }
    }
    
    @IBAction func guestButton(_ sender: Any) {
                Task { @MainActor in
                    try await authViewModel.guestSungIn()
                    if authViewModel.isLogin {
                        let guestLogIn = storyboard?.instantiateViewController(withIdentifier: "navigationCotnrollerID")
                        self.view.window?.rootViewController = guestLogIn
                        self.view.window?.makeKeyAndVisible()
                        
                }
            }
        }
}

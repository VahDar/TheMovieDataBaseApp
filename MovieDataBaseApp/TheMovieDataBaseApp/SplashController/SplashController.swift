//
//  SplashController.swift
//  TheMovieDataBaseApp
//
//  Created by Vakhtang on 02.03.2023.
//

import UIKit

class SplashController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        present()
        
        }
        
        func present() {
            UIView.animate(withDuration: 0.3) {
                self.logoImageView.transform = CGAffineTransform(scaleX: 280 / 130, y: 280 / 130)
                self.logoImageView.image = UIImage(named: "logowight")
            }
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                self.performSegue(withIdentifier: "OpenAuth", sender: nil)
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  LastViewController.swift
//  RestaurantApp
//
//  Created by Kalbek Saduakassov on 16.06.2021.
//

import UIKit

class LastViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "royal2")!)
        let congratsAlert = UIAlertController(title: "Congratulations!", message: "Your have successfully purchased your items!", preferredStyle: .alert)
        let lastAction = UIAlertAction(title: "Go to Profile page", style: .default) { _ in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "infoVC") as! InformationViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
            congratsAlert.addAction(lastAction)
            self.present(congratsAlert, animated: true)
        
        
    }
}

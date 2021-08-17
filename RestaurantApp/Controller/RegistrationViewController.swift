//
//  RegistrationViewController.swift
//  RestaurantApp
//
//  Created by Kalbek Saduakassov on 15.06.2021.
//

import UIKit
import Firebase

class RegistrationViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var registrationButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "royal2")!)
        self.title = "Registration Page"
    }
 
    @IBAction func registrationButtonPressed(_ sender: Any) {
        guard let email = emailField.text else { return }
        guard let password = passwordField.text else { return }

        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (result, error) in
            if let error = error {
                print(error)
            } else {
                let vc = self?.storyboard?.instantiateViewController(withIdentifier: "infoVC") as! InformationViewController
                
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }

}

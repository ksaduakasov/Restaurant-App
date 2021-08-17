//
//  LoginViewController.swift
//  RestaurantApp
//
//  Created by Kalbek Saduakassov on 15.06.2021.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "royal2")!)
        loginButton.layer.cornerRadius = 4
        loginButton.layer.masksToBounds = true
        self.title = "Login Page"
    }
 
    @IBAction func loginButtonPressed(_ sender: Any) {
        guard let email = emailField.text else { return }
        guard let password = passwordField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, error) in
            if error != nil {
                print("Failed to login, \(error!)")
            } else {
//                self?.performSegue(withIdentifier: "goToChatFromLogin", sender: nil)
                let vc = self?.storyboard?.instantiateViewController(withIdentifier: "infoVC") as! InformationViewController
                
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    @IBAction func goTORegister(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "registerVC") as! RegistrationViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

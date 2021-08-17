//
//  InformationViewController.swift
//  RestaurantApp
//
//  Created by Kalbek Saduakassov on 18.06.2021.
//

import UIKit
import Firebase

class InformationViewController: UIViewController {
    @IBOutlet weak var userLable: UILabel!
    @IBOutlet weak var tablesLabel: UILabel!
    @IBOutlet weak var foodArray: UILabel!
    
    static var tablesArray: [String] = []
    static var foodArray: [String] = []
    static var foodPrice: Float = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "royal2")!)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logoutButtonPressed))
        print(InformationViewController.tablesArray.count)
        print(InformationViewController.foodArray.count)
        updateUI()
        self.title = "Information Page"
    }
    
    func updateUI() {
        userLable.text = Auth.auth().currentUser?.email
        var tempString = ""
        for i in 0 ..< InformationViewController.tablesArray.count {
            tempString += "\(InformationViewController.tablesArray[i])\n"
            
        }
        tablesLabel.text = tempString
        var tempString2 = ""
        for i in 0 ..< InformationViewController.foodArray.count {
            tempString2 += "\(InformationViewController.foodArray[i])\n"
            
        }
       
        foodArray.text = "\(tempString2)\n \(InformationViewController.foodPrice) $"
        
    }
    
    @objc func logoutButtonPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            let vc = storyboard?.instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
            navigationController?.pushViewController(vc, animated: true)
         
        } catch {
            print("Failed to log out, \(error)")
        }
    }

    @IBAction func backToMainPage(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    

}

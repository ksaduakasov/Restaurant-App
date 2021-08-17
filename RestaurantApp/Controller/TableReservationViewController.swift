//
//  TableReservationViewController.swift
//  RestaurantApp
//
//  Created by Kalbek Saduakassov on 18.06.2021.
//

import UIKit

class TableReservationViewController: UIViewController {
    @IBOutlet weak var table1: UIButton!
    @IBOutlet weak var table2: UIButton!
    @IBOutlet weak var table3: UIButton!
    @IBOutlet weak var table4: UIButton!
    @IBOutlet weak var table5: UIButton!
    @IBOutlet weak var table6: UIButton!
    @IBOutlet weak var table7: UIButton!
    @IBOutlet weak var table8: UIButton!
    
    var array: [UIButton] = []
    var tempArr: [String] = []
   

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "royal2")!)
        self.title = "Table Reserving Page"
        table1.tag = 1
        table2.tag = 2
        table3.tag = 3
        table4.tag = 4
        table5.tag = 5
        table6.tag = 6
        table7.tag = 7
        table8.tag = 8
        array = [table1, table2, table3, table4, table5, table6, table7, table8]
        print(array.count)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Confirm", style: .plain, target: self, action: #selector(goToUserInfo))
        validate()
    }
    
    func validate() {
        for i in 0 ..< array.count {
            for j in 0 ..< ViewController.flagsForTables.count {
                if array[i].tag == ViewController.flagsForTables[j] {
                    array[i].isEnabled = false
                    array[i].setImage(UIImage(named: "selected"), for: .normal)
                }
            }
        }
    }
    
    
    @IBAction func table1DidTapped(_ sender: Any) {
        reserve(table1)
        ViewController.flagsForTables.append(table1.tag)
    }
    @IBAction func table2DidTapped(_ sender: Any) {
        reserve(table2)
        ViewController.flagsForTables.append(table2.tag)
    }
    @IBAction func table3DidTapped(_ sender: Any) {
        reserve(table3)
        ViewController.flagsForTables.append(table3.tag)
    }
    @IBAction func table4DidTapped(_ sender: Any) {
        reserve(table4)
        ViewController.flagsForTables.append(table4.tag)
    }
    
    @IBAction func table6DidTapped(_ sender: Any) {
        reserve(table6)
        ViewController.flagsForTables.append(table6.tag)
    }
    
    @IBAction func table5DidTapped(_ sender: Any) {
        reserve(table5)
        ViewController.flagsForTables.append(table5.tag)
    }
    
    @IBAction func table7DidTapped(_ sender: Any) {
        reserve(table7)
        ViewController.flagsForTables.append(table7.tag)
    }
    
    @IBAction func table8DidTapped(_ sender: Any) {
        reserve(table8)
        ViewController.flagsForTables.append(table8.tag)
    }
    
    func reserve(_ button: UIButton) {
        if array.contains(button) {
            switch button.tag {
            case 1:
                let btnImage = UIImage(named: "selected")
                button.setImage(btnImage , for: .normal)
            case 7:
                let btnImage = UIImage(named: "selected")
                button.setImage(btnImage , for: .normal)
            case 2:
                let btnImage = UIImage(named: "corp_filled")
                button.setImage(btnImage , for: .normal)
            case 8:
                let btnImage = UIImage(named: "corp_filled")
                button.setImage(btnImage , for: .normal)
            case 3:
                let btnImage = UIImage(named: "double_filled")
                button.setImage(btnImage , for: .normal)
            case 5:
                let btnImage = UIImage(named: "double_filled")
                button.setImage(btnImage , for: .normal)
            case 4:
                let btnImage = UIImage(named: "single_filled")
                button.setImage(btnImage , for: .normal)
            case 6:
                let btnImage = UIImage(named: "single_filled")
                button.setImage(btnImage , for: .normal)
            default:
                print("")
            }
            button.isEnabled = false
            tempArr.append("table\(button.tag)")
            InformationViewController.tablesArray.append("table\(button.tag)")
            } else {
                print("table has already been selected!")
            }
    }
    @IBAction func button(_ sender: Any) {
        InformationViewController.tablesArray = tempArr
        let vc = storyboard?.instantiateViewController(withIdentifier: "infoVC") as! InformationViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func goToUserInfo() {

        let alert = UIAlertController(title: "You selected your tables", message: "Are you sure?", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "No", style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        
        let action2 = UIAlertAction(title: "Yes", style: .default) { (_) in
            let congratsAlert = UIAlertController(title: "Congratulations!", message: "Your have successfully reserved the tables!", preferredStyle: .alert)
            let lastAction = UIAlertAction(title: "OK", style: .default) { _ in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "infoVC") as! InformationViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            congratsAlert.addAction(lastAction)
            self.present(congratsAlert, animated: true)
        }
        alert.addAction(action1)
        alert.addAction(action2)
        present(alert, animated: true)
        
      
    }
    

}


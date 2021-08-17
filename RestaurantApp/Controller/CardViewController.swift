//
//  CardViewController.swift
//  RestaurantApp
//
//  Created by Kalbek Saduakassov on 15.06.2021.
//

import UIKit

class CardViewController: UIViewController {
    static var storedArray: [MenuModel.Entities.Menu.Section.MenuItem] = []
    static var counter = false
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet{
            let nib = UINib(nibName: "CardCell", bundle: nil)
            self.collectionView.register(nib, forCellWithReuseIdentifier: "cell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "royal2")!)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Purchase", style: .plain, target: self, action: #selector(purchaseItems))
        collectionView.delegate = self
        collectionView.dataSource = self
        print(CardViewController.storedArray.count)
        
        let screenSize: CGRect!  = UIScreen.main.bounds
        let screenWidth: CGFloat! = screenSize.width
        var _: CGFloat! = screenSize.height
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth/2, height: screenWidth/2
        )
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView!.collectionViewLayout = layout
        
    }
}

extension CardViewController: CardCellProtocol {
    func deleteFood(cell: CardCell, object: MenuModel.Entities.Menu.Section.MenuItem) {
        for i in 0 ..< CardViewController.storedArray.count {
            if CardViewController.storedArray[i].itemName == object.itemName {
                CardViewController.storedArray.remove(at: i)
                break
            }
        }
        self.collectionView.reloadData()
    }
    
    @objc func purchaseItems() {
        var counter: Float = 0
        var list: [String] = []
        for i in 0 ..< CardViewController.storedArray.count {
            counter += CardViewController.storedArray[i].price!
            list.append(CardViewController.storedArray[i].itemName!)
        }
        let alert = UIAlertController(title: "The total price is \(counter) $!", message: "Confirm your purchase", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "No", style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        
        let action2 = UIAlertAction(title: "Yes", style: .default) { (_) in
            //            let congratsAlert = UIAlertController(title: "Congratulations!", message: "Your have successfully purchased your items!", preferredStyle: .alert)
            //            let lastAction = UIAlertAction(title: "Go to main page", style: .default) { _ in
            //                self.navigationController?.popToRootViewController( animated: true)
            //            }
            InformationViewController.foodArray = list
            InformationViewController.foodPrice = counter
            if CardViewController.counter {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "lastVC") as! LastViewController
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                CardViewController.counter = true
                let congratsAlert = UIAlertController(title: "Before you make purchase, you have to sign in", message: "Please log in!", preferredStyle: .alert)
                let lastAction = UIAlertAction(title: "Sign In", style: .default) { _ in
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                congratsAlert.addAction(lastAction)
                self.present(congratsAlert, animated: true)
                CardViewController.storedArray.removeAll()
                self.collectionView.reloadData()
            }
        }
        alert.addAction(action1)
        alert.addAction(action2)
        present(alert, animated: true)
        
    }
    
    
}

extension CardViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CardViewController.storedArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CardCell
        //        print(storedArray[indexPath.row].itemName)
        cell.object = CardViewController.storedArray[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 185)
    }
    
    
}

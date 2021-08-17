//
//  DetailsViewController.swift
//  RestaurantApp
//
//  Created by Kalbek Saduakassov on 15.06.2021.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    
    var object: MenuModel.Entities.Menu.Section.MenuItem?
    var posterURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "royal2")!)
        updateUI(object, posterURL)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        updateUI(object, posterURL)
    }
    
    private func updateUI(_ details: MenuModel.Entities.Menu.Section.MenuItem?, _ posterURL: String?) {
        if let object = object {
            self.titleLabel.text = object.itemName
            self.descriptionLabel.text = object.description != "" ? object.description : "This product does not have a description"
            self.priceLabel.text = "\(object.price!) $"
            let posterURL = URL(string: self.posterURL ?? "")
            self.imageView.kf.setImage(with: posterURL)
            imageView.layer.cornerRadius = 40
            imageView.layer.masksToBounds = true
        }
    }
    @IBAction func favButtonDidTapped(_ sender: Any) {
        //            CoreDataManager.shared.addFood(object!)
        CardViewController.storedArray.append(object!)
        print("added")
        let alert = UIAlertController(title: "Congratulations!", message: "You successfully added the product to card!", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Continue Shopping", style: .default) { (_) in
            
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
}





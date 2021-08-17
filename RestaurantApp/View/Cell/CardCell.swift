//
//  CardCell.swift
//  RestaurantApp
//
//  Created by Kalbek Saduakassov on 15.06.2021.
//

import UIKit

protocol CardCellProtocol {
    func deleteFood(cell:CardCell,object:MenuModel.Entities.Menu.Section.MenuItem)
}

class CardCell: UICollectionViewCell {
   
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    var delegate:CardCellProtocol? = nil

    
    var object: MenuModel.Entities.Menu.Section.MenuItem! {
        didSet {
                productName.text = object.itemName
                productPrice.text = "\(object.price!) $"
                imageView.kf.setImage(with: URL(string: "https://res.cloudinary.com/jobizil/image/upload/v1602768183/images/menus/x4cspjvzqn2qk76sjhiw.jpg"))
            imageView.layer.cornerRadius = 20
            imageView.layer.masksToBounds = true
            }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgView.layer.shadowColor = UIColor.black.cgColor
        self.bgView.layer.shadowOffset = .zero
        self.bgView.layer.shadowOpacity = 0.45
        self.bgView.layer.shadowRadius = 8
        self.bgView.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.bgView.layer.shouldRasterize = true
        self.bgView.layer.cornerRadius = 4
        self.layer.cornerRadius =  4
        
    }
    
    @IBAction func deleteFood(_ sender: Any) {
        if let _ = delegate {
            delegate?.deleteFood(cell: self, object: object)
        }
    }
    
    
    
}

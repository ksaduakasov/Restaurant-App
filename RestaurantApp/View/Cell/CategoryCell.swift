//
//  MusicCell.swift
//  simpleMusicApp
//
//  Created by Kalbek Saduakassov on 22.02.2021.
//

import UIKit
import Kingfisher


class CategoryCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            let nib = UINib(nibName: "FoodCell", bundle: nil)
            self.collectionView.register(nib, forCellWithReuseIdentifier: "cell")
            
        }
    }
    
    @IBOutlet weak var sectionHeader: UILabel!
    
    var indexPath:IndexPath?
    //    var topTracks:[MenuEntity.Entities]?  //json file
    var menu:[MenuModel.Entities.Menu.Section.MenuItem]?
    var posterURL: URL?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setCollectionViewDataSourceDelegate(index:IndexPath, menu:[MenuModel.Entities.Menu.Section.MenuItem]){
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        indexPath = index
        self.menu = menu
        self.collectionView.reloadData()
    }
    
    //    func numberOfSections(in collectionView: UICollectionView) -> Int {
    //        return 1
    //    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menu!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FoodCell
        let obj = menu![indexPath.row]
        cell.productPrice.text = "\(obj.price!) $"
        cell.productName.text = obj.itemName
        
        //        cell.artistName.text = obj?.menuItems[indexPath.row].itemName
        //        cell.trackName.text = obj?.menuItems[indexPath.row].description
        //        cell.trackName.text = obj?.menuname
        //        cell.artistName.text = obj?.description
                let posterURL = URL(string: (ViewController.images[indexPath.row % 3]))
                cell.coverImage.kf.setImage(with: posterURL)
        
        //            cell.coverImage.setImageWithUrl(url: NSURL(string:(obj?.artWork)!)!)
        return cell
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Coll:\(indexPath) - \(String(describing: self.indexPath))")
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let vc = storyboard.instantiateViewController(withIdentifier: "details") as? DetailsViewController {
            vc.object = menu![indexPath.row]
            vc.posterURL = ViewController.images[indexPath.row % 3]
            //                vc.posterURL = topTracks![indexPath.row].images[indexPath.row % 3]
            //                print(topTracks![indexPath.row].id!)
            
            
            self.window?.rootViewController?.present(vc, animated: true, completion: nil)
        }
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




//
//  ViewController.swift
//  simpleMusicApp
//
//  Created by Kalbek Saduakassov on 22.02.2021.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var menu = [MenuModel.Entities.Menu]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    static var flagsForTables: [Int] = []
    
    static var images: [String] = ["https://res.cloudinary.com/jobizil/image/upload/v1602768183/images/menus/x4cspjvzqn2qk76sjhiw.jpg",
                            "https://res.cloudinary.com/jobizil/image/upload/v1602768183/images/menus/xnurgo60mme1ewupfbin.jpg",
                            "https://res.cloudinary.com/jobizil/image/upload/v1602768184/images/menus/ovni4qwzzxbufpsurlsg.jpg",
    "https://i.insider.com/5d0bc2a0e3ecba03841d82d2?width=960&format=jpeg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgzV1Ns7wB1yVGAqutvcms5BvkE4X68Pd2DA&usqp=CAU", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSagKxmNJhlpzZaWJjbZLGToZZ8Gp70mTQW9Q&usqp=CAU", "https://media.npr.org/assets/img/2021/05/27/gettyimages-1320261893-1ebb785d04ae7b0b1da6881095d7c05504d14d66-s800-c85.jpg", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSz81JRbwJtZMt6lwWoiN1gs91sOLT7exndUg&usqp=CAU", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSg4SL9rvY1CWkPeuidaQWwf0wpxO4ssCYMvA&usqp=CAU", "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/screen-shot-2020-07-14-at-5-07-14-pm-1594760850.png?crop=1.00xw:0.789xh;0,0.122xh&resize=480:*", "https://www.frugalnutrition.com/wp-content/uploads/2020/01/Pesto-Veggie-Noodles-Frozen-Meal-Prep-Containers-Frugal-Nutrition-scaled.jpg", "https://static.olocdn.net/menu/chilis/572cc0101868d7f7ad712159640e28b5.jpg", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkzTYLQyzbgM28rcsKFFFtKgly3Gb1TvbtOw&usqp=CAU", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBv9KZxaHhxJAng0v1UNxqFusW5DrS44m2rg&usqp=CAU", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjt3fYoPMv2CfxAm4HYy6FypMxJnsyrWhqYg&usqp=CAU"]
//    var menu = [MenuEntity.Entities]() {
//        didSet {
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//    }
    
    var sectionHeaders = [String]()
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reserve a Table", style: .plain, target: self, action: #selector(goToReservePage))
    }
    
    func initialSetup(){
        let nib =  UINib(nibName: "CategoryCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        loadJSON()
    }
    
    @objc func goToReservePage() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "tableVC") as! TableReservationViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    func loadJSON(){
        let headers: HTTPHeaders = [
                "X-API-KEY": "555c2dc6020a31370d5d87972e6af956"
        ]
        
//        AF.request("https://foodbukka.herokuapp.com/api/v1/menu").responseJSON { response in
//            switch response.result {
//            case .success:
//                if let data = response.data {
//                    do {
//                        let menuJSON = try JSONDecoder().decode(MenuEntity.self, from: data)
//                        self.menu += menuJSON.result!
//                        print(response)
//                    } catch {
//                        print(error)
//                    }
//                }
//            case .failure:
//                print("fail!")
//            }
//        }
        AF.request("https://api.documenu.com/v2/restaurant/4072702673999819", headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        let menuJSON = try JSONDecoder().decode(MenuModel.self, from: data)
                        self.menu += menuJSON.result!.menu
//                        while self.menu[0].menuItems.count != self.menu.count {
//                            self.menu[0].menuItems.removeLast()
//                        }
                        print(self.menu[0].sections.count)
                        print(self.menu[0].sections[0].menuItems.count)
//                        print(self.menu[0].menuItems.count)
                    } catch {
                        print(error)
                    }
                }
            case .failure:
                print("fail!")
            }
        }
    }
        

        
    @IBAction func goToCard(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "cardVC") as! CardViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBOutlet weak var tabBar: UITabBarItem!
    
        
    }
    
    
    extension ViewController: UITableViewDelegate,UITableViewDataSource {
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return self.menu.count//1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.menu[0].sections.count//3
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CategoryCell
            //        cell.cellBg.backgroundColor = .red
            //        cell.sectionHeader.textColor = UIColor.white
            cell.sectionHeader.text = self.menu[0].sections[indexPath.row].sectionName
            
            cell.setCollectionViewDataSourceDelegate(index: indexPath,menu: menu[0].sections[indexPath.row].menuItems)
            //        cell.delegate = self
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 245
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("TableView:\(indexPath)")
        }
        
        
    }








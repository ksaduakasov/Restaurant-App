//
//  MenuEntity.swift
//  RestaurantApp
//
//  Created by Kalbek Saduakassov on 14.06.2021.
//

import Foundation

struct MenuModel: Decodable {
    let result: Entities?
    
    enum CodingKeys: String, CodingKey {
        case result = "result"
    }
    
    struct Entities: Decodable {
        let menu: [Menu]
        
        enum CodingKeys: String, CodingKey {
            case menu = "menus"
        }
        
        struct Menu: Decodable {
            let sections: [Section]
            
            enum CodingKeys: String, CodingKey {
                case sections = "menu_sections"
            }
            
            
            struct Section: Decodable {
                let sectionName: String
                let sectionDescription: String?
                var menuItems: [MenuItem]
                
                enum CodingKeys: String, CodingKey {
                    case sectionName = "section_name"
                    case sectionDescription = "description"
                    case menuItems = "menu_items"
                }
                
                struct MenuItem: Decodable {
                    let itemName: String?
                    let description: String?
                    let price: Float?
                    
                    enum CodingKeys: String, CodingKey {
                        case itemName = "name"
                        case description = "description"
                        case price = "price"
                    }
                    
                    init(food: MenuEntity) {
                        self.itemName = food.name
                        self.description = food.desc
                        self.price = food.price
                    }
                }
            }
        }
        
    }
}


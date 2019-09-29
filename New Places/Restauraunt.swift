//
//  Restauraunt.swift
//  New Places
//
//  Created by Max on 27.09.2019.
//  Copyright © 2019 Max. All rights reserved.
//

import UIKit

struct Place {
    
    var name: String
    var location: String?
    var type: String?
    var restaurantImage: String?
    var image: UIImage?
    
   static var restaurants = ["Ишак", "Колбасофф", "Сливки общества",
    "Урюк", "Хлеб да Соль", "Шляпа Свиньи",
    "Bar BQ Cafe","Burger King",
    "Crazy Daisy", "Fish Point",
    "KFC", "Rose Bar", "The Сад"]
    
    static func getPlaces() -> [Place] {
      
        var places = [Place]()
        
        for place in restaurants {
            places.append(Place(name: place, location: "Москва", type: "Кафе", restaurantImage: place, image: nil))
        }
        
        return places
    }
}

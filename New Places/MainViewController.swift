//
//  MainViewController.swift
//  New Places
//
//  Created by Max on 23.09.2019.
//  Copyright © 2019 Max. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    let restaurants = ["Ишак", "Колбасофф", "Сливки общества",
                       "Урюк", "Хлеб да Соль", "Шляпа Свиньи",
                       "Bar BQ Cafe","Burger King",
                       "Crazy Daisy", "Fish Point",
                       "KFC", "Rose Bar", "The Сад"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return restaurants.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for:
            indexPath) as! MainVCCell
        
        cell.placeName.text = restaurants[indexPath.row]
        cell.placeImage.image = UIImage(named: restaurants[indexPath.row])
        cell.placeImage.layer.cornerRadius = cell.placeImage.frame.size.height / 2
        cell.placeImage.clipsToBounds = true
        
        return cell
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func cancelBtn(_ segue:UIStoryboardSegue) {}

}

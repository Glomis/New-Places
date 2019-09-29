//
//  MainViewController.swift
//  New Places
//
//  Created by Max on 23.09.2019.
//  Copyright © 2019 Max. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    var places = Place.getPlaces()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return places.count
    }
    // Внешний вид ячейки
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for:
            indexPath) as! MainVCCell
        
        let place = places[indexPath.row]
        
        cell.placeName.text = place.name
        cell.placeLocation.text = place.location
        cell.placeType.text = place.type
        
        if place.image == nil {
            cell.placeImage.image = UIImage(named: place.restaurantImage!)
        } else {
            cell.placeImage.image = place.image
        }
        
        cell.placeImage.layer.cornerRadius = cell.placeImage.frame.size.height / 2
        cell.placeImage.clipsToBounds = true
        
        return cell
    }
    
    
    // MARK: Table View Delegate
    
    // Удаление свайпом
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
            self.places.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return swipeActions
    }
    
    // Переход на редактирование места
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let place = places[indexPath.row]
            let newPlaceVC = segue.destination as! NewPlaceVC
            newPlaceVC.newPlace = place
        }
    }
    
    
    // Сохранение нового места
    @IBAction func unwindSegue(_ segue:UIStoryboardSegue) {
        
        guard let newPlaceVC = segue.source as? NewPlaceVC  else { return }
        
        newPlaceVC.saveNewPlace()
        places.append(newPlaceVC.newPlace!)
        tableView.reloadData()
    }
    
}

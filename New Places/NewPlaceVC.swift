    //
    //  NewPlaceVC.swift
    //  New Places
    //
    //  Created by Max on 25.09.2019.
    //  Copyright © 2019 Max. All rights reserved.
    //
    
    import UIKit
    
    class NewPlaceVC: UITableViewController {
        
        @IBOutlet weak var saveBtn: UIBarButtonItem!
        
        @IBOutlet weak var imageOfPlace: UIImageView!
        @IBOutlet weak var nameOfPlace: UITextField!
        @IBOutlet weak var locationOfPlace: UITextField!
        @IBOutlet weak var typeOfPlace: UITextField!
        
        var newPlace: Place?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            saveBtn.isEnabled = false
            
            nameOfPlace.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
            
            setupEditingScreen()
        }
        
        
        // MARK: Table View Delegate
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if indexPath.row == 0 {
                let actionSheet = UIAlertController(title: nil,
                                                    message: nil,
                                                    preferredStyle: .actionSheet)
                
                let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                    self.chooseImagePicker(sourse: .photoLibrary)
                }
                
                let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                    self.chooseImagePicker(sourse: .camera)
                }
                
                let cancel = UIAlertAction(title: "Cancel", style: .cancel)
                
                actionSheet.addAction(photo)
                actionSheet.addAction(camera)
                actionSheet.addAction(cancel)
                
                present(actionSheet, animated: true)
                
            } else {
                tableView.endEditing(true)
            }
        }
        
        func saveNewPlace() {
            
            newPlace = Place(name: nameOfPlace.text!, location: locationOfPlace.text, type: typeOfPlace.text, restaurantImage: nil, image: imageOfPlace.image)
        }
        
        // Редакстирование выбранного места
        private func setupEditingScreen() {
            if newPlace != nil {
                
                setupNavigationBar()
                
                guard let image = UIImage(named: newPlace!.restaurantImage!) else { return }
                imageOfPlace.image = image
                nameOfPlace.text = newPlace?.name
                locationOfPlace.text = newPlace?.location
                typeOfPlace.text = newPlace?.type
            }
        }
        
        private func setupNavigationBar() {
            navigationItem.leftBarButtonItem = nil
            title = newPlace?.name
            saveBtn.isEnabled = true
        }
        
        @IBAction func cancelAction(_ sender: Any) {
            dismiss(animated: true)
        }
        
        
    }
    // MARK: Работа с изображением
    extension NewPlaceVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        func chooseImagePicker(sourse: UIImagePickerController.SourceType) {
            
            if UIImagePickerController.isSourceTypeAvailable(sourse) {
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = true
                imagePicker.delegate = self
                imagePicker.sourceType = sourse
                
                present(imagePicker, animated: true)
            }
        }
        
        // Присвоить выбранное изображение во View
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            imageOfPlace.image = info[.editedImage] as? UIImage
            imageOfPlace.contentMode = .scaleAspectFill
            imageOfPlace.clipsToBounds = true
            
            dismiss(animated: true)
        }
        
    }
    
    // MARK: Работа с Text Field
    extension NewPlaceVC: UITextFieldDelegate {
        
        // Скрытие клавиатуры по нажатию кнопки Done
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            
            return true
        }
        
        //   Кнопка save не активна при пустом поле
        @objc private func textFieldChanged() {
            if nameOfPlace.text?.isEmpty == false {
                saveBtn.isEnabled = true
            } else {
                saveBtn.isEnabled = false
            }
        }
    }
    
    
    
    
    

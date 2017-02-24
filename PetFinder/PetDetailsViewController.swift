//
//  PetDetailsViewController.swift
//  PetFinder
//
//  Created by Luke Parham on 9/1/15.
//  Copyright © 2015 Luke Parham. All rights reserved.
//

import UIKit

class PetDetailsViewController: UIViewController {
    
    @IBOutlet weak var nameAgeLabel: UILabel!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    
    var petId: Int?
    var currentPet: Pet?
    
    override func viewDidLoad() {
        profilePictureImageView.layer.cornerRadius = 4.0
        profilePictureImageView.layer.borderColor = UIColor.white.cgColor
        profilePictureImageView.layer.borderWidth = 2.0
        
        let editButton = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(PetDetailsViewController.editWasTapped(_:)))
        navigationItem.rightBarButtonItem = editButton
    }
    
    func editWasTapped(_ sender: AnyObject) {
        let vc = PetEditViewController()
        
        vc.petId = petId
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let petId = petId, let pet = MatchedPetsManager.sharedManager.petForId(petId) else {
            return
        }
        
        currentPet = pet
        setPet()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    func setPet() {
        guard let currentPet = currentPet else {
            return
        }
        
        title = currentPet.name
        nameAgeLabel.text = "\(currentPet.name), \(currentPet.age)"
        profilePictureImageView.image = UIImage(data: currentPet.imageData as Data)
    }
    
    
    override func encodeRestorableState(with coder: NSCoder) {
        if let petId = petId {
            coder.encode(petId, forKey: "petId")
        }
        
        
        super.encodeRestorableState(with: coder)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        petId = coder.decodeInteger(forKey: "petId")
        super.decodeRestorableState(with: coder)
    }
    
    override func applicationFinishedRestoringState() {
        
        guard let petId = petId else {
            return
        }
        
        currentPet = MatchedPetsManager.sharedManager.petForId(petId)
    }
    
}









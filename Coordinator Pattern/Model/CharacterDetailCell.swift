//
//  CharacterDetailCell.swift
//  Coordinator Pattern
//
//  Created by Mariak Achuoth on 2019-08-16.
//  Copyright © 2019 The Future I Dream. All rights reserved.
//

import UIKit

class CharacterDetailCell: UITableViewCell {
    
    @IBOutlet weak var characterImage: UIImageView!
    
    @IBOutlet weak var characterName: UILabel!
    
    @IBOutlet weak var Status: UILabel!
    
    @IBOutlet weak var gender: UILabel!
    
    @IBOutlet weak var createdYear: UILabel!
    @IBOutlet weak var origin: UILabel!
    
    func setUpCharacterDetails(char: Character){
        characterName.text = char.name
        Status.text = char.status
        gender.text = char.gender
        origin.text = char.origin.name
        createdYear.text = char.created
    }
    
}

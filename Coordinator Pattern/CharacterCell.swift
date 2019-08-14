//
//  CharacterCell.swift
//  Coordinator Pattern
//
//  Created by Mariak Achuoth on 2019-08-14.
//  Copyright © 2019 The Future I Dream. All rights reserved.
//

import UIKit

class CharacterCell: UITableViewCell {

    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterStatus: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    
    func setUpCharacter(character:Character){
        characterName.text =  character.name
        characterStatus.text = character.status
    }
}

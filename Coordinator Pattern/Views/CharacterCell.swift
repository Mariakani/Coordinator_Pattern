//
//  CharacterCell.swift
//  Coordinator Pattern
//
//  Created by Mariak Achuoth on 2019-08-14.
//  Copyright © 2019 The Future I Dream. All rights reserved.
//

import UIKit

protocol CharacterCellDelegate {
    func cellDidLoadImage(_ indexPath: IndexPath)
}

class CharacterCell: UITableViewCell {

    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterStatus: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
   
    @IBOutlet weak var activityIndictor: UIActivityIndicatorView!
    
    var delegate: CharacterCellDelegate?
    
    func setUpCharacter(character:Character, indexpath: IndexPath){
        self.activityIndictor.startAnimating()
        characterName.text =  character.name
        characterStatus.text = character.status
        
        ImageDownloadManager.shared.downloadImage(character, indexPath: indexpath) {[weak self] (image, url, indexpath, err) in
                DispatchQueue.main.async{
                    self?.activityIndictor.stopAnimating()
                    self?.characterImage.image = image
                    self?.delegate?.cellDidLoadImage(indexpath!)
            }
        }
    }
}

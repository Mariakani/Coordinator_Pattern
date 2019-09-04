//
//  CharacterDetailsViewController.swift
//  Coordinator Pattern
//
//  Created by Mariak Achuoth on 2019-08-12.
//  Copyright © 2019 The Future I Dream. All rights reserved.
//

import UIKit

class CharacterDetailsViewController: UIViewController, Storyboarded{
     weak var coordinator: MasterCoordinator?
    
    
    @IBOutlet weak var characterImage: UIImageView!
    
    @IBOutlet weak var characterName: UILabel!
    
    @IBOutlet weak var Status: UILabel!
    
    @IBOutlet weak var gender: UILabel!
    
    @IBOutlet weak var createdYear: UILabel!
    @IBOutlet weak var origin: UILabel!
    
    var character: Character?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let char = character{
            setUpCharacterDetails(char: char)
        }
        
    }
func setUpCharacterDetails(char: Character){
    characterName.text = char.name
    Status.text = char.status
    gender.text = char.gender
    origin.text = char.origin.name
    createdYear.text = char.created

    ImageDownloadManager.shared.downloadImage(char, indexPath: nil) {[weak self](image, url, indexpath, err) in
        if indexpath == nil{
            DispatchQueue.main.async{
                self?.characterImage.image = image
            }
        }
       
    }
    
}
}

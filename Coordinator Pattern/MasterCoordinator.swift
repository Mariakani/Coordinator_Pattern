//
//  MasterCoordinator.swift
//  Coordinator Pattern
//
//  Created by Mariak Achuoth on 2019-08-12.
//  Copyright © 2019 The Future I Dream. All rights reserved.
//

import UIKit

class MasterCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()//yet to be implemented once requires
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func onStart() {
        let Vc = HomeViewController.instantiate()
        Vc.coordinator = self
        navigationController.pushViewController(Vc, animated: false)
    }
    
    func DisplayedCharactersOnTapped(selectedUrl: String, episdeTitle: String){
        let charVC = CharactersViewController.instantiate()
        charVC.charUrl = selectedUrl
        charVC.episodeTitle = episdeTitle
        charVC.coordinator = self
        navigationController.pushViewController(charVC, animated: true)
    }

    func displayCharDetailsOnTapped(char: Character, characterName: String){
        let charDetailVC = CharacterDetailsViewController.instantiate()
        charDetailVC.coordinator = self
        navigationController.pushViewController(charDetailVC, animated: true)
    }
}

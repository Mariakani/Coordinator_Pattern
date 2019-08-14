//
//  Coordinator.swift
//  Coordinator Pattern
//
//  Created by Mariak Achuoth on 2019-08-12.
//  Copyright © 2019 The Future I Dream. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    
    var navigationController: UINavigationController {get set}
    func onStart()
}

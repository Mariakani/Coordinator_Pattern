//
//  StoryBoarded.swift
//  Coordinator Pattern
//
//  Created by Mariak Achuoth on 2019-08-12.
//  Copyright © 2019 The Future I Dream. All rights reserved.
//

import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController{
    static func instantiate() -> Self{
        let  fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
        
    }
}

//
//  R_MortyCharacters.swift
//  Coordinator Pattern
//
//  Created by Mariak Achuoth on 2019-08-13.
//  Copyright © 2019 The Future I Dream. All rights reserved.
//

import UIKit
struct Character: Decodable{
    var id: Int
    var name: String
    var status: String
    var image: String
    var gender: String
    var species: String
}

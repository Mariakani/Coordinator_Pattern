//
//  R_MortyEpisodes.swift
//  Coordinator Pattern
//
//  Created by Mariak Achuoth on 2019-08-13.
//  Copyright © 2019 The Future I Dream. All rights reserved.
//

import UIKit

struct Episodes: Decodable
{
    var Info: Info?
    var results: [Result]
}

struct Result: Decodable
{
    var id: Int
    var name: String
    var air_date: String
    var characters: [String]
}

struct Info:Decodable
{
    var count: Int
    var pages: Int
    var next: String
}


//
//  EpisodesCell.swift
//  Coordinator Pattern
//
//  Created by Mariak Achuoth on 2019-08-14.
//  Copyright © 2019 The Future I Dream. All rights reserved.
//

import UIKit

class EpisodesCell: UITableViewCell {

    @IBOutlet weak var episodeTitleLable: UILabel!
    
    @IBOutlet weak var episodeAirDateLable: UILabel!
    
    func setEpisode(episode: Result){
        episodeTitleLable.text = episode.name
        episodeAirDateLable.text = episode.air_date
    }
}

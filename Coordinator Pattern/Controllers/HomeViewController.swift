//
//  ViewController.swift
//  Coordinator Pattern
//
//  Created by M ariak Achuoth on 2019-08-12.
//  Copyright © 2019 The Future I Dream. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, Storyboarded{
    weak var coordinator: MasterCoordinator?
    
    var episodeResults : [Result]?
    var charactersArray:  [String] = []

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavbar()
        Parse()
    }
    
    
    func setUpNavbar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Rick & Morty Shows"
    }
    func Parse()
    {
        ApiNetworkService.shared.FetchR_MortyEpisodes { (episodes, err) in
            self.episodeResults = episodes?.results
            DispatchQueue.main.async {
               self.tableView.reloadData()
            }
        }
    
    }
    
    func createLastIndexArray(array: [String]) ->[String]{
        var tmpArray: [String] = []
        for item in array{
            let array = item.components(separatedBy: "/")
            tmpArray.append(array.last!)
        }
        return tmpArray
        }
    
}



extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodeResults?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EpisodesCell
        cell.backgroundColor = .darkGray
        if let results = episodeResults?[indexPath.item]{
            cell.setEpisode(episode: results)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedEpisode = episodeResults?[indexPath.item]{
           let indexcreated =  createLastIndexArray(array: selectedEpisode.characters)
            let url = "https://rickandmortyapi.com/api/character/\(indexcreated.joined(separator: ","))"
            coordinator?.DisplayedCharactersOnTapped(selectedUrl: url, episdeTitle: selectedEpisode.name)
        }

    }

}

//
//  CharactersViewController.swift
//  Coordinator Pattern
//
//  Created by Mariak Achuoth on 2019-08-12.
//  Copyright © 2019 The Future I Dream. All rights reserved.
//

import UIKit

class CharactersViewController: UIViewController, Storyboarded{
    
    weak var coordinator: MasterCoordinator?
    var characters : [Character]?
    var charUrl: String?
    var episodeTitle: String?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = episodeTitle
        parse()
    }
    
    
    func parse(){
        
        guard let urlString = charUrl else{return}
        guard let url = URL(string: urlString)else{
            print("bad url format")
            return
        }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let error = err{
                print(error)
            }
            guard let data = data else{return}
            
            do{
                let characters = try? JSONDecoder().decode([Character].self, from: data)
                if let char = characters{
        
                    self.characters = char
                    self.characters?.sort{ $0.created < $1.created
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }catch
            {
            }
            }.resume()
    }
}
extension CharactersViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "character", for: indexPath) as! CharacterCell
        cell.backgroundColor = .darkGray
        
        if let char = characters?[indexPath.item]{
            cell.setUpCharacter(character: char, indexpath: indexPath)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if  let selectedCharacter = characters?[indexPath.item]{
            ImageDownloadManager.shared.slowDownImageDownloadTaskPriority(character: selectedCharacter)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedChar = characters?[indexPath.item]{
            coordinator?.displayCharDetailsOnTapped(char: selectedChar, characterName: selectedChar.name)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}




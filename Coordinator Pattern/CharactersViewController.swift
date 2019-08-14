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
    //var image: UIImage?
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
                }
    
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }catch
            {
            }
            }.resume()


    }
    
//    func loadImage(image: UIImage, url: URL) ->UIImage{
//        
//        DispatchQueue.global().async {[weak self] in
//            if let data = try? Data(contentsOf: url){
//                if let imge = UIImage(data: data){
//                    image = imge
//    
//                }
//            }
//        }
//        
//        return image
//    }
}
extension CharactersViewController: UITableViewDelegate, UITableViewDataSource{

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return characters?.count ?? 0
    }
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "character", for: indexPath) as! CharacterCell
        cell.backgroundColor = .darkGray
    cell.characterImage.backgroundColor = .purple
    if let char = characters?[indexPath.item]{
        cell.setUpCharacter(character: char)
    }
    return cell
    
    }
}


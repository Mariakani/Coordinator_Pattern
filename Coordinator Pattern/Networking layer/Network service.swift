//
//  Network service.swift
//  Coordinator Pattern
//
//  Created by Mariak Achuoth on 2019-08-13.
//  Copyright © 2019 The Future I Dream. All rights reserved.
//

import UIKit

class ApiNetworkService{
    
    private init(){
        
    }
    static let shared = ApiNetworkService()
    
    func FetchR_MortyEpisodes(completion: @escaping (Episodes?, Error?)->()){
         let UrlString = "https://rickandmortyapi.com/api/episode"
        
        genericApijSonFetch(urlString: UrlString, completion: completion)
    }
    
    func genericApijSonFetch<T:Decodable>(urlString: String, completion: @escaping (T?, Error?) ->()){
        guard let url = URL(string: urlString)else{
             print("bad url format")
            return
        }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let error = err{
                completion(nil, error)
            }
            guard let data = data else{return}
            do{
                let episodes = try? JSONDecoder().decode(T.self, from: data)
                completion(episodes, nil)
            }catch
            {
                completion(nil, error)
            }
            }.resume()
    }
}

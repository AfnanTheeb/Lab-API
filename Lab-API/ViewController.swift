//
//  ViewController.swift
//  Lab-API
//
//  Created by Afnan Theb on 09/04/1443 AH.
//

import UIKit

class Characters : Codable {
    var characters : [Character]
}
struct Character : Codable {
    var name : String
    var role : String
   
}
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getCharacters()
    }
    func getCharacters(){
        // https://api.jikan.moe/v3/anime/1/characters_staff
        
        var urlAnimeCharacters = URLComponents()
        urlAnimeCharacters.scheme = "https"
        urlAnimeCharacters.host = "api.jikan.moe"
        urlAnimeCharacters.path = "/v3/anime/1/characters_staff"
        
        
        let animeCharactersQuery = URLQueryItem(name: "q", value: "")
        let animeCharactersQuery2 = URLQueryItem(name: "order_by", value: "members")
        let animeCharactersQuery3 = URLQueryItem(name: "sort", value: "desc")
        let animeCharactersQuery4 = URLQueryItem(name: "page", value: "1")

        urlAnimeCharacters.queryItems = [animeCharactersQuery, animeCharactersQuery2, animeCharactersQuery3, animeCharactersQuery4]
        
        
      
        let urlSession = URLSession.shared
        
        
        let animeCharactersRequest = URLRequest(url: urlAnimeCharacters.url! )

        
        let fetchDataTask = urlSession.dataTask(with: animeCharactersRequest) {
            (data: Data?, response: URLResponse?, err: Error?) in
            if (err == nil ){
                do {
                    let jsonDecoder = JSONDecoder()
                    let charactersResponse = try jsonDecoder.decode(Characters.self, from: data!)
                    print(charactersResponse.characters)
                } catch {
                    print("err: \(err)")
                }
                // Print data in string format
//                print (String(data: data!, encoding: .utf8))
            }
        }
        
        fetchDataTask.resume()
    }

}


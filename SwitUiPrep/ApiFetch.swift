//
//  ApiFetch.swift
//  SwitUiPrep
//
//  Created by Ronnie Otieno on 21/08/2021.
//

import Foundation


struct ImageResponse: Identifiable, Decodable{
    var id: String
    var color: String
    var likes: Int
    var description: String?
    var urls: PictureUrl
    var user: User
}

struct PictureUrl:Decodable {
    var regular: String
    var full: String
}

struct User:Decodable{
    var name:String
}

class ApiFetch :ObservableObject{
    @Published var images = [ImageResponse]()
    
    init() {
      fetchResultsFromApi()
    }
    let url:String = "https://api.unsplash.com/photos/?client_id=NkKPE2h5OQzSHJd0_SiXCfgddN4YgKbC6dVWfPk7Elg&per_page=100&page=\(Int.random(in: 1..<100))"
    func fetchResultsFromApi() {
        guard let unSplashUrl = URL(string: url) else { return }
        URLSession.shared.dataTask(with: unSplashUrl) { (data, response
                                                         , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let newImages = try decoder.decode([ImageResponse].self, from: data)
                print(newImages[0])
                DispatchQueue.main.async {
                self.images = newImages
                }
                
            } catch let err {
                print("Err", err)
            }
        }.resume()
    }
    
}


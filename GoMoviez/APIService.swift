//
//  APIService.swift
//  GoMoviez
//
//  Created by Amin Fotovat on 7/13/17.
//  Copyright © 2017 Aminous. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


let MovieAPI = _MovieAPI()

class _MovieAPI {
    func getMovieList(completionHandler: @escaping ([Movie]?) -> ()) {
        var movieList = [Movie]()
        
        Alamofire.request("http://api.tvmaze.com/shows?page=1").responseJSON(completionHandler: { response in
            if response.result.value != nil {
                let json = JSON(response.result.value!)
                let movieCount = json.arrayObject?.count
                var index = 0
                
                while index < movieCount! {
                    let movie = Movie()
                    movie.id = json[index]["id"].int
                    movie.name = json[index]["name"].string
                    movie.length = json[index]["runtime"].int
                    movie.descriptionHTML = json[index]["summary"].string
                    movie.rating = String(format: "%.1f", json[index]["rating"]["average"].double ?? 0.0)
                    movie.imageURL = json[index]["image"]["medium"].string
                    movie.type = json[index]["type"].string
                    for genre in json[index]["genres"].arrayObject! {
                        movie.genres?.append(String(describing: genre))
                    }
                    
                    movieList.append(movie)
                    index += 1
                }
                completionHandler(movieList) //successful request
            } else {
                completionHandler(nil) //failed to retrieve data
            }
            
        })
    }
    
    func getMoreMovieDetail(movie: Movie, completionHandler: @escaping (Movie?) -> ()) {
        Alamofire.request("http://api.tvmaze.com/shows/" + String(describing: movie.id!) + "?embed[]=crew&embed[]=cast").responseJSON(completionHandler: {response in
            if response.result.value != nil {
                let json = JSON(response.result.value!)
                //let movie = Movie()
                movie.country = json["network"]["country"]["code"].string
                let year = json["premiered"].string
                movie.year = year?.substring(to: (year?.index((year?.startIndex)!, offsetBy: 4))!)
                
                let crew = json["_embedded"]["crew"].arrayObject as? [[String : Any?]]
                for person in crew! {
                    //let personDict = person as? [String : Any?]
                    if String(describing: (person["type"]!)!) == "Creator" {
                        let personDetails = person["person"] as? [String: Any?]
                        let personName = String(describing: (personDetails?["name"]!)!)
                        movie.producer = personName
                        break
                    }
                }
                
                let cast = json["_embedded"]["cast"].arrayObject as? [[String : Any?]]
                
                for person in cast! {
                    let personDetails = person["person"] as? [String : Any?]
                    let personName = String(describing: (personDetails?["name"]!)!)
                    movie.stars?.append(personName)
                }
                
                completionHandler(movie)
            } else {
                completionHandler(nil)
            }
        })
    }
    
    func downloadImage(url: String, imageView: UIImageView)  {
        Alamofire.request(url).response { response in
            if response.data != nil {
                DispatchQueue.main.async {
                    imageView.image = UIImage(data: response.data!)
                }
            }
        }
    }
    
    func downloadImage2(url: String, imageView: UIImageView)  {
        Alamofire.request(url).response { response in
            if response.data != nil {
                DispatchQueue.main.async {
                    imageView.image = UIImage(data: response.data!)
                }
            }
        }
    }
}

//
//  Models.swift
//  GoMoviez
//
//  Created by Amin Fotovat on 7/13/17.
//  Copyright © 2017 Aminous. All rights reserved.
//

import Foundation
import UIKit

public class Movie {
    public var id: Int?
    var imageURL: String?
    var rating: String?
    var descriptionStr: NSAttributedString?
    var descriptionHTML: String? {
        didSet{
            descriptionStr = stringFromHtml(string: descriptionHTML!)
        }
    }
    var genres: [String]?
    var length: Int?
    var name: String?
    var type: String?
    var country: String?
    var producer: String?
    var year: String?
    var stars: [String]?
    
    init(id: Int, name: String, imageURL: String, rating: String?, descriptionHTML: String?, genres: [String]?, length: Int?, type: String?) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
        self.rating = rating
        self.descriptionHTML = descriptionHTML
        self.genres = genres
        self.length = length
        self.type = type
    }
    
    init() {
        self.genres = [String]()
        self.stars  = [String]()
    }
    
    private func stringFromHtml(string: String) -> NSAttributedString? {
        do {
            let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
            if let d = data {
                let str = try NSAttributedString(data: d,
                                                 options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                                                 documentAttributes: nil)
                
                return str
            }
        } catch {
        }
        return nil
    }
    
}

//
//  MoviezCollectionViewCell.swift
//  GoMoviez
//
//  Created by Amin Fotovat on 7/10/17.
//  Copyright © 2017 Aminous. All rights reserved.
//

import UIKit

class MoviezCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var movieScoreView: UIView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieScore: UILabel!
    @IBOutlet weak var movieDescription: UITextView!
    @IBOutlet weak var movieInfoParent: UIView!
    @IBOutlet weak var runtimeCircle: UIView!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var commmentsCount: UILabel!
    @IBOutlet weak var likesCount: UILabel!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieGenres: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        movieScoreView.backgroundColor = UIColor(red: 1, green: 221/255, blue: 1/255, alpha: 1.0)
        movieScoreView.layer.cornerRadius = movieScoreView.frame.size.width / 2
        movieScoreView.layer.shadowColor = UIColor(red: 1, green: 237/255, blue: 9/255, alpha: 1.0).cgColor
        movieScoreView.layer.shadowOpacity = 0.7
        movieScoreView.layer.shadowRadius = 7.0
        movieScoreView.layer.shadowOffset = .zero
        movieScoreView.layer.shadowPath = UIBezierPath(rect: movieScoreView.bounds).cgPath //Setting the shadow path will prevent the OS from dynamically calculate the shadow so improve the performance
        
        
        movieImage.backgroundColor = UIColor.red
        movieImage.layer.shadowColor = UIColor.black.cgColor
        movieImage.layer.shadowOpacity = 1.0
        movieImage.layer.shadowRadius = 2.0
        movieImage.layer.shadowOffset = .zero
        movieImage.layer.cornerRadius = 3
        movieImage.layer.shadowPath = UIBezierPath(rect: movieImage.bounds).cgPath
        
        movieInfoParent.layer.shadowColor = UIColor.gray.cgColor
        movieInfoParent.layer.shadowOpacity = 1.0
        movieInfoParent.layer.shadowRadius = 2.0
        movieInfoParent.layer.shadowOffset = .zero
        movieInfoParent.layer.cornerRadius = 3
        movieInfoParent.layer.shadowPath = UIBezierPath(rect: movieInfoParent.bounds).cgPath
        
        movieScore.layer.shadowColor = UIColor.black.cgColor
        movieScore.layer.shadowOffset = .zero
        movieScore.layer.shadowRadius = 1
        movieScore.layer.shadowPath = UIBezierPath(rect: movieScore.bounds).cgPath
        
        runtimeCircle.layer.cornerRadius = runtimeCircle.frame.size.width / 2
        
        movieDescription.contentInset = UIEdgeInsets(top: -10, left: -5, bottom: 0, right: 3)
        
        
    }
    
    

}

//
//  moviePageVC.swift
//  GoMoviez
//
//  Created by Amin Fotovat on 7/11/17.
//  Copyright © 2017 Aminous. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class moviePageVC: UIViewController, IndicatorInfoProvider, NVActivityIndicatorViewable {
    
    //MARK: Outlets
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var imdbLogo: UILabel!
    @IBOutlet weak var moviePreviewImage: UIImageView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieRate: UILabel!
    @IBOutlet weak var movieDate: UILabel!
    @IBOutlet weak var movieLength: UILabel!
    @IBOutlet weak var movieOrigin: UILabel!
    @IBOutlet weak var movieDirector: UILabel!
    @IBOutlet weak var movieStars: UILabel!
    @IBOutlet weak var movieDescription: UITextView!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let size = CGSize(width: 70, height: 70)
        startAnimating(size, message: "", messageFont: nil, type: .ballPulse , color: nil, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: 3, backgroundColor: nil, textColor: nil, isBlurred: true)
        
        MovieAPI.getMoreMovieDetail(movie: self.movie!, completionHandler: movieMoreDetails_Callback)
        
        self.navigationItem.title = "NOW PLAYING"
        let magnifierButton = UIBarButtonItem()
        magnifierButton.image = #imageLiteral(resourceName: "magnifier")
        self.navigationItem.rightBarButtonItem = magnifierButton
        
        playButton.backgroundColor = UIColor(red: 1, green: 221/255, blue: 1/255, alpha: 1.0)
        playButton.layer.cornerRadius = playButton.frame.size.width / 2
        playButton.layer.shadowColor = UIColor(red: 1, green: 237/255, blue: 9/255, alpha: 1.0).cgColor
        playButton.layer.shadowOpacity = 1
        playButton.layer.shadowRadius = 7.0
        playButton.layer.shadowOffset = .zero
        
        imdbLogo.layer.cornerRadius = 3
        imdbLogo.layer.shadowColor = UIColor(red: 1, green: 237/255, blue: 9/255, alpha: 1.0).cgColor
        imdbLogo.layer.shadowOpacity = 0.7
        imdbLogo.layer.shadowRadius = 7.0
        imdbLogo.layer.shadowOffset = .zero
        
        movieImage.layer.shadowColor = UIColor.black.cgColor
        movieImage.layer.shadowOpacity = 1.0
        movieImage.layer.shadowRadius = 2.0
        movieImage.layer.shadowOffset = .zero
        movieImage.layer.cornerRadius = 3
        movieImage.layer.shadowPath = UIBezierPath(rect: movieImage.bounds).cgPath
        
        let movieDescFont = UIFont.systemFont(ofSize: 11)
        let movieSummary = NSMutableAttributedString(string: "Story: ", attributes: [NSFontAttributeName: movieDescFont])
        movieSummary.append((movie?.descriptionStr)!)
        movieDescription.attributedText = movieSummary
        
        //Initiating the controls
        MovieAPI.downloadImage(url: (movie?.imageURL)!, imageView: movieImage)
        movieImage.autoresizingMask = [.flexibleTopMargin, .flexibleHeight, .flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin, .flexibleWidth]
        movieImage.contentMode = UIViewContentMode.scaleAspectFit
        
        movieTitle.text = movie?.name
        movieRate.text = movie?.rating
        if (movie?.genres?.count)! > 0{
            var index = 0
            var genresStr = ""
            let genres = movie?.genres!
            while index < (genres?.count)! && index < 3 {
                genresStr += (genres?[index])! + ","
                index += 1
            }
            genresStr.remove(at: genresStr.index(before: genresStr.endIndex))
            movieGenre.text = genresStr
        } else {
            movieGenre.text = movie?.type //Some series do not contain any genres, e.g. documentaries
        }
        movieLength.text = String(describing: (movie?.length)!) + " min"
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Movie")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    //MARK: AsyncCallbacks
    func movieMoreDetails_Callback(movie: Movie?) {
        if movie != nil {
            self.movie = movie
            DispatchQueue.main.async {
                self.movieOrigin.text = movie?.country
                self.movieDate.text = movie?.year
                
                if movie?.producer == nil {
                    self.movieDirector.text = "Unknown"
                } else {
                    self.movieDirector.text = movie?.producer
                }
                
                if (movie?.stars?.count)! > 0 {
                    var index = 0
                    var movieStarsStr = "Stars: "
                    while index < (movie?.stars?.count)! && index < 3 {
                        movieStarsStr += (movie?.stars?[index])! + ", "
                        index += 1
                    }
                    movieStarsStr.remove(at: movieStarsStr.index(before: movieStarsStr.endIndex))
                    movieStarsStr.remove(at: movieStarsStr.index(before: movieStarsStr.endIndex))
                    self.movieStars.text = movieStarsStr
                } else {
                    self.movieStars.text = "Stars: Unknown"
                }
            }
        }
        self.stopAnimating()
    }
}

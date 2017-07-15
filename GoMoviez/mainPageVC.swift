//
//  mainPageVC.swift
//  GoMoviez
//
//  Created by Amin Fotovat on 7/10/17.
//  Copyright © 2017 Aminous. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Siesta
import Alamofire
import SwiftyJSON

private let reuseIdentifier = "movieCell"

class mainPageVC: UICollectionViewController, IndicatorInfoProvider, NVActivityIndicatorViewable {

    var movies = [Movie]()
    var selectedMovieCell = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UINib(nibName: "MoviezCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: reuseIdentifier)
        
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        
        MovieAPI.getMovieList(completionHandler: getMoviesCallback)
        
        let size = CGSize(width: 70, height: 70)
        startAnimating(size, message: "", messageFont: nil, type: .ballPulse , color: nil, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: 3, backgroundColor: nil, textColor: nil, isBlurred: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
 

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return movies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MoviezCollectionViewCell else {
            fatalError("The movie cell is not in the correct format!")
        }
    
        // Configure the cell
        cell.movieName.text = movies[indexPath.row].name
        cell.movieScore.text = movies[indexPath.row].rating
        
        if (movies[indexPath.row].genres?.count)! > 0{
            var index = 0
            var genresStr = ""
            let genres = movies[indexPath.row].genres!
            while index < genres.count && index < 3 {
                genresStr += genres[index] + ","
                index += 1
            }
            genresStr.remove(at: genresStr.index(before: genresStr.endIndex))
            cell.movieGenres.text = genresStr
        } else {
            cell.movieGenres.text = movies[indexPath.row].type //Some series do not contain any genres, e.g. documentaries
        }
        
        cell.runtimeLabel.text = String(describing: movies[indexPath.row].length!) + " min"
        
        cell.movieDescription.attributedText = movies[indexPath.row].descriptionStr
        MovieAPI.downloadImage(url: movies[indexPath.row].imageURL!, imageView: cell.movieImage)
        
        let tapReognizer = UITapGestureRecognizer(target: self, action: #selector(movieCellTapped))
        cell.addGestureRecognizer(tapReognizer)
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    //MARK: StrinpMenu Methods
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Series")
    }
    
    //MARK: Async Callbacks
    func getMoviesCallback(movies: [Movie]?) {
        if movies != nil {
            self.movies = movies!
            self.collectionView?.reloadData()
            self.stopAnimating()
        }
        
    }
    
    //MARK: gestureRecognizer Methods
    func movieCellTapped(sender: UITapGestureRecognizer) {
       selectedMovieCell = (self.collectionView?.indexPath(for: (sender.view as? UICollectionViewCell)!)?.row)!
        let movieDetailsPage = moviePageVC(nibName: "moviePageVC", bundle: Bundle.main)
        movieDetailsPage.movie = movies[selectedMovieCell]
        self.navigationController?.pushViewController(movieDetailsPage, animated: true)
    }

}

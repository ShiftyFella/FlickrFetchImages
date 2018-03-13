//
//  ViewController.swift
//  FlickrFetchImages
//
//  Created by Viktor Bilyk on 2018-03-12.
//  Copyright © 2018 Brogrammers. All rights reserved.
//

import UIKit



class ViewController: UICollectionViewController, UITextFieldDelegate {

    let reuseIdentifier = "ImageCell"
    
    let searchAPI = SearchAPI()
    
    var searchResults = [SearchResutls]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        DispatchQueue.main.async {
            self.searchAPI.searchWithSearchParams(searchParam: "hello") {
            results, error in
            if let results = results {
                self.searchResults.insert(results, at: 0)
            }
        }
        }
        textField.text = nil
        textField.resignFirstResponder()
        return true
    }
    
    func photoForIndexPath(_ indexPath: IndexPath) -> Photo {
        return searchResults[(indexPath as NSIndexPath).section].searchResults[(indexPath as NSIndexPath).row]
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return searchResults.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return searchResults[section].searchResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
        
        let photo = photoForIndexPath(indexPath)
        cell.imageView.image = photo.photoImage
        
        
        return cell
    }

}


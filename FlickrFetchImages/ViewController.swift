//
//  ViewController.swift
//  FlickrFetchImages
//
//  Created by Viktor Bilyk on 2018-03-12.
//  Copyright © 2018 Brogrammers. All rights reserved.
//

import UIKit



class ViewController: UICollectionViewController, UITextFieldDelegate, UICollectionViewDelegateFlowLayout {
    
    let reuseIdentifier = "ImageCell"
    
    let searchAPI = SearchAPI()
    
    var searchResults = [SearchResutls]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationController?.navigationBar.prefersLargeTitles = true

        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.searchAPI.searchWithSearchParams(searchParam: textField.text!) {
            results, error in
            if let results = results {
                self.searchResults = [results]
                print("res: \(results)")
                
                self.collectionView?.reloadData()
            }
        }
        textField.text = nil
        textField.resignFirstResponder()
        return true
    }
    
    func photoForIndexPath(_ indexPath: IndexPath) -> Photo {
        return searchResults[indexPath.section].searchResults[indexPath.row]
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
        cell.imageView?.image = photo.photoImage
        cell.backgroundColor = UIColor.gray
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemSize = searchResults[indexPath.section].searchResults[indexPath.row].photoImage?.size
        let itemWidth = itemSize?.width
        let itemHeight = itemSize?.height
        let itemAspectRation = CGFloat(itemWidth! / itemHeight!)
        var cellWidth: CGFloat?
        var cellHeight: CGFloat?
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            cellWidth = ( (self.collectionView?.frame.width)! ) / 6 - 4
            cellHeight = cellWidth! / itemAspectRation
        case .phone:
            cellWidth = ( (self.collectionView?.frame.width)! ) / UIScreen.main.scale - 4
            cellHeight = cellWidth! / itemAspectRation
        default:
            print("Error")
        }
        return CGSize(width: cellWidth!, height: cellHeight!)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
        collectionView?.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            
            if let indexPath = self.collectionView?.indexPath(for: sender as! UICollectionViewCell) {
                
                let detailView = segue.destination  as! DetailView
                
                let photo = photoForIndexPath(indexPath)
                
                detailView.largeImage = photo.photoImage
                detailView.titleInfo = photo.title
                
                //self.navigationController?.pushViewController(detailView, animated: true)
            }
        }
    }
    
}


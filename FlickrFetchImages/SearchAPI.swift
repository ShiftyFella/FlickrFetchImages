//
//  SearchAPI.swift
//  FlickrFetchImages
//
//  Created by Viktor Bilyk on 2018-03-12.
//  Copyright © 2018 Brogrammers. All rights reserved.
//

import UIKit
import Foundation

let apiKey = "772f62d9f00b08bfd98de070cd54ba8e"

class SearchAPI {
    
    func searchURLWithSearchParams (searchParam: String) -> URL? {
        
        guard let escapedTerm = searchParam.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics) else {
            return nil
        }
        
        let URLString = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&text=\(escapedTerm)&per_page=20&format=json&nojsoncallback=1"
        
        guard let url = URL(string:URLString) else {
            return nil
        }
        
        return url
    }
    
    func searchWithSearchParams(searchParam: String, completion: @escaping (_ result: SearchResutls?, _ error: NSError?) ->Void) {
        let searchURL = searchURLWithSearchParams(searchParam: searchParam)
        
        let searchResult = URLRequest(url: searchURL!)
        
        URLSession.shared.dataTask(with: searchResult, completionHandler: {data,response,error in
            do {
                guard let results = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? [String: AnyObject]
                    else {
                        completion(nil, nil)
                        return
                }
                
                let photosFromAPI = results["photos"] as? [String: AnyObject]
                let photosReturned = photosFromAPI!["photo"] as? [[String: AnyObject]]
                
                var photos = [Photo]()
                
                for photoReturned in photosReturned! {
                    let photoID = photoReturned["id"] as? String
                    let farm = photoReturned["farm"] as? Int
                    let server = photoReturned["server"] as? String
                    let secret = photoReturned["secret"] as? String
                    
                    let photoObject = Photo(photoID: photoID!, farm: farm!, server: server!, secret: secret!)
                    
                  let photoURL = photoObject.imageURL()
                    let photoData = try? Data(contentsOf: photoURL as! URL)
                    
                    if let image = UIImage(data: photoData!) {
                        photoObject.photoImage = image
                        photos.append(photoObject)
                    }
                }
                DispatchQueue.global(qos: .background).async {
                    completion(SearchResutls(searchString: searchParam, searchResults: photos), nil)
                }
                
            } catch _ {
                completion(nil, nil)
                return
            }
        }) .resume()
    }
}

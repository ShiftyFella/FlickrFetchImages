//
//  Photo.swift
//  FlickrFetchImages
//
//  Created by Viktor Bilyk on 2018-03-12.
//  Copyright © 2018 Brogrammers. All rights reserved.
//

import UIKit

class Photo: Equatable {
    
    let photoID : String
    var photoImage: UIImage?
    let server: String
    let farm: Int
    let secret: String
    
    init(photoID: String, farm: Int, server: String, secret: String) {
        self.photoID = photoID
        self.farm = farm
        self.server = server
        self.secret = secret
    }
    
    func imageURL(_ size: String = "m") -> URL? {
        if let url = URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(photoID)_\(secret)_\(size).jpg") {
            return url
        }
        
        return nil
    }
    
    static func ==(lhs: Photo, rhs: Photo) -> Bool {
        return lhs.photoID == rhs.photoID
    }
}

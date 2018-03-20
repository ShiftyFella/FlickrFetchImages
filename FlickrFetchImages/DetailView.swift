//
//  DetailView.swift
//  FlickrFetchImages
//
//  Created by Viktor Bilyk on 2018-03-19.
//  Copyright © 2018 Brogrammers. All rights reserved.
//

import UIKit

class DetailView: UIViewController {

    @IBOutlet weak var largeImageView: UIImageView!
    
    var largeImage: UIImage?
    var titleInfo : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.largeImageView.image = self.largeImage
        self.title = self.titleInfo
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

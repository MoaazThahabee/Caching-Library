//
//  DetailsViewController.swift
//  Mindvalley Test
//
//  Created by Moaaz Al-Thahabee on 4/16/17.
//  Copyright © 2017 Moaaz Al-Thahabee. All rights reserved.
//

import UIKit

class DetailsViewController: BaseViewController {
    var picture: Picture!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = picture.owner.name
        imageView.setImageFromDownloader(with: picture.urls["full"]!)
        // Do any additional setup after loading the view.
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

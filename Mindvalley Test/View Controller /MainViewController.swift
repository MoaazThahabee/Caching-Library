//
//  MainViewController.swift
//  Mindvalley Test
//
//  Created by Moaaz Al-Thahabee on 4/16/17.
//  Copyright © 2017 Moaaz Al-Thahabee. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class MainViewController: BaseViewController {
    let refreshControl = UIRefreshControl()
    var cellSize: CGFloat!
    var pictures: [Picture] {
        get {
            return DataManager.sharedInstance.pictures
        }
    }
    @IBOutlet weak var imagesListCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        
        imagesListCollectionView.addSubview(refreshControl)
        
        imagesListCollectionView.emptyDataSetSource = self
        imagesListCollectionView.emptyDataSetDelegate = self

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() {
        self.refreshControl.beginRefreshing()
        if let supperView = self.refreshControl.superview {
            (supperView as! UIScrollView).setContentOffset(CGPoint(x: 0, y: -self.refreshControl.frame.size.height), animated: true)
        }
        
        CommunicationManager.sharedInstance.pictures() { (pictures, message) in
            self.refreshControl.endRefreshing()
            if let errorMessage = message {
                DataManager.sharedInstance.pictures = []
            }
            else {
                DataManager.sharedInstance.pictures = pictures!
                self.imagesListCollectionView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowImageDetailsSegue" {
            let destination = segue.destination as! DetailsViewController
            destination.picture = sender as! Picture
        }
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if cellSize == nil {
            self.cellSize = (self.imagesListCollectionView.frame.width / 2) - 15
        }
        
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImagesListCollectionViewCell
        
        let picture = pictures[indexPath.row]
        
        cell.imageView.setImageFromDownloader(with: picture.urls["thumb"]!)
        cell.backgroundColor = UIColor.white
        
        let layer = cell.layer
        
        //layer.cornerRadius = 5
        //layer.borderWidth = 1
        //cell.clipsToBounds = true
        
        layer.shadowPath = UIBezierPath(rect: cell.bounds).cgPath
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.4
        
        layer.borderColor = UIColor.gray.cgColor
        
        cell.layer.masksToBounds = false
        cell.tag = (indexPath as NSIndexPath).row
        
        
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = self.pictures[indexPath.row]
        self.performSegue(withIdentifier: "ShowImageDetailsSegue", sender: product)
    }
}

extension MainViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: NSLocalizedString("NoImagesToDisplay", comment: ""), attributes: [NSFontAttributeName: ThemeManager.sharedInstance.font])
    }
}

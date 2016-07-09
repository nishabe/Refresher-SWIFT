//
//  GCDViewController.swift
//  Refresher-SWIFT
//
//  Created by Aneesh Abraham01 on 7/9/16.
//  Copyright © 2016 Ammini. All rights reserved.
//
/*
 Reference: http://www.appcoda.com/ios-concurrency/
 
 */
// TODO: Support for autolayout / size classes
import UIKit

let imageURLs = [
    "http://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg",
    "http://adriatic-lines.com/wp-content/uploads/2015/04/canal-of-Venice.jpg",
    "http://algoos.com/wp-content/uploads/2015/08/ireland-02.jpg",
    "http://bdo.se/wp-content/uploads/2014/01/Stockholm1.jpg"]

class Downloader {
    
    class func downloadImageWithURL(url:String) -> UIImage! {
        
        let data = NSData(contentsOfURL: NSURL(string: url)!)
        return UIImage(data: data!)
    }
}

class GCDViewController: UIViewController {


    @IBOutlet weak var sliderValueLabel: UILabel!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    
    var imageViews : [UIImageView] = [UIImageView]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.imageViews = [self.imageView1,self.imageView2,self.imageView3,self.imageView4]
    }
    
    @IBAction func didTapOnSerial(sender: AnyObject) {
        let serialQueue = dispatch_queue_create("com.mysite.imagesQueue", DISPATCH_QUEUE_SERIAL)
        for i in 0...imageURLs.count-1
        {
            dispatch_async(serialQueue) { () -> Void in
                let image = Downloader.downloadImageWithURL(imageURLs[i])
                dispatch_async(dispatch_get_main_queue(), {
                    self.imageViews[i].image = image
                })
            }
        }
    }
    @IBAction func didTapOnconcurrent(sender: AnyObject) {
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        for i in 0...imageURLs.count-1
        {
            dispatch_async(queue) { () -> Void in
                let image = Downloader.downloadImageWithURL(imageURLs[i])
                dispatch_async(dispatch_get_main_queue(), {
                    self.imageViews[i].image = image
                })
            }
        }
        
    }
    @IBAction func didClickOnStart(sender: AnyObject) {
        
        for i in 0...imageURLs.count-1{
            let image = Downloader.downloadImageWithURL(imageURLs[i])
            self.imageViews[i].image = image
        }
    }
    @IBAction func sliderValueChanged(sender: UISlider) {
        
        self.sliderValueLabel.text = "\(sender.value * 100.0)"
    }
}

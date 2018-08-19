//
//  SessionDataTaskViewController.swift
//  Refresher-SWIFT
//
//  Created by Abraham, Aneesh on 8/18/18.
//  Copyright © 2018 Ammini Inc. All rights reserved.
//

import UIKit

class SessionDataTaskViewController: UIViewController {
    
    @IBOutlet weak var resultTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        resultTextView.text = "Loading"
        // Do any additional setup after loading the view.
        getData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData() {
        let session = URLSession.shared
        let url = URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=crowded+house")
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            var responseString = ""
            guard let data = data, error == nil else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                let posts = json["results"] as? [[String: Any]] ?? []
                dump(posts)
                for (key,value) in json {
                    responseString = responseString + ("\(key) = \(value)")
                }
                DispatchQueue.main.async {
                    self.resultTextView.text = responseString
                }
            } catch let error as NSError {
                print(error)
            }
        }
        dataTask.resume()
    }
}

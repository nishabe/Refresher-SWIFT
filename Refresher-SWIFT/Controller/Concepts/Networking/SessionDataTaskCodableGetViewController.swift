//
//  CodableViewController.swift
//  Refresher-SWIFT
//
//  Created by Abraham, Aneesh on 8/18/18.
//  Copyright © 2018 Ammini Inc. All rights reserved.
//

import UIKit

class SessionDataTaskCodableGetViewController: UIViewController {
    
    @IBOutlet weak var resultTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getData()
    }
    func getData() {
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        let defaultSession = URLSession(configuration: config)
        
        let url = URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=crowded+house")
        let dataTask = defaultSession.dataTask(with: url!) { (data, response, error) in
            if let error = error {
                self.resultTextView.text = "Error:\(error.localizedDescription)"
            } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                do {
                    let jsonDecoder = JSONDecoder()
                    let results = try jsonDecoder.decode(TrackList.self, from: data)
                    dump(results)
                    DispatchQueue.main.async {
                        self.resultTextView.text = "Check Console output"
                    }
                } catch let decodeError as NSError {
                    print(decodeError.localizedDescription)
                }
            }
        }
        dataTask.resume()
    }
}

struct TrackList : Decodable {
    let results : [Track]
}

struct Track : Decodable {
    let trackName : String
    let artistName : String
    let previewUrl : String
    
}

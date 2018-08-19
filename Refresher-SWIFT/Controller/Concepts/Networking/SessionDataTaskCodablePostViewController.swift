//
//  SessionDataTaskCodablePosttViewController.swift
//  Refresher-SWIFT
//
//  Created by Abraham, Aneesh on 8/18/18.
//  Copyright © 2018 Ammini Inc. All rights reserved.
//

import UIKit

class SessionDataTaskCodablePostViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getData()
    }
    
    func getData() {
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        let defaultSession = URLSession(configuration: config)
        // Set up a local http server using https://github.com/typicode/json-server and allow http arbitrary loads in info.plist
        let url = URL(string: "http://localhost:3000/posts")
        var request = URLRequest(url: url!)
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        request.networkServiceType = .background
        request.allowsCellularAccess = true
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        
        let encoder = JSONEncoder()
        let post = Post(author: "meme", title: "tuttu")
        do {
            let data = try encoder.encode(post)
            request.httpBody = data
        } catch let encodeError as NSError {
            print("Encode Error:\(encodeError.localizedDescription)")
        }
        
        let dataTask = defaultSession.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 201 else {
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                let results = try jsonDecoder.decode(Post.self, from: data)
                dump(results)
            } catch let decodeError as NSError {
                print(decodeError.localizedDescription)
            }
        }
        dataTask.resume()
    }
}

struct Post : Codable {
    let author : String
    let title : String
}

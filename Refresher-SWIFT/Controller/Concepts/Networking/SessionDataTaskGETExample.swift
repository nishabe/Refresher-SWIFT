//
//  SessionDataTaskGETExample.swift
//  Refresher-SWIFT
//
//  Created by Abraham, Aneesh on 9/6/18.
//  Copyright © 2018 Ammini Inc. All rights reserved.
//

import UIKit

class SessionDataTaskGETExample: UIViewController {
    
    typealias successCompletionBlock = (_ responseData : Data?) -> Void
    typealias failureCompletionBlock = (_ response : URLResponse?, _ error: NSError) -> Void
    
    let remoteURL = URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=ed+shereen")
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        retrieveRemoteData()
    }
    
    // MARK: Private Methods
    
    func retrieveRemoteData() -> () {
        getRemoteServerData(url: remoteURL!, successCompletionHandler: { data in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                print(json)
            }
            catch let error as NSError {
                print("JSON Parsing was a failure:\(error)")
            }
        }, failureCompletionHandler: {response, error  in
            var statusCode : Int
            if let response = response as? HTTPURLResponse {
                statusCode = response.statusCode
                print("Request was a failure. Reason: \(error.localizedDescription), statusCode : \(statusCode)")
            }
            print("Request was a failure. Reason: \(error.localizedDescription)")
        })
    }
    
    func getRemoteServerData(url : URL,
                             successCompletionHandler : @escaping successCompletionBlock,
                             failureCompletionHandler : @escaping failureCompletionBlock) {
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data, error == nil else {
                failureCompletionHandler (response, error! as NSError)
                return
            }
            successCompletionHandler(data)
        }
        dataTask.resume()
    }
}

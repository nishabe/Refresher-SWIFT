//
//  SessionDataTaskWithURLRequest.swift
//  Refresher-SWIFT
//
//  Created by Abraham, Aneesh on 10/18/18.
//  Copyright © 2018 Ammini Inc. All rights reserved.
//

import UIKit

class SessionDataTaskWithURLRequest: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getDataFromRemote()
    }
    func getDataFromRemote () {
        // In order to avoid building or setting up a web server, we will use the free service httpbin.org, that allows us to send RESTful requests and receive results to check that we are sending the right data in the right way.
        let getURL = URL(string: "https://httpbin.org/get?bar=foo")!
        var getRequest = URLRequest(url: getURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30.0)
        getRequest.httpMethod = "GET"
        getRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        getRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: getRequest, completionHandler: { (data, response, error) -> Void in
            if error != nil { print("GET Request: Communication error: \(error!)") }
            if data != nil {
                do {
                    let resultObject = try JSONSerialization.jsonObject(with: data!, options: [])
                    DispatchQueue.main.async(execute: {
                        print("Results from GET https://httpbin.org/get?bar=foo :\n\(resultObject)") })
                } catch {
                    DispatchQueue.main.async(execute: {
                        print("Unable to parse JSON response")
                    })
                }
            } else {
                DispatchQueue.main.async(execute: {
                    print("Received empty response.")
                })
            }
        }).resume()
    }
}

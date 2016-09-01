//
//  UCS.swift
//  UCS
//
//  Created by Vallard Benincosa on 8/31/16.
//  Copyright © 2016 Cisco Systems. All rights reserved.
//

import Alamofire
import SWXMLHash
import Foundation

class UCS  {
    

    func connect(ucs: String, user: String, password: String) -> Bool {
        
        
        print("attempting to connect to UCS \(ucs)")
        
        let headers = [
            "Content-Type": "text/xml"
        ]
        
        
        Alamofire.request(.GET, "https://10.93.234.238/nuova", parameters: nil, encoding: .URL, headers: headers)
            .response { (request, response, data, error) in
                print(data)
                //let xml = SWXMLHash.parse(data!)
                
        }
        return true
        
    }
    
}

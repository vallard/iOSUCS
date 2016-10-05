//
//  UCS.swift
//  UCS
//
//  Created by Vallard Benincosa on 8/31/16.
//  Copyright © 2016 Cisco Systems. All rights reserved.
//

import Alamofire
//import SWXMLHash
import Foundation


/* vxmlEncoding is used to encode the user and password into the UCS manager.
   alamofire 4.0 introduces the custom parameter encoding structure.  We use this to pass the authentication
   parameters into the call to UCS.
 */
public struct vxmlEncoding: ParameterEncoding {
    
    public static var `default` : vxmlEncoding { return vxmlEncoding() }
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        
        var urlRequest = try urlRequest.asURLRequest()
        
        guard let parameters = parameters else { return urlRequest }
        
        let user = parameters["user"]
        let password = parameters["password"]
        
        if (user != nil) && (password != nil) {
        
            let loginCommand = "<aaaLogin inName=\(user!) inPassword=\(password!) />"
            
            urlRequest.httpBody = loginCommand.data(using: String.Encoding.utf8)
        }
        return urlRequest
    }
}


/* The UCS class is the library we use to run commands into UCS */

class UCS {
    
    var manager: SessionManager!

    /* initializes UCS session manager so that it's ready for business! */
    init() {
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "*" : .disableEvaluation
    
        ]
        manager = SessionManager(configuration: .ephemeral, serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))
        
        manager.delegate.sessionDidReceiveChallenge = {session, challenge in
            
            var disposition: URLSession.AuthChallengeDisposition = .performDefaultHandling
            var credential: URLCredential?
            
            /* if the HTTPS is self signed, then just trust it.  Most UCS are set up like this */
            if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
                disposition = .useCredential
                credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
                
            }
            return  (disposition, credential )
        }
        
        manager.delegate.sessionDidBecomeInvalidWithError = {_, error in
            print("session did become invalide with error: ")
            print(error)
            return
        }

    }
    
    
    /* connect will connect to UCS
     curl -k -H "Content-Type: text/xml" -d '<aaaLogin inName="admin" inPassword="password" />' -X POST https://10.93.234.238/nuova
    */
    func connect(_ ucs: String, user: String, password: String) -> Bool {
        
        print("attempting to connect to UCS \(ucs)")
    
        // Set the headers.
        let headers: HTTPHeaders = [
            "Content-Type": "text/xml"
            //"Content-Type" : "application/xml"
        ]

        
        if (user == "") || (password == "") { return false }
        
        let parameters: Parameters = [
            "user" : user,
            "password" : password
        ]
        
        let ucsurl = "https://" + ucs + "/nuova"
        

        let req = manager.request(ucsurl, method: .post, parameters: parameters, encoding: vxmlEncoding.default, headers: headers)
            .responseString{ response in
                debugPrint(response)
                print("response: ", response.response)
                print("request: ", response.request)
                print("result: ", response.result)
        }
        
        debugPrint(req)
        return true
        
    }
    
}

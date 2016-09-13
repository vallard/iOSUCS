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

class UCS  {
    
    
  let sessionManager = Alamofire.SessionManager(configuration: URLSessionConfiguration.default)
    
    /*
 manager.delegate.sessionDidReceiveChallenge = { session, challenge in
 var disposition: NSURLSessionAuthChallengeDisposition = .PerformDefaultHandling
 var credential: NSURLCredential?
 print("Did receive challenge")
 if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
 disposition = NSURLSessionAuthChallengeDisposition.UseCredential
 credential = NSURLCredential(forTrust: challenge.protectionSpace.serverTrust!)
 } else {
 if challenge.previousFailureCount > 0 {
 disposition = .CancelAuthenticationChallenge
 } else {
 credential = self.manager.session.configuration.URLCredentialStorage?.defaultCredentialForProtectionSpace(challenge.protectionSpace)
 
 if credential != nil {
 disposition = .UseCredential
 }
 }
 }
 
 return (disposition, credential)
 }
 
 */
        /*
        = Alamofire.Manager(
        serverTrustPolicyManager: ServerTrustPolicyManager(
            policies: [
               "*": .Disable
                /*"*": .PinCertificates(
                    certificates: ServerTrustPolicy.certificatesInBundle(),
                    validateCertificateChain: false,
                    validateHost: false
                ),*/
            ]
    ))*/
    
    
    
    func connect(_ ucs: String, user: String, password: String) -> Bool {
        
        
        
        let delegate: Alamofire.SessionDelegate = sessionManager.delegate
        delegate.sessionDidReceiveChallenge = {session, challenge in
            print("did receive challenge \(challenge)")
            return (URLSession.AuthChallengeDisposition.useCredential, nil)
            
        }
        
        print("attempting to connect to UCS \(ucs)")
        /*
        let headers = [
            "Content-Type": "text/xml"
        ]
        */
        
        
        let loginCommand = "<aaaLogin " +
                                "inName=\"\(user)\" " +
                                "inPassword=\"\(password)\" />"
        
        print("Login Command \(loginCommand)")
       /*
        let custom: (URLRequestConvertible, [String: AnyObject]?) -> (NSMutableURLRequest, NSError?) = {
            (convertible, parameters) in
                let mutableRequest = convertible.URLRequest.copy() as! NSMutableURLRequest
            let bodyData:NSData = loginCommand.dataUsingEncoding(NSUTF8StringEncoding)!
            mutableRequest.HTTPBody = bodyData
            return (mutableRequest, nil)
        }
        */
       
        
        /* curl command: 
            curl -k -H "Content-Type: text/xml" -d '<aaaLogin inName="admin" inPassword="Cisco.123" />' https://192.168.2.14/nuova 
         */
        
        /* another example:
            curl -k -H "Content-Type: text/xml" -d '<aaaLogin inName="admin" inPassword="oicu812!" />' -X POST https://10.93.234.238/nuova
         */
        
        
        let req = sessionManager.request("https://10.93.234.238/nuova", method: .get)
            .responseData { response in
                    debugPrint(response)
        
        }
        debugPrint(req)
        
    
        return true
        
    }
    
}

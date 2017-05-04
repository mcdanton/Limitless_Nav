//
//  REST.swift
//  InfiniteScrolling
//
//  Created by Dan Hefter on 5/4/17.
//  Copyright © 2017 DH. All rights reserved.
//

import Foundation


enum RESTType: String {
   
   case post = "POST"
   case get = "GET"
   case put = "PUT"
   case delete = "DELETE"
}

enum RESTPath: String {
   
   case login = "login"
   case auth = "auth"
   
}


func login(path: RESTPath.RawValue, _ username: String, _ email: String, _ password: String, closure: @escaping (Data) -> ()) {
   
   let myUrl = URL(string: "http://192.168.1.166:2222/api/\(path)")
   var request = URLRequest(url:myUrl!)
   request.httpMethod = "POST"
   let postString = "username=\(username)&password=\(password)"
   request.httpBody = postString.data(using: .utf8)
   
   let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data, error == nil else {                                                 // check for fundamental networking error
         print("error=\(String(describing: error))")
         return
      }
      
      if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
         print("statusCode should be 200, but is \(httpStatus.statusCode)")
         print("response = \(httpStatus)")
      }
      
      let responseString = String(data: data, encoding: .utf8)
      print("responseString = \(String(describing: responseString))")
      
      DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
         closure(data)
      }
   }
   task.resume()
}


func parseAccessToken(data : Data, closure : @escaping (String) ->()) {
   do {
      let parsedJSON = try JSONSerialization.jsonObject(with: data, options : JSONSerialization.ReadingOptions.mutableContainers) as! [String:Any]
      let accessToken = parsedJSON["access_token"] as! [String : Any]
      let token = accessToken["token"] as! String
      
      closure(token)
   }
   catch {
      print(error.localizedDescription)
   }
}



func authUser(path: RESTPath.RawValue, token: String, closure: @escaping (Data) -> ()) {
   let urlString = URL(string: "http://192.168.1.166:2222/api/\(path)")
   var urlRequest = URLRequest(url: urlString!)
   urlRequest.httpMethod = RESTType.post.rawValue
   
   urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
   urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
   
   let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
      guard let responseData = data else {
         print("Error \(error.debugDescription): did not receive data")
         return
      }
      DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
         closure(responseData)
      }
   }
   task.resume()
}



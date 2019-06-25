//
//  WorkerController.swift
//  Tipsease
//
//  Created by Alex Shillingford on 6/25/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class WorkerController {
    var bearer: Bearer?
    private let baseURL = URL(string: "") // WILL CHANGE WHEN API IS DEPLOYED
    
    func signUp(user: User, completion: @escaping (Error?) -> ()) {
        guard let signUpURL = baseURL?.appendingPathComponent("/users/signup") else { return } // WILL CHANGE WHEN API IS DEPLOYED
        
        var request = URLRequest(url: signUpURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(user)
            request.httpBody = jsonData
        } catch {
            print("Error encoding user data: \(error)")
            completion(error)
        }
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                return
            }
            
            if let error = error {
                completion(error)
                return
            }
            
            completion(nil)
        }.resume()
    }
    
    func signIn(user: User, completion: @escaping (Error?) -> ()) {
        guard let baseURL = baseURL else { return }
        let signInURL = baseURL.appendingPathComponent("/users/signin") // WILL CHANGE WHEN API IS DEPLOYED
        var request = URLRequest(url: signInURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type") // POSSIBLE CHANGE WHEN API IS DEPLOYED
        
        do {
            let jsonData = try JSONEncoder().encode(user)
            request.httpBody = jsonData
        } catch {
            print("Error encoding user data: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
            }
            
            if let error = error {
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(NSError())
                return
            }
            
            do {
                self.bearer = try JSONDecoder().decode(Bearer.self, from: data)
            } catch {
                print("Error decoding and fetching bearer token: \(error)")
                completion(error)
                return
            }
        }.resume()
    }
}

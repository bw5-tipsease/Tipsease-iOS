//
//  WorkerController.swift
//  Tipsease
//
//  Created by Marlon Raskin on 6/26/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum NetworkError: Error {
    case noAuth
    case badAuth
    case otherError
    case badData
    case noDecode
    case noEncode
}


class APIController {
	
	//MARK: - Properties
	var bearer: Bearer?
	let persistence = PersistentService()
	private let baseURL = URL(string: "https://tipsease-be.herokuapp.com/api")
	let currencyFormatter = NumberFormatter()
	let dateFormatter = DateFormatter()
    var servers: [Worker] = []
	
	init() {
		setBearer()
	}
    

	// MARK: - Register & Sign Encode & Decode functions
    func register(user: User, completion: @escaping (Error?) -> ()) {
        guard let baseURL = baseURL else { return }
        let registerURL = baseURL.appendingPathComponent("auth/register")

        var request = URLRequest(url: registerURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let jsonData = try JSONEncoder().encode(user)
            request.httpBody = jsonData
        } catch {
            print("Error encoding user data: \(error)")
            completion(error)
			return
        }

        URLSession.shared.dataTask(with: request) { _, response, error in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 201 {
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

    func login(user: User, completion: @escaping (Error?) -> ()) {
        guard let baseURL = baseURL else { return }
        let loginURL = baseURL.appendingPathComponent("auth/login") // WILL CHANGE WHEN API IS DEPLOYED
        var request = URLRequest(url: loginURL)
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
                response.statusCode != 201 {
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
			completion(nil)
		}.resume()
    }

	// MARK: - Fetch Data Function
    func fetchAllServers(completion: @escaping (Result<[Worker], NetworkError>) -> ()) {
        guard let bearer = bearer else {
            completion(.failure(.noAuth))
            return
        }
        guard let baseURL = baseURL else { return }
        let serversURL = baseURL.appendingPathComponent("servers") // WILL CHANGE WHEN API IS DEPLOYED
        var request = URLRequest(url: serversURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.addValue("\(bearer.token)", forHTTPHeaderField: "Authorization") // SUBJECT TO CHANGE

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                completion(.failure(.badAuth))
                return
            }

            if let error = error {
                print("Error returned in dataTask: \(error)")
                completion(.failure(.otherError))
                return
            }

            guard let data = data else {
                completion(.failure(.badData))
                return
            }

            do {
                self.servers = try JSONDecoder().decode([Worker].self, from: data)
                completion(.success(self.servers))
            } catch {
                completion(.failure(.noDecode))
            }
		}.resume()
    }
	
	// MARK: - Fetch Image URLs function
	func fetchImages(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
		let imageUrl = URL(string: urlString)!
		
		var request = URLRequest(url: imageUrl)
		request.httpMethod = HTTPMethod.get.rawValue
		
		URLSession.shared.dataTask(with: request) { data, _, error in
			if let _ = error {
				completion(.failure(.otherError))
			}
			
			guard let data = data else {
				completion(.failure(.badData))
				return
			}
			
			guard let image = UIImage(data: data) else {
				completion(.failure(.badData))
				return
			}
			completion(.success(image))
		}.resume()
	}
	
	
	// MARK: - Persistence Functions
	func saveBearer() {
		guard let bearerToken = bearer else { return }
		persistence.saveUserToken(token: bearerToken)
	}
	
	func setBearer() {
		bearer = persistence.checkForUserToken()
	}
}

//
//  WebService.swift
//  trace-my-ride
//
//  Created by Emilio Barreiro on 9/14/21.
//

import Foundation

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

struct LoginRequestBody: Codable {
    let email: String
    let password: String
}

struct RegisterRequestBody: Codable {
    let username: String
    let email: String
    let password: String
    let trackingId: String
}

struct LoginResponse: Codable {
    public let _id: String?
    public let __v: Int?
    public let username: String?
    public let email: String?
    public let password: String?
    public let trackingId: String?
    public let token: String?
}

struct RegisterResponse: Codable {
    public let _id: String?
    public let __v: Int?
    public let username: String?
    public let email: String?
    public let password: String?
    public let trackingId: String?
    public let token: String?
}
 

class WebService: ObservableObject {
    func login(email: String, password: String, completion: @escaping (Result<Data, AuthenticationError>) -> Void) {
        guard let url = URL(string: "http://192.168.254.68:3000/login") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        let body = LoginRequestBody(email: email, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "no data")))
                return
            }
            print("[LOGIN]: data received")
            
            guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            print("[LOGIN]: data decoded")
            print("[LOGIN] snippet: " + loginResponse.username!)
            completion(.success(data))
        }.resume()
    }
    
    func register(username: String, email: String, password: String, trackingId: String, completion: @escaping (Result<Data, AuthenticationError>) -> Void) {
        guard let url = URL(string: "http://192.168.254.68:3000/login") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        let body = RegisterRequestBody(username: username, email: email, password: password, trackingId: trackingId)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "no data")))
                return
            }
            print("[REGISTER]: data received")
            
            guard let registerResponse = try? JSONDecoder().decode(RegisterResponse.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            print("[REGISTER]: data decoded")
            print("[REGISTER] snippet: " + registerResponse.username!)
        }
        
    }
}

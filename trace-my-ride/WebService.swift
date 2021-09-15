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

struct LoginResponse: Codable {
    let _id: String?
    let username: String?
    let email: String?
    let password: String?
    let trackingId: String?
    let token: String?
}

class WebService: ObservableObject {
    
//    func login(email: String, password: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
//    func login(email: String, password: String, completion: @escaping (Result<LoginResponse, AuthenticationError>) -> Void) {
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
            
            guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            
//            guard let token = loginResponse.token else {
//                completion(.failure(.invalidCredentials))
//                return
//            }
            
//            completion(.success(token))
            print("here: " + loginResponse.password!)
            completion(.success(data))
        }.resume()
    }
}

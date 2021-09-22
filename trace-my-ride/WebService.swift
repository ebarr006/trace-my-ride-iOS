//
//  WebService.swift
//  trace-my-ride
//
//  Created by Emilio Barreiro on 9/14/21.
//

import Foundation

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
            
            if let httpResponse = response as? HTTPURLResponse {
                print("statusCode: \(httpResponse.statusCode)")
                
                if httpResponse.statusCode != 200 {
                    completion(.failure(.invalidCredentials))
                    return
                }
            }
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "no data")))
                return
            }

            completion(.success(data))

        }.resume()
    }
    
    func register(username: String, email: String, password: String, completion: @escaping (Result<Data, AuthenticationError>) -> Void) {
        guard let url = URL(string: "http://192.168.254.68:3000/register") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        let body = RegisterRequestBody(username: username, email: email, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse {
                
                if httpResponse.statusCode != 201 {
                    completion(.failure(.invalidCredentials))
                    return
                }
            }
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "no data")))
                return
            }
            
            guard let registerResponse = try? JSONDecoder().decode(UserObject.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            print("[REGISTER] snippet: " + registerResponse.username!)
            
            completion(.success(data))
            
        }.resume()
    }
    
    func createTrip(name: String, description: String, token: String, completion: @escaping (Result<Data, AuthenticationError>) -> Void) {
        guard let url = URL(string: "http://192.168.254.68:3000/api/trips") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        let body = CreateTripBody(name: name, description: description)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(token, forHTTPHeaderField: "x-access-token")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse {
                
                if httpResponse.statusCode != 201 {
                    completion(.failure(.custom(errorMessage: "incorrect status code returned")))
                    return
                }
            }
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "no data")))
                return
            }
            
            guard let createTripResponse = try? JSONDecoder().decode(TripObject.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            print("[CREATE TRIP] snippet: " + createTripResponse.description!)
            
            completion(.success(data))
            
        }.resume()
    }
    
}

// useful JSON debugging
//
//if let data = data {
//  do {
//    let decodedResponse = try JSONDecoder().decode(UserObject.self, from: data)
//    print(decodedResponse.username ?? "hi")
//  } catch DecodingError.keyNotFound(let key, let context) {
//    Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
//} catch DecodingError.valueNotFound(let type, let context) {
//    Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
//} catch DecodingError.typeMismatch(let type, let context) {
//    Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription). \(context)")
//} catch DecodingError.dataCorrupted(let context) {
//    Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
//} catch let error as NSError {
//    NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
//}
//  return
//}

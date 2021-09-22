//
//  Utils.swift
//  trace-my-ride
//
//  Created by Emilio Barreiro on 9/21/21.
//

import Foundation
import SwiftUI

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
}

struct CreateTripBody: Codable {
    let name: String
    let description: String
}

class TripObject: Codable, ObservableObject {
    public var id: String?
    public var name: String?
    public var description: String?
    public var pinCount: Int?
    public var mileage: Int?
    public var startDate: String?
    public var endDate: String?
    public var active: Bool?
    public var userId: String?
}

class UserObject: Codable, ObservableObject {
    public let id: String?
    public let username: String?
    public let email: String?
    public let password: String?
    public let trips: [TripObject]?
    public let token: String?
}

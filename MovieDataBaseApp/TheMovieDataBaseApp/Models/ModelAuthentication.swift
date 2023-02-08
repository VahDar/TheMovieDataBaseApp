//
//  ModelAuthentication.swift
//  TheMovieDataBaseApp
//
//  Created by Vakhtang on 08.01.2023.
//

import Foundation

//MARK: - Guest Session

struct GuestSessionId: Codable {
    let success: Bool
    let guestSessionID, expiresAt: String
    
    enum CodingKeys: String, CodingKey {
        case success
        case guestSessionID = "guest_session_id"
        case expiresAt = "expires_at"
    }
}

//MARK: - CreatTokenModel

struct Token: Codable {
    let success: Bool
    let expiresAt, requestToken: String

    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
}

//MARK: - ValidateTokenModel

struct ValidateToken: Codable {
    let username, password, requestToken: String

    enum CodingKeys: String, CodingKey {
        case username, password
        case requestToken = "request_token"
    }
}


//MARK: - ReaquestBodyCreateSession
//encode
struct ReaquestBodyCreateSession: Codable {
    let requestToken: String

    enum CodingKeys: String, CodingKey {
        case requestToken = "request_token"
    }
}

//MARK: - CreateSession
    //decode
struct CreateSession: Codable {
    let success: Bool
        let sessionID: String

        enum CodingKeys: String, CodingKey {
            case success
            case sessionID = "session_id"
        }
    }


// MARK: - SessionIDforDel

struct SessionIDForDel: Codable {
    let sessionID: String

    enum CodingKeys: String, CodingKey {
        case sessionID = "session_id"
    }
}
//MARK: - IsLogOut
struct LogOut: Codable {
    let success: Bool
}

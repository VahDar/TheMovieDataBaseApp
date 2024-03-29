//
//  AuthenticalNetworking.swift
//  TheMovieDataBaseApp
//
//  Created by Vakhtang on 09.01.2023.
//

import Foundation

class AuthenticalNetworking {
    
    static let shared = AuthenticalNetworking()
    private init() {}
    var sessionID: String = ""
    var userID = 0
    
    //MARK: - create new token
    
    
    private func getToken() async throws -> Token {
        
        var urlRequest = URLRequest(url: TheMDBAPIs.newToken)
        urlRequest.httpMethod = "get"
        
        do {
            return try await
            StatusResponce.shared.statusResponce(request: urlRequest, responce: Token.self)
            
        } catch {
            throw error
    }
}
    
    // MARK - validate user token
    
    private func validateUser(username: String, password: String, token: String) async throws  {
        
        var urlRequesst = URLRequest(url: TheMDBAPIs.validateUser)
        urlRequesst.httpMethod = "post"
        
        urlRequesst.httpBody = bodyValidateSession(username: username, password: password, token: token)
        urlRequesst.addValue("application/json", forHTTPHeaderField: "content-type")
        do {
            let responce = try await StatusResponce.shared.statusResponce(request: urlRequesst, responce: ReaquestBodyCreateSession.self)
            print(responce.requestToken)
        } catch let error {
            throw error
    }
}
    
    private func bodyValidateSession(username: String, password: String, token: String) -> Data?{
        let creatSession = ValidateToken(username: username, password: password, requestToken: token)
        do {
            return try JSONEncoder().encode(creatSession)
        } catch {
            debugPrint("Error \(error.localizedDescription)")
            return nil
    }
}
    
    // MARK: - Create session id
    private func createSession(token: String) async throws -> CreateSession {
        
        var urlRequest = URLRequest(url: TheMDBAPIs.createSession)
        urlRequest.httpMethod = "post"
        
        urlRequest.httpBody = bodyCreateSession(token: token)
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        
        do {
            let responce = try await
            StatusResponce.shared.statusResponce(request: urlRequest, responce: CreateSession.self)
            self.sessionID = responce.sessionID
            print("session id is \(responce.sessionID)")
            return responce
        } catch let error  {
            throw error
    }
}
    
    private func bodyCreateSession(token: String) -> Data?{
        let creatSession = ReaquestBodyCreateSession(requestToken: token)
        
        do {
            return try JSONEncoder().encode(creatSession)
        } catch {
            debugPrint("Error \(error.localizedDescription)")
            return nil
    }
}
    
    // MARK: - Create Guset Session
    
    func guestSession() async throws -> GuestSessionId {
        var urlRequest = URLRequest(url: TheMDBAPIs.guestSession)
        urlRequest.httpMethod = "get"
        
        do {
            return try await
            StatusResponce.shared.statusResponce(request: urlRequest, responce: GuestSessionId.self)
        } catch {
            throw error
    }
}
    
    // MARK: - Get User Info
    
    private func getDetails(_ sessionID: String) async throws  {
        guard let url = URL(string: GetDetails.account.rawValue) else {return}
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = [ URLQueryItem(name: "session_id", value: sessionID),
                                      URLQueryItem(name: "api_key", value: "67f032f64d08b9fef26884d7cef4153f")]
        guard let queryURL = urlComponents?.url else {return}
        print(queryURL)
        var urlRequest = URLRequest(url: queryURL)
        urlRequest.httpMethod = "get"
        
        do {
            let accdetail = try await
            StatusResponce.shared.statusResponce(request: urlRequest, responce: Account.self)
            self.userID = accdetail.id
            print("accound id is \(accdetail.id)")
        } catch {
            throw error
    }
}
    
    //MARK: - requestAllFunc
    
    func requestAllAuthNetwork(username: String, password: String) async throws -> Bool {
        do {
            let token = try await getToken()
            try await validateUser(username: username, password: password, token: token.requestToken)
            let sessionId = try await createSession(token: token.requestToken)
            _ = try await getDetails(sessionId.sessionID)
            return true
        } catch {
            print(error)
            return false
    }
}
    
    
    //MARK: - LogOut
    
    func logOut() async throws -> LogOut {
        
        var urlRequest = URLRequest(url: TheMDBAPIs.deleteSession)
        
        urlRequest.httpMethod = "delete"
        urlRequest.httpBody = logOutBody(sessionID: self.sessionID)
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        
        do {
            let response = try await
            StatusResponce.shared.statusResponce(request: urlRequest, responce: LogOut.self)
            return response
        } catch let error {
            throw error
    }
}
    
    private func logOutBody(sessionID: String) -> Data? {
        let sessionID = SessionIDForDel(sessionID: sessionID)
        do {
            return try JSONEncoder().encode(sessionID)
        } catch {
            debugPrint("error")
            return nil
        }
    }
}

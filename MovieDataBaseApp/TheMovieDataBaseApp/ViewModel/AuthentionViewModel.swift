//
//  AuthentionViewModel.swift
//  TheMovieDataBaseApp
//
//  Created by Vakhtang on 17.01.2023.
//

import Foundation

class AuthentionViewModel {
    
    var isLogin = false
    
    func logIn(_ username: String, _ password: String) async throws {
        
        guard !username.isEmpty, !password.isEmpty else {
            print("error")
            return
        }
        do {
          let result = try await  AuthenticalNetworking.shared.requestAllAuthNetwork(username: username, password: password)
                
                isLogin = result
                
            
        } catch let error {
            throw error
        }
    }
    
    func guestSungIn() async throws {
        do {
          try await
            AuthenticalNetworking.shared.guestSession()
            isLogin = true
            
        }
    }
}

//
//  FirebaseCenter.swift
//  FeedIOS
//
//  Created by רם צמח on 04/07/2023.
//

import Foundation
import FirebaseAuth

class FirebaseCenter{
    
    
    static func login(email: String, password: String, completion: @escaping (_ success: Bool, _ data: Any?, _ errorMsg: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                completion(false, "", true)

                print("1")
            }
            else {
                completion(true, result, false)

                print("2")
            }
        }
    }
    
    static func signUp(email: String, password: String, completion: @escaping (_ success: Bool, _ data: Any?, _ errorMsg: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
                   if let user = authResult?.user {
                       print(user)
                       completion(true, user, false)

                   } else {
                       completion(false, "", true)

                       print(error)
                   }
               }
    }
}

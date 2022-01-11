//
//  User.swift
//  EggMeet
//
//  Created by 이윤성 on 2021/12/26.
//

import Foundation
import AuthenticationServices
import UIKit

struct User {
    let id: String
    let firstName : String
    let lastName : String
    let email: String
    let accessTokenString: String

    init(credentials: ASAuthorizationAppleIDCredential){
        self.id = credentials.user
        self.firstName = credentials.fullName?.givenName ?? ""
        self.lastName = credentials.fullName?.familyName ?? ""
        self.email = credentials.email ?? ""
        self.accessTokenString = String(data: credentials.identityToken!, encoding: .utf8)!
    }
    
    func setEmailLocalDB(){
        let ud = UserDefaults.standard
            ud.set(self.email, forKey: "email")
        NSLog("이메일 UD에 추가. \(ud.string(forKey: "email"))")
    }
    
}

extension User: CustomDebugStringConvertible{
    var debugDescription: String {
        return"""
        ID: \(id)
        First Name: \(firstName)
        Last Name: \(lastName)
        Email: \(email)
        accessToken: \(accessTokenString)
        """
    }
}

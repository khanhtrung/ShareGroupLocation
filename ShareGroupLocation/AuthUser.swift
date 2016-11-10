//
//  AuthUser.swift
//  ShareGroupLocation
//
//  Created by Tran Khanh Trung on 11/10/16.
//  Copyright © 2016 TRUNG. All rights reserved.
//

import Foundation
import Firebase

class AuthUser {
    let uid: String!
    let email: String!
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
    
    init(authUserData: FIRUser) {
        self.uid = authUserData.uid
        
        if let email = authUserData.providerData.first?.email {
            self.email = email
        } else {
            self.email = ""
        }
    }
}

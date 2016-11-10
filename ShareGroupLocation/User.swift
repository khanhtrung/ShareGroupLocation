//
//  User.swift
//  ShareGroupLocation
//
//  Created by Tran Khanh Trung on 11/10/16.
//  Copyright © 2016 TRUNG. All rights reserved.
//

import Foundation
import FirebaseDatabase

let USER_NAME = "user-name"
let USER_EMAIL = "email"
let USER_MOBILE_NUMBER = "mobile-number"
let USER_PIC_URL = "profile-pic"

class User {
    private var _userRef: FIRDatabaseReference!
    private var _userKey: String!
    
    private var _userName: String!
    private var _email: String!
    private var _mobileNumber: String!
    private var _profilePicUrl: String!
    
    // uid
    var userKey: String {
        return _userKey
    }
    
    var userName: String {
        return _userName
    }
    
    var email: String {
        return _email
    }
    
    var mobileNumber: String {
        return _mobileNumber
    }
    
    var profilePicUrl: String {
        return _profilePicUrl
    }
    
    init(userName: String, email: String, mobileNumber: String, profilePicUrl: String) {
        self._userName = userName
        self._email = email
        self._mobileNumber = mobileNumber
        self._profilePicUrl = profilePicUrl
    }
    
    init(userKey: String, userData: Dictionary<String, AnyObject>) {
        self._userKey = userKey
        
        if let userName = userData[USER_NAME] as? String {
            self._userName = userName
        }
        
        if let email = userData[USER_EMAIL] as? String {
            self._email = email
        }
        if let mobileNumber = userData[USER_MOBILE_NUMBER] as? String {
            self._mobileNumber = mobileNumber
        }
        
        if let profilePicUrl = userData[USER_PIC_URL] as? String {
            self._profilePicUrl = profilePicUrl
        }
        
        _userRef = DataService.ds.REF_USERS.child(_userKey)
    }
}

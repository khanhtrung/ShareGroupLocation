//
//  Group.swift
//  ShareGroupLocation
//
//  Created by Tran Khanh Trung on 11/11/16.
//  Copyright © 2016 TRUNG. All rights reserved.
//

import Foundation
import FirebaseDatabase

let GROUP_NAME = "group-name"
let GROUP_MEMBER_COUNT = "group-member-count"
let GROUP_CREATED_BY_USER = "group-created-by-user"

class Group {
    private var _groupRef: FIRDatabaseReference!
    private var _groupKey: String!
    
    private var _groupName: String!
    private var _groupMemberCount: Int!
    private var _groupCreatedByUser: String!
    
    // uid
    var groupKey: String {
        return _groupKey
    }
    
    var groupName: String {
        return _groupName
    }
    
    var groupMemberCount: Int {
        return _groupMemberCount
    }
    
    var groupCreatedByUser: String {
        return _groupCreatedByUser
    }
    
    init(groupName: String, groupMemberCount: Int, groupCreatedByUser: String) {
        self._groupName = groupName
        self._groupMemberCount = groupMemberCount
        self._groupCreatedByUser = groupCreatedByUser
    }
    
    init(groupKey: String, groupData: Dictionary<String, AnyObject>) {
        self._groupKey = groupKey
        
        if let groupName = groupData[GROUP_NAME] as? String {
            self._groupName = groupName
        }
        
        if let groupMemberCount = groupData[GROUP_MEMBER_COUNT] as? Int {
            self._groupMemberCount = groupMemberCount
        }
        
        if let groupCreatedByUser = groupData[GROUP_CREATED_BY_USER] as? String {
            self._groupCreatedByUser = groupCreatedByUser
        }
        
        _groupRef = DataService.ds.REF_GROUPS.child(_groupKey)
    }
}

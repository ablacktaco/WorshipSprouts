//
//  Worship.swift
//  WorshipSprouts
//
//  Created by 陳姿穎 on 2019/11/18.
//  Copyright © 2019 陳姿穎. All rights reserved.
//

import Foundation

struct WorshipList: Codable {
    
    var items_for_spout: [item]
    
    struct item: Codable {
        var id: Int
        var item_name: String
    }
}

struct WorshipData: Codable {
    var name: String
    var item_id: Int
}

struct WorshipRecord: Codable {
    
    var worship_history_for_spout: [Worshiper]
    
    struct Worshiper: Codable {
        var name: String
        var created_at: String
        var item: item
        
        struct item: Codable {
            var item_name: String
        }
    }
    
}

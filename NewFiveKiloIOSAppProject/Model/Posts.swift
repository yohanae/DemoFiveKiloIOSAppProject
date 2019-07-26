//
//  Posts.swift
//  NewFiveKiloIOSAppProject
//
//  Created by yoyo on 7/26/19.
//  Copyright © 2019 Compitence Over Identity Technologies. All rights reserved.
//

import Foundation
import UIKit

struct Post {
    var name: String = ""
    var post: String = ""
    
    
    init(data: [String:Any]) {
        
        if let obj = data["name"] as? String {
            self.name = obj
        }
        if let obj = data["post"] as? String {
            self.post = obj
        }
        
    }
    
}


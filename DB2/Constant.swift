//
//  Constant.swift
//  DB2
//
//  Created by Fedir Korniienko on 21.06.17.
//  Copyright © 2017 fedir. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

let BaseAPIUrl = "http://ec2-34-211-67-136.us-west-2.compute.amazonaws.com/api/chat/"

enum APIEndPoints: Int {
    case chat
    case message
    var urlSufix: String {
        switch self {
        case .chat: return "channels/"
        case .message: return "channels/1/messages/"
        }
    }
    
    
    var requestMethod: Alamofire.HTTPMethod{
        switch self {
        case .chat, .message: return .get
        }
    }
    
    var bodyParams: [String] {
        switch self {
            
        default: break
        }
        return []
        
    }
    
    var accessTokenRequared: Bool {
        
        switch self {
            
        case .chat, .message: return false
        }
        
    }
    
    var keyPath: String{
        switch self {
            
            
        default:
            return ""
        }
        
    }
    
    var objectType: Bool{
        switch self {
            
            
        default:
            return true
        }
    }
}


let windowSize = (UIApplication.shared.keyWindow?.frame.size)

let documentsDirectory : URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]



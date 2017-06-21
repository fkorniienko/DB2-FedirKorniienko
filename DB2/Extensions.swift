//
//  Extensions.swift
//  DB2
//
//  Created by Fedir Korniienko on 21.06.17.
//  Copyright © 2017 fedir. All rights reserved.
//

import Foundation
import UIKit
extension Dictionary{
    public init(keys: [Key], values: [Value])
    {
        precondition(keys.count == values.count)
        
        self.init()
        
        for (index, key) in keys.enumerated()
        {
            self[key] = values[index]
        }
    }
}
extension String {
    public var length: Int { return self.characters.count }
    
    public func toURL() -> NSURL? {
        return NSURL(string: self)
    }
    func toDateTime() -> NSDate
    {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSz"
        
        
        return formatter.date(from: self)! as NSDate
    }
}
extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
                DispatchQueue.global(qos: .background).sync {
                    self.image = image
                    }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}

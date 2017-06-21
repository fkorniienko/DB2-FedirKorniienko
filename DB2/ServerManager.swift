//
//  Servises.swift
//  DB2
//
//  Created by Fedir Korniienko on 21.06.17.
//  Copyright © 2017 fedir. All rights reserved.
//

import ObjectMapper
import Alamofire
import AlamofireObjectMapper
import SwiftyJSON
class ServerManager: NSObject
{
    var accessToken = ""
    static let sharedManager = ServerManager()
    
    let manager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        return SessionManager(configuration: configuration)
    }()
    
    override init() {
        super.init()
        
    }
    
    private func urlStringWithParameter(params: [String]?) -> String {
        if params == nil {
            return ""
        }
        var url: String = ""
        
        for param in params! {
            url += "/" + param
        }
        
        return url
    }
    
    
    
    func fetchDataWithEndPoint<T:Mappable>(type: T, endPoint: APIEndPoints, urlParams: [String]? = nil, urlStringParams: String = "", headerParams: [String: String]? = nil, bodyParams: [String]? = nil, bodyParamsInt: [NSNumber]? = nil,  withCompletionClosure completionClosure: @escaping (_ data: Any?, _ error: NSError?) ->()) {
        let url = BaseAPIUrl + endPoint.urlSufix + self.urlStringWithParameter(params: urlParams) + urlStringParams
        
        var header = [String: String]()
        
        if endPoint.accessTokenRequared == true {
            header["ACCESS-TOKEN"] =  self.accessToken
        }
        
        if headerParams != nil {
            for key in headerParams!.keys {
                header[key] = headerParams![key]
            }
        }
        
        var body: [String: String]? = nil
        
        if bodyParams != nil {
            body = bodyParams!.count > 0 ? Dictionary.init(keys: endPoint.bodyParams, values: bodyParams!) : [String: String]()
        }
        
        
            self.getObject(success: { (object: T) in
                
                completionClosure(object, nil)
            }, methods: endPoint.requestMethod, url: url, parameters: body as [String : AnyObject]?, headers: header, keyPath: endPoint.keyPath) { (error: NSError) in
                completionClosure(nil, error)
            }
            
        
    }
    
    private func getObject <T:Mappable> (success:@escaping (T) -> Void, methods: HTTPMethod, url: String?, parameters: [String: AnyObject]?, headers: [String: String]?, keyPath: String, fail:@escaping (_ error:NSError)->Void)->Void {
        
        DispatchQueue.global(qos: .background).async {
            
            self.manager.request(url!, method: methods, parameters: parameters, encoding:  URLEncoding.default, headers: headers).responseObject(keyPath: keyPath) { (response: DataResponse <T>) in
                
                if let js = String(data: response.data!, encoding: String.Encoding.utf8) {
                    let dic = JSON.parse(js)
                    
                    
                    
                    if dic["code"].int == 401  || dic["code"].int == 429 || dic["code"].int == 503 {
                        let serverError = self.formError(from: dic)
                        fail(serverError)
                        return
                    } else if dic["code"].int == 404{
                        fail(self.formError(from: dic))
                        return
                    }
                }
                
                if let token = response.response?.allHeaderFields["ACCESS-TOKEN"] as? String{
                    self.accessToken = token
                }
                switch response.result {
                case .success:
                    success(response.result.value!)
                case .failure:
                    fail(response.result.error! as NSError)
                }
            }
            
        }
    }
    

    
}

extension ServerManager {
    func formError(from dictionary: SwiftyJSON.JSON) -> NSError {
        let currentError = NSError(domain: "somedomain",
                                   code: dictionary["code"].int!,
                                   userInfo: ["message": dictionary["message"].stringValue])
        return currentError
    }
}

//
//  YTKSetter.swift
//  YTKKeyValueStore
//
//  Created by ysq on 15/2/11.
//  Copyright (c) 2015年 sgxiang. All rights reserved.
//

import UIKit

public struct YTKSetter {
    internal var objectId : String!
    private var object : AnyObject!
    public init(_ id : String!, _ object : AnyObject!){
        self.objectId = id
        self.object = object
    }
    
    internal var jsonString : String?{
        get{
            
            if let string = self.object as? String{
                return string
            }else{
                
                var sqlObject : AnyObject?

                if let number = self.object as? NSNumber{
                    sqlObject = [number]
                }else if (self.object as? Array<AnyObject>) != nil || (self.object as? Dictionary<String,AnyObject>) != nil {
                    sqlObject = self.object
                }
                else{
                    return nil
                }
                
                do{
                    let data = try NSJSONSerialization.dataWithJSONObject(sqlObject!, options: NSJSONWritingOptions(rawValue: 0))
                    return NSString(data: data, encoding: NSUTF8StringEncoding) as? String
                }catch{
                    print("faild to get json data")
                    return nil
                }

            }

        }
    }
}

infix operator <- { associativity left precedence 140 }
public func <- (objectId: String!, object: AnyObject!) -> YTKSetter{
    return YTKSetter(objectId , object)
}

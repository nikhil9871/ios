//
//  ModelClass.swift
//  TestClick
//
//  Created by cl-macmini-150 on 24/06/16.
//  Copyright © 2016 cl-macmini-150. All rights reserved.
//

import UIKit

class ModelClass: NSObject,NSCoding {
    var imagePath: String!
    var itemName: String!
    var content: [String : String]!
    
    init(imagePath: String, itemName: String,content: [String : String]){
        super.init()
        self.imagePath=imagePath
        self.itemName=itemName
        self.content=content
    }
    
    required init(coder decoder: NSCoder) {
        //Error here "missing argument for parameter name in call
        self.imagePath = decoder.decodeObjectForKey("imagePath") as! String
        self.itemName = decoder.decodeObjectForKey("itemName") as! String
        self.content = decoder.decodeObjectForKey("content") as!  [String : String]
        super.init()
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.imagePath, forKey: "imagePath")
        coder.encodeObject(self.itemName, forKey: "itemName")
        coder.encodeObject(self.content, forKey: "content")
        
        
    }
    
    
    
}

//
//  SimpleXMLNode.swift
//  Simple XML to Dictionary
//
//  Created by Nicolás Fernando Miari on 2016/04/15.
//  Copyright © Nicolás Miari. All rights reserved.
//

import UIKit

class SimpleXMLNode: NSObject
{
    var name:String
    
    weak var parent:SimpleXMLNode?

    private (set) var children:[SimpleXMLNode]?
    
    var content:String?
    
    
    init(name:String)
    {
        self.name = name
        
        super.init()
    }
    
    
    func addChild(node:SimpleXMLNode)
    {
        if children == nil {
            children = [SimpleXMLNode]()
        }
        
        children?.append(node)
        
        node.parent = self
    }
    
    
    /** 
     Recursive
     */
    func dictionaryRepresentation() -> AnyObject
    {
        guard children?.count > 0 else {
            // LEAF element. Return strng value:
            return content ?? ""
        }
        
        // Node has children. Return array or dictionary
        
        // Group all the dictionary representations for children with the same 
        // name into arrays keyed by said name:
        
        var childrenByCommonName = [String : [AnyObject]]()
        
        for child in children! {
            
            let childRepresentation = child.dictionaryRepresentation()
            
            if var existingArray = childrenByCommonName[child.name]{

                existingArray.append(childRepresentation)
                childrenByCommonName[child.name] = existingArray
            }
            else{
                childrenByCommonName[child.name] = [childRepresentation]
            }
        }
        
        var dictionary = [String : AnyObject]()
        
        for (name, array) in childrenByCommonName {
        
            if array.count == 1 {
                // Array is superfluous (contains only one node); simplify by
                // inserting its onyl element at the root:
                dictionary[name] = array[0]
            }
            else{
                // Array contains one or more elements of the same name; add it
                // as-is:
                dictionary[name] = array
            }
        }
        
        return dictionary
    }
    
}



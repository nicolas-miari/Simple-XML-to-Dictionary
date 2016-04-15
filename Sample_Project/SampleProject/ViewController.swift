//
//  ViewController.swift
//  SampleProject
//
//  Created by Nicolás Fernando Miari on 2016/04/15.
//  Copyright © 2016 Nicolás Miari. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        /*
         Sample XML file taken  from:
         http://www.w3schools.com/xml/cd_catalog.xml
         */
        
        guard let path = NSBundle.mainBundle().pathForResource("Catalog", ofType: "xml") else {
            return print("File Not Found!")
        }
        
        guard let data = NSData(contentsOfFile: path) else {
            return print("Failed to read file!")
        }
        
        let parser = SimpleXMLParser(
            withSourceData: data, parseCompletionHandler: { (result) -> (Void) in
                
                print("Result: \(result)")
            },
            parseErrorHandler: {error in
                
                print("Error: \(error.localizedDescription)")
            }
        )
        
        parser.start()
    }

}


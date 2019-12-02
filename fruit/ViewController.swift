//
//  ViewController.swift
//  fruit
//
//  Created by D7703_16 on 2019. 12. 2..
//  Copyright © 2019년 D7703_16. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate {
    
    var item:[String:String] = [:]      //[key:value]
    var elements:[[String:String]] = [] //dictionary 배열
    var currentElement = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let strURL = "http://api.androidhive.info/pizza/?format=xml"
        let pizzaURL = NSURL(string: strURL)
        
        //optional binding 처리
        
        if pizzaURL != nil {
            let myParser = XMLParser(contentsOf: pizzaURL! as URL)
            if myParser != nil {
                //XMLParserDelegate와 UIViewController 연결
                myParser?.delegate = self
                
                //parsing 시작
                if (myParser?.parse())! {
                    print("parsing succed!")    //성공
                    print(elements)
                } else {
                    print("parsing error")
                }
            } else {
                print("parsing error!")
            }
        } else {
            print("file error")
        }
    }
    
    //XML delegate method
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]){
        currentElement = elementName
        print(currentElement)
    }

    public func parser(_ parser: XMLParser, foundCharacters string: String){
        //공백 및 white character제거
        let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        
        if !data.isEmpty{
            item[currentElement] = data
        }
    }
    
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?){
        
        if elementName == "item" {
            elements.append(item)
        }
    }
    
}


//
//  ViewController.swift
//  Json parsing in swift
//
//  Created by shahed on 2/9/17.
//  Copyright © 2017 Mac air. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let url="http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topfreeapplications/limit=10/json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let urlRequest=URLRequest(url: URL(string: url)!);
        let urlSession=URLSession.shared;
        // background thread
        let task=urlSession.dataTask(with: urlRequest, completionHandler: {
            (data,response,error)->Void in
            if let error=error{
                print("shahed: \(error)");
                return;
            }
            
            // parse json data
            if let data=data{
                do{
                    let jsonResult=try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    print("shahed:\(jsonResult)")
                    if let feed=jsonResult["feed"] as? NSDictionary{
                        if let entry=feed["entry"] as? NSDictionary{
                            print("entry: \(entry)");
                            if let id=entry["id"] as? NSDictionary{
                                print("id=\(id)");
                            }
                        }
                    }
                }catch{
                    print(error);
                }
            }
            
        })
        task.resume();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


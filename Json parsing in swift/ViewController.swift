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
                    let dict=try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String,AnyObject>
                    print("dict:\(dict!)");
                    print("1st")
                    if let feed=dict?["feed"] as? Dictionary<String,AnyObject>{
                        print("feed:\(feed)");
                        print("2nd");
                        
                        if let author=feed["author"] as? NSDictionary{
                            if let authorName=author["name"] as? NSDictionary{
                                if let authorNameLabel=authorName["label"] as? String{
                                    print("label:\(authorNameLabel)");
                                    print("3rd");
                                }
                            }
                        }
                        
                        if let entry=feed["entry"] as? [Dictionary<String,AnyObject>]{
                            for i in 0..<entry.count{
                                if let name=entry[i]["im:name"]{
                                    print("\(i):\(name)");
                                }
                            }
                        }
                        
                    }
                    //                    print(allFeed["entry"]);
                    // array hisebe niye index diye access korbo
                    //                    if let feed=allFeed["feed"]{
                    //                        print("count: \(feed.count)")
                    //                        print("inside1")
                    ////                        print("feed[0]:\(feed[0] as! [String:AnyObject])");
                    ////                        print("feed[1]:\(feed[1])");
                    ////                        print("inside2")
                    ////                        for index in 0...feed.count-1 {
                    ////                          let allObject = feed[index] as! [String : AnyObject]
                    ////                            print("allObject:\(allObject)");
                    ////                        }
                    //                        // kivaLoan er moto loop use kore korle complexity beshi hobe. kintu jodi shob element lage tobe KivaLoan er moto kora.
                    ////                        if let entry=feed[0] as? [AnyObject]{
                    ////                            print("entry: \(entry)")
                    ////                        }
                    //                    }
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


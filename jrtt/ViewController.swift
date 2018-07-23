//
//  ViewController.swift
//  jrtt
//
//  Created by 王小腊 on 2018/7/19.
//  Copyright © 2018年 王小腊. All rights reserved.
//

// http://www.cocoachina.com/swift/20170911/20522.html
import UIKit
import SnapKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let button = UIButton.init(type: .custom)
        button.setTitle("点击请求", for: .normal)
        button.backgroundColor = .orange
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(self.requestData), for: .touchUpInside)
        self.view.addSubview(button)
        
        button.snp.makeConstraints { (make) in
            
            make.width.height.equalTo(100)
            make.center.equalTo(self.view)
            
        }

    }

    
    @objc func requestData() {
        
        let date = NSDate()
        let timeInterval = date.timeIntervalSince1970 * 1000
        
        let timeStamp: String =  String(stringInterpolationSegment: Int(timeInterval))

        let dic: [String: Any] = ["AppId":"758120306327",
                                  "AppKey":"faf4fa88935d4d2bbadd9dbe10f9d5f2",
                                  "TimeStamp":timeStamp,
                                  "id":"25689",
                                  "interfaceId":"296",
                                  "page":"1",
                                  "rows":"20"]
        
        WHNetwork.request(target: .demo3(parameter: dic), success: { (res) in
            
            let data: [String:Any] = res as! [String:AnyObject]
            
            let errcode: String = data["errcode"] as! String
            
            if errcode == "00000" {
                
                let list:Any = data["data"] as Any
                
                guard let mode = ScenicSpotMode(JSON: list as! [String:AnyObject]) else {return}
                
                print(mode.root.first!.address)
                
            }
        }) { (error) in
            
            print(error)
        }
    }

    // #MARK:- wee
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


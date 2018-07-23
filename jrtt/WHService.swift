//
//  WHService.swift
//  jrtt
//
//  Created by 王小腊 on 2018/7/23.
//  Copyright © 2018年 王小腊. All rights reserved.
//

import Foundation
import Moya

// 网络请求结构体
struct WHNetwork {
    
    // 请求成功的回调
    typealias successCallback = (_ result: Any) -> Void
    // 请求失败的回调
    typealias failureCallback = (_ error: MoyaError) -> Void
    
    // 单例
    static let provider = MoyaProvider<WHService>()
    
    // 发送网络请求
    static func request(
        target: WHService,
        success: @escaping successCallback,
        failure: @escaping failureCallback
        ) {
        
        provider.request(target) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    try success(moyaResponse.mapJSON()) // 测试用JSON数据
                } catch {
                    failure(MoyaError.jsonMapping(moyaResponse))
                }
            case let .failure(error):
                failure(error)
            }
        }
    }
}


// 定义请求方法
enum WHService {
    case demo1
    case demo2(name: String)
    case demo3(parameter: [String:Any])
}

extension WHService: TargetType {
    
    // 请求服务器的根路径
    var baseURL: URL { return URL.init(string: "https://jpjs.geeker.com.cn/service.csw")! }
    
    // 每个API对应的具体路径
    var path: String {
   return ""
    }
    
    // 各个接口的请求方式，get或post
    var method: Moya.Method {
        switch self {
        case .demo1:
            return .get
        case .demo2, .demo3:
            return .get
        }
    }
    
    // 请求是否携带参数，如果需要参数，就做如demo2和demo3的设置
    var task: Task {
        switch self {
        case .demo1:
            return .requestPlain // 无参数
        case let .demo2(name): // 带有参数,注意前面的let
            return .requestParameters(parameters: ["name" : name], encoding: URLEncoding.default)
        case let .demo3(parameter): // 带有参数,注意前面的let
            return .requestParameters(parameters:parameter, encoding: URLEncoding.default)
        }
    }
    
    // 单元测试使用
    var sampleData: Data {
        switch self {
        case .demo1, .demo3:
            return "just for test".utf8Encoded
        case .demo2(let name):
            return "{\"name\": \(name)\"}".utf8Encoded
        }
    }
    
    // 请求头
    var headers: [String : String]? {
        return ["Content-type" : "application/json"]
    }
}

// 扩展方法
private extension String {
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}

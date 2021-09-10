//
//  NewLoggerPlugin.swift
//  a
//
//  Created by HM on 2021/9/9.
//
import Moya

final class NewLoggerPlugin: PluginType {
    var startTimes: [String: CFAbsoluteTime] = [:]

    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var newRequest = request
        newRequest.timeoutInterval = NetworkConstant.timeoutInterval
        return newRequest
    }

    func willSend(_ request: RequestType, target: TargetType) {
        startTimes[target.path] = CFAbsoluteTimeGetCurrent()
    }

    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case .success(let response):

            debugPrint("  ┌────────────────────────────────────────────────────────────────\n")
            debugPrint("  ├┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄网络请求完成┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄\n")
            debugPrint("  ├ 请求类型: \(response.request?.httpMethod ?? "无") \n")
            debugPrint("  ├ 请求地址: \(response.request?.url?.absoluteString ?? "无") \n")
            debugPrint("  ├ 响应代码: \(response.statusCode) \n")
            debugPrint("  ├ 请求头部: \(response.request?.allHTTPHeaderFields ?? [:]) \n")
            debugPrint("  ├ Body数据: \(response.request?.httpBody?.stringValue ?? "无") \n")
            debugPrint("  ├ 请求耗时: \(String(format: "%.2f", time(for: target.path)))ms \n")
            debugPrint("  ├ 服务器返回数据:  \((try? response.mapString()) ?? "无") \n")
            debugPrint("  └──────────────────────────────────────────────────────────────── \n")

            debugPrint(response.response?.allHeaderFields ?? [:])
        case .failure(let error):

            debugPrint("  ┌────────────────────────────────────────────────────────────────\n")
            debugPrint("  ├┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄网络请求完成┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄\n")
            debugPrint("  ├ 请求类型: \(target.method) \n")
            debugPrint("  ├ 请求地址: \(target.baseURL.absoluteString + target.path) \n")
//            items.append("  ├ 响应代码: \(response.statusCode) \n")
            debugPrint("  ├ 请求头部: \(target.headers ?? [:]) \n")
//            items.append("  ├ Body数据: \(target. ?? "无") \n")
            debugPrint("  ├ 请求耗时: \(String(format: "%.2f", time(for: target.path)))ms \n")
            debugPrint("  ├ 错误信息:  \(error.localizedDescription) \n")
            debugPrint("  └──────────────────────────────────────────────────────────────── \n")

//            print(error.localizedDescription)
            //            outputError(logNetworkError(error, target: target))
        }
        startTimes.removeValue(forKey: target.path)
    }

    func time(for path: String) -> CFAbsoluteTime {
        let start = startTimes[path] ?? 0
        return (CFAbsoluteTimeGetCurrent() - start) * 1000
    }
}

// 网络请求打印格式
/*
 请求类型: ......
 请求地址: ......
 响应代码:
 发送数据:
 请求耗时:
 服务器返回数据:
 */

extension Data {
    var stringValue: String {
        return String(data: self, encoding: .utf8) ?? ""
    }
}

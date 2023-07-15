////
////  Services.swift
////  finall
////
////  Created by רם צמח on 15/07/2023.
////
//
//import Foundation
//import Alamofire
//
//let URL_GET_ALL_MARKETS = "/market/getAllMarkets"
//let URL_BASE = "http://local.inx.services:3010/mobile"
//class Services: NSObject {
//    static let tokenRefreshAttempts: Int = 3
//    static let timeout: Double = 60
//    
//    
//    
//    static public func getAllMarkets(completion: @escaping (_ success: Bool, _ data: Any?, _ errorMsg: String) -> Void) {
//              
//        
//        self.sendRequest(url: URL_GET_ALL_MARKETS,
//                         method: .get,
//                         params: nil,
//                         isRequestingToken: false,
//                         listener: nil) { (result, errorMsg) in
//            if result != nil {
//                if let response = Market.parse(json: result as? String ?? "") {
//                    completion(true, response, "")
//                    NSLog("Get All Markets service success")
//                } else {
//                    completion(false, nil, "general-service-error-msg")
//                }
//            } else if errorMsg != nil {
//                if let error = Error.parse(json: errorMsg ?? "") {
//                    completion(false, nil, error.msg ?? "general-service-error-msg")
//                    NSLog("error")
//                } else {
//                    completion(false, nil, "general-service-error-msg")
//                    NSLog("error")
//                }
//            } else {
//                completion(false, nil, "general-service-error-msg")
//            }
//        }
//    }
//    
//    static public func sendRequest(url: String,
//                                   method: HTTPMethod,
//                                   params: [String: Any]?,
//                                   isRequestingToken: Bool,
//                                   listener: UIViewController?,
//                                   headers: HTTPHeaders = [:],
//                                   completion: @escaping (_ result: Any?, _ errorMsg: String?) -> Void) {
//
//        let finalUrl = URL_BASE + url
//        self.alamofireRequest(finalUrl: finalUrl,
//                              method: method,
//                              parameters: params,
//                              encoding: JSONEncoding.default,
//                              headers: headers,
//                              attempts: 1) { (result, errorMsg) in
//            completion(result, errorMsg)
//        }
//    }
//
//    static func alamofireRequest(finalUrl: String,
//                                 method: HTTPMethod,
//                                 parameters: [String: Any]?,
//                                 encoding: JSONEncoding,
//                                 headers: HTTPHeaders,
//                                 attempts: Int,
//                                 completion: @escaping (_ result: Any?, _ errorMsg: String?) -> Void) {
//
//        AF.request(finalUrl, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers, requestModifier: {$0.timeoutInterval = Services.timeout})
//            .responseString { response in
//                switch response.result {
//                case .success(let value):
//                    if let statusCode = response.response?.statusCode, statusCode >= 200, statusCode <= 299 {
////                        if statusCode == 201 && Session.parse(json: response.value ?? "")?.requireVerifyEmail == true {
////                            if let topCtrl = Services.getCurrentController() {
////                                let storyboard = UIStoryboard(name: "Login", bundle: nil)
////                                let ctrl = storyboard.instantiateViewController(withIdentifier: String(describing: NotApprovedViewController.self))
////                                ctrl.modalPresentationStyle = .fullScreen
////                                topCtrl.present(ctrl, animated: false)
////                            }
////                        }
//                        completion(value, nil)
//                    } else if let statusCode = response.response?.statusCode, statusCode == 401 || statusCode == 403 || statusCode == 503 {
//                        if let errorEnum = Error.parse(json: response.value!)?.errorEnum {
//                            self.manageError(response: response.response, result: response.value) { result in
//                                completion(nil, result)
//                            }
//                        } else {
//                            self.manageError(response: response.response, result: response.value, isNotApproved: true) { result in
//                                completion(nil, result)
//                            }
//                        }
//                    } else {
//                        completion(nil, value)
//                    }
//
//                case .failure:
//                        if let statusCode = response.response?.statusCode, statusCode >= 200, statusCode <= 299 {
//                            completion("", nil)
//                        } else {
//                            self.manageError(response: response.response, result: response.value) { (result) in
//                                if result != nil && (result as? Bool) ?? false && attempts <= Services.tokenRefreshAttempts {
//                                    self.alamofireRequest(finalUrl: finalUrl,
//                                                          method: method,
//                                                          parameters: parameters,
//                                                          encoding: JSONEncoding.default,
//                                                          headers: headers,
//                                                          attempts: attempts + 1,
//                                                          completion: { (result, errorMsg) in
//                                        completion(result, nil)
//                                    })
//                                } else {
//                                    completion(nil, nil)
//                                }
//                            }
//                        }
//                    
//                default:
//                    completion(nil, nil)
//                }
//            }
//    }
//    
//    static func manageError(response: HTTPURLResponse?, result: String?, isNotApproved: Bool = false, completion: @escaping (_ result: String?) -> Void) {
//        if let statusCode = response?.statusCode {
//            switch statusCode {
//            case 201:
//                if isNotApproved {
////                    if let topCtrl = Services.getCurrentController() {
////                        let storyboard = UIStoryboard(name: "Login", bundle: nil)
////                        let ctrl = storyboard.instantiateViewController(identifier: String(describing: NotApprovedViewController.self))
////                        ctrl.modalPresentationStyle = .fullScreen
////                        topCtrl.present(ctrl, animated: false)
////                    }
//                    completion(nil)
//                }
//                completion(result)
//            case 401:
////                if let topCtrl = Services.getCurrentController() {
////                    let alertCtrl = UIAlertController(title: nil, message: "general-token-expired".localized(), preferredStyle: .alert)
////                    alertCtrl.addAction(UIAlertAction(title: "Accept", style: .default, handler: { _ in
////                        SessionManager.inactivityLogout()
////                        topCtrl.navigationController?.popToRootViewController(animated: true)
////                    }))
////                    if SessionManager.getSession() == nil { } else {
////                        topCtrl.present(alertCtrl, animated: true)
////                    }
////                    completion(nil)
////                }
//                completion(result)
//            case 403:
//                if isNotApproved {
////                    if let topCtrl = Services.getCurrentController() {
////                        let storyboard = UIStoryboard(name: "Login", bundle: nil)
////                        let ctrl = storyboard.instantiateViewController(identifier: String(describing: NotApprovedViewController.self))
////                        ctrl.modalPresentationStyle = .fullScreen
////                        topCtrl.present(ctrl, animated: false)
////                    }
////                    completion(nil)
//                }
//                completion(result)
//            case 503:
////                if let topCtrl = Services.getCurrentController() {
////                    let storyboard = UIStoryboard(name: "UnderMaintenance", bundle: nil)
////                    let ctrl = storyboard.instantiateViewController(identifier: String(describing: UnderMaintenanceController.self))
////                    topCtrl.present(ctrl, animated: false)
////                    completion(nil)
////                }
//                completion(result)
//            default:
//                completion(result)
//            }
//        } else {
//            completion(result)
//        }
//    }
//}

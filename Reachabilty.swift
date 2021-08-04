//
//  Reachabilty.swift
//  Reachability
//
//  Created by rezatec on 18/01/2021.
//

import Foundation

class func getConnectionType() -> String {
    guard let reachability = SCNetworkReachabilityCreateWithName(kCFAllocatorDefault, "www.google.com") else {
        return "NO INTERNET"
    }
    
    var flags = SCNetworkReachabilityFlags()
    SCNetworkReachabilityGetFlags(reachability, &flags)
    
    let isReachable = flags.contains(.reachable)
    let isWWAN = flags.contains(.isWWAN)
    
    if isReachable {
        if isWWAN {
            let networkInfo = CTTelephonyNetworkInfo()
            let carrierType = networkInfo.serviceCurrentRadioAccessTechnology
            
            guard let carrierTypeName = carrierType?.first?.value else {
                return "UNKNOWN"
            }
            
            switch carrierTypeName {
            case CTRadioAccessTechnologyGPRS, CTRadioAccessTechnologyEdge, CTRadioAccessTechnologyCDMA1x:
                return "2G"
            case CTRadioAccessTechnologyLTE:
                return "4G"
            default:
                return "3G"
            }
        } else {
            return "WIFI"
        }
    } else {
        return "NO INTERNET"
    }
}

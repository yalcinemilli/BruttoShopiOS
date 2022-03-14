//
//  ATT.swift
//  Bruttoshop
//
//  Created by Yalcin Emilli on 15.09.21.
//

import Foundation
import AppTrackingTransparency

@available(iOS 15.0.0, *)
struct ATT {
    private init() {}
   
    static func permissionRequest() async -> Bool {
        switch ATTrackingManager.trackingAuthorizationStatus {
        case .notDetermined:
            print("1")
            await ATTrackingManager.requestTrackingAuthorization()
            return ATTrackingManager.trackingAuthorizationStatus == .authorized
        case .restricted, .denied:
            print("2")
            return false
        case .authorized:
            print("3")
            return true
        @unknown default:
            fatalError()
        }
    }
}

//
//  Configuration.swift
//  CARTE
//
//  Created by Tomoki Koga on 2019/07/17.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation

struct Configuration {
    
    static var applicationKey: String {
        // KARTE SDKの動作に必要な `application key` を返してください。
//        return "<YOUR_APPLICATION_KEY>"
        fatalError("Application key settings are required.")
    }
    
    static var webContentHostingURL: String {
        // ウェブコンテンツのホスティング先URLを返してください（Firebase Hosting）
//        return "https://<YOUR_HOST>.web.app"
        fatalError("It is necessary to set the hosting destination URL.")
    }
    
    static var deeplinkBaseURL: String {
        // ディープリンクURLを返してください
//        return "carte://<YOUR_HOST>.web.app"
        fatalError("It is necessary to set the deeplink base URL.")
    }
}

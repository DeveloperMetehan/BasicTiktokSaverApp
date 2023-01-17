//
//  AppModel.swift
//  TiktokSaver
//
//  Created by Metehan Karadeniz on 16.01.2023.
//
import Foundation
import SwiftyJSON

final class AppModel {
    var link : String?
      

    init(withJSON json: JSON) {
        
        link = json["data"]["play"].stringValue
    }
}

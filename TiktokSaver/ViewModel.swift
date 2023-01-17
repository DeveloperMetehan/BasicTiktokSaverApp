//
//  ViewModel.swift
//  TiktokSaver
//
//  Created by Metehan Karadeniz on 16.01.2023.
//


import Foundation
import Alamofire
import SwiftyJSON

final class ViewModel {
    
    func getData(url: String) {
        let request = URLRequest(url: URL(string: url)!)
        DispatchQueue.global(qos: .utility).async {
            Alamofire.request(request).responseJSON { (response) in
                let responseData = response.data
                let jsozn = JSON(responseData!)
                AppConfig.appModel = AppModel(withJSON: jsozn)
            }
        }
    }
}

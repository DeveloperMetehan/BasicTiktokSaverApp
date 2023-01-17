//
//  ViewController.swift
//  TiktokSaver
//
//  Created by Metehan Karadeniz on 15.01.2023.
//

import UIKit
import Alamofire
import SwiftyJSON
import Photos

class ViewController: UIViewController,FileManagerDelegate {
    var videoLink = ""
    @IBOutlet weak var linkTextField: UITextField!
    let vm = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }
    @IBAction func buttonClickedForDownload(_ sender: Any) {
        self.vm.getData(url: "https://tiktok-video-no-watermark2.p.rapidapi.com/?rapidapi-key=ef8543ce76mshe22b1c2ae02928cp1d0218jsn5456e1075a35&url=\(linkTextField.text!)&hd=0")
        DispatchQueue.main.asyncAfter(deadline: .now()+1){
            self.videoLink = AppConfig.appModel!.link!
            print(self.videoLink)
            DispatchQueue.global(qos: .background).async {
                if let url = URL(string: self.videoLink),
                    let urlData = NSData(contentsOf: url) {
                    let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0];
                    let filePath="\(documentsPath)/tempFile.mp4"
                    DispatchQueue.main.async {
                        urlData.write(toFile: filePath, atomically: true)
                        PHPhotoLibrary.shared().performChanges({
                            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: URL(fileURLWithPath: filePath))
                        }) { completed, error in
                            if completed {
                                print("Video is saved!")
                            }
                        }
                    }
                }
            }
        }
    }
    
}


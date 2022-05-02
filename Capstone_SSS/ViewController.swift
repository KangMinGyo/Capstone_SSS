//
//  ViewController.swift
//  Capstone_SSS
//
//  Created by Kang on 2022/03/26.
//

import UIKit
import AVKit
import Alamofire
import AVFoundation
import MobileCoreServices

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var videoURL: URL?
    var videoData: Data?
    var thumbnail: UIImage?
    
    var testImage: UIImage?

    let imgPickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imgPickerController.delegate = self
    }

    @IBAction func addImage(_ sender: UIBarButtonItem) {
        
//        imgPickerController.sourceType = .photoLibrary
//        self.present(imgPickerController, animated: true, completion: nil)

        VideoHelper.startMediaBrowser(delegate: self, sourceType: .savedPhotosAlbum)
    }
    
    //신고하기 버튼 클릭 되었을 때
    @IBAction func reportButtonClicked(_ sender: UIButton) {
    //file:///private/var/mobile/Containers/Data/PluginKitPlugin/F72A5C2F-3B45-4C40-AAEB-7DAC95C46EC8/tmp/trim.587087F5-A1A7-449D-9B9C-4660E4EAAB55.MOV
    //341635 bytes
        do {
            uploadImage(imageURL: videoURL!)
            //let data = try Data(contentsOf: videoURL!, options: .mappedIfSafe)
            //-let data = thumbnail?.jpegData(compressionQuality: 0.8)
//-        print(videoURL!)
        //-print(data)
        //-editActivity(imageData: thumbnail!)
        } catch {
        }
    }
    
}

func uploadImage(imageURL: URL?) {
        
        let URL = "http://127.0.0.1:8000/uploadfiles"
//    let URL = "192.168.0.55"
        let header : HTTPHeaders = [
            "Content-Type" : "application/json"]
    
//    let timestamp = NSDate().timeIntervalSince197
    
    AF.upload(multipartFormData: { multipartFormData in
        multipartFormData.append(imageURL!, withName: "files", fileName: "video.mp4", mimeType: "video/mp4")
        
    }, to: URL, usingThreshold: UInt64.init(), method: .post, headers: header).response { response in
        guard let statusCode = response.response?.statusCode,
              statusCode == 200
        else { return }

//        AF.upload(multipartFormData: { multipartFormData in
//            if let image = imageData?.jpegData(compressionQuality: 0.8) {
//                multipartFormData.append(image, withName: "files", fileName: "\(image).jpeg", mimeType: "image/jpeg")
//            }
//        }, to: URL, usingThreshold: UInt64.init(), method: .post, headers: header).response { response in
//            guard let statusCode = response.response?.statusCode,
//                  statusCode == 200
//            else { return }
            //completion(.success(statusCode))
    }
}
    enum VideoHelper {
      static func startMediaBrowser(
        delegate: UIViewController & UINavigationControllerDelegate & UIImagePickerControllerDelegate,
        sourceType: UIImagePickerController.SourceType
      ) {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType)
          else { return }

        let mediaUI = UIImagePickerController()
        mediaUI.sourceType = sourceType
        mediaUI.mediaTypes = [kUTTypeMovie as String]
        mediaUI.allowsEditing = true
        mediaUI.delegate = delegate
        delegate.present(mediaUI, animated: true, completion: nil)
      }
    }

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
//        if let img = info[UIImagePickerController.InfoKey.originalImage]{
//            imageView.image = img as? UIImage
//            testImage = img as! UIImage
//                }
//
//                dismiss(animated: true, completion: nil)
        
        if let pickedVideo = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
            videoURL = pickedVideo
            //viedo URL -> Data
//            do {
//                videoData = try Data(contentsOf: pickedVideo, options: .mappedIfSafe)
//                print(videoData!)
//            } catch {
//
//            }
            
            //Thumbnail
            let myAsset = AVAsset(url: pickedVideo)
            let imageGenerator = AVAssetImageGenerator(asset: myAsset)
            let time: CMTime = CMTime(value: 600, timescale: 600)
            guard let cgImage = try? imageGenerator.copyCGImage(at: time, actualTime: nil) else { fatalError() }
            let uiImage = UIImage(cgImage: cgImage)
            thumbnail = uiImage
            imageView.image = uiImage
            
            
        }
    }
}


//extension ViewController: PHPickerViewControllerDelegate {
//
//    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//        picker.dismiss(animated: true)
//
//        guard let provider = results.first?.itemProvider else { return }
//
//        if provider.hasItemConformingToTypeIdentifier(UTType.movie.identifier) {
//            provider.loadFileRepresentation(forTypeIdentifier: UTType.movie.identifier) { (url, err) in
//                guard let videoURL = url else { return }
//                print("resullt:", videoURL)
//                DispatchQueue.main.async {
//                    let player = AVPlayer(url: videoURL)
//                    let playerVC = AVPlayerViewController()
//                    playerVC.player = player
//                    self.present(playerVC, animated: true, completion: nil)
//                }
//            }
//        }
//    }
//}

//영상
//guard
//    let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String,
//        mediaType == (kUTTypeMovie as String),
//            let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL
//            else { return }
//
//// 2
//dismiss(animated: true) {
//    //3
//    let player = AVPlayer(url: url)
//    let vcPlayer = AVPlayerViewController()
//    vcPlayer.player = player
//    self.present(vcPlayer, animated: true, completion: nil)
//    }

//extension ViewController: PHPickerViewControllerDelegate {
//
//    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//        picker.dismiss(animated: true)
//
//        guard let provider = results.first?.itemProvider else { return }
//
//        if provider.hasItemConformingToTypeIdentifier(UTType.movie.identifier) {
//            provider.loadFileRepresentation(forTypeIdentifier: UTType.movie.identifier) { (url, err) in
//                DispatchQueue.main.async {
//                    if let url = url {
//                        print("resullt:", url)
//                        let player = AVPlayer(url: url)
//                        let playerVC = AVPlayerViewController()
//                        playerVC.player = player
//                        self.present(playerVC, animated: true, completion: nil)
//
//                    }
//                }
//            }
//        }
//    }
//}

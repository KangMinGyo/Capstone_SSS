//
//  ViewController.swift
//  Capstone_SSS
//
//  Created by Kang on 2022/03/26.
//

import UIKit
import AVKit
import AVFoundation
import MobileCoreServices

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func addImage(_ sender: UIBarButtonItem) {
        
        VideoHelper.startMediaBrowser(delegate: self, sourceType: .savedPhotosAlbum)
    
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
        if let pickedVideo = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
            let myAsset = AVAsset(url: pickedVideo)
            let imageGenerator = AVAssetImageGenerator(asset: myAsset)
            let time: CMTime = CMTime(value: 600, timescale: 600)
            guard let cgImage = try? imageGenerator.copyCGImage(at: time, actualTime: nil) else { fatalError() }
            let uiImage = UIImage(cgImage: cgImage)
            imageView.image = uiImage
            
            do {
                let data = try Data(contentsOf: pickedVideo, options: .mappedIfSafe)
            print(pickedVideo)
            print(data)
            } catch {
            }
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

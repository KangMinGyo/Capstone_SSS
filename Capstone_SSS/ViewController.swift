//
//  ViewController.swift
//  Capstone_SSS
//
//  Created by Kang on 2022/03/26.
//

import UIKit
import PhotosUI //PHPicker 사용을 위한 import
import AVKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func addImage(_ sender: UIBarButtonItem) {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1 //선택할 수 있는 최대 asset 수
        configuration.filter = .videos
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
}


extension ViewController: PHPickerViewControllerDelegate {

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
    
        guard let provider = results.first?.itemProvider else { return }
        
        if provider.hasItemConformingToTypeIdentifier(UTType.movie.identifier) {
            provider.loadFileRepresentation(forTypeIdentifier: UTType.movie.identifier) { (url, err) in
                guard let videoURL = url else { return }
                print("resullt:", videoURL)
                DispatchQueue.main.async {
                    let player = AVPlayer(url: videoURL)
                    let playerVC = AVPlayerViewController()
                    playerVC.player = player
                    self.present(playerVC, animated: true, completion: nil)
                }
            }
        }
    }
}

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

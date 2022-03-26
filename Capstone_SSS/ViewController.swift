//
//  ViewController.swift
//  Capstone_SSS
//
//  Created by Kang on 2022/03/26.
//

import UIKit
import PhotosUI //PHPicker 사용을 위한 import

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func addImage(_ sender: UIBarButtonItem) {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1 //선택할 수 있는 최대 asset 수
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
}


extension ViewController: PHPickerViewControllerDelegate {

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
    
        let itemProvider = results.first?.itemProvider
        
        if let itemProvider = itemProvider,
            itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in DispatchQueue.main.async {
                    self.imageView.image = image as? UIImage
                }
            }
            
        } else {
            // TODO: Handle empty results or item provider not being able load UIImage
            
        }
    }
}


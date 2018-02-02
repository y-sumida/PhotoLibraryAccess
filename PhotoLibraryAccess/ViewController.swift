//
//  ViewController.swift
//  PhotoLibraryAccess
//
//  Created by Yuki Sumida on 2018/02/01.
//  Copyright © 2018年 Yuki Sumida. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // PHPhotoLibraryを使う際に、NSPhotoLibraryUsageDescription を設定してないとクラッシュ
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized: print("authorized")
            case .denied: print("denied")
            case .notDetermined: print("NotDetermined")
            case .restricted: print("Restricted")
            }
        }

        // authorized なら自由に読み出せる
        let options = PHFetchOptions()
        let result = PHAsset.fetchAssets(with: .image, options: options)
        if let asset = result.firstObject {
            PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight), contentMode: .aspectFill, options: nil, resultHandler: {[unowned self] image, options in
                self.imageView.image = image
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tapSelectPhoto(_ sender: Any) {
        // iOS11では、UIImagePickerControllerで写真にアクセスするだけならユーザーのアクセス確認は出ない
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            self.present(picker, animated: true, completion: nil)
        }
    }
}

extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let _ = info[UIImagePickerControllerOriginalImage] as? UIImage {
            print("didFinishPickingMediaWithInfo")
        }
        self.dismiss(animated: true, completion: nil)
    }
}



//
//  ViewController.swift
//  PhotoLibraryAccess
//
//  Created by Yuki Sumida on 2018/02/01.
//  Copyright © 2018年 Yuki Sumida. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tapSelectPhoto(_ sender: Any) {
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



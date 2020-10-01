//
//  CameraViewController.swift
//  Unit5-Instagram
//
//  Created by Mariana Duarte on 9/27/20.
//  Copyright © 2020 Codepath. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var commentField: UITextField!
    
    @IBAction func submitButton(_ sender: Any) {
        let post = PFObject(className: "Post")
        
        post["caption"] = commentField.text!
        post["author"] = PFUser.current()!
        let imgData = ImageView.image!.pngData()
//        let file = PFFileObject(data: imgData!)
        let file = PFFileObject(name: "image.png", data: imgData!)
        post["img"] = file
        post.saveInBackground { (success, Error) in
            
            if success {
                self.dismiss(animated: true, completion: nil)
                print("saved")
            }
            else {
                print("error")
            }
        }
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
            
        }
        else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[ .editedImage] as! UIImage
        
        let size = CGSize(width: 400, height: 400)
        
        let scaledImg = image.af_imageScaled(to: size)
        
        ImageView.image = scaledImg
        
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

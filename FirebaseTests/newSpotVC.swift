//
//  newSpotVC.swift
//  FirebaseTests
//
//  Created by Aivars Meijers on 30.05.17.
//  Copyright © 2017. g. Aivars Meijers. All rights reserved.
//

import UIKit

class newSpotVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var saveSpot: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagePicker.delegate = self
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let myImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = myImage
        imagePicker.dismiss(animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func onCameraButton(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func onSaveButton(_ sender: Any) {
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

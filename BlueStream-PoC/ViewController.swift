//
//  ViewController.swift
//  BlueStream-PoC
//
//  Created by me on 1/12/18.
//  Copyright © 2018 Arizona State University. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{

//-------------------------------------------------------------------------------
// [Constructor Junk]
// (aka. ignore this unless you know what you're doing)
//-------------------------------------------------------------------------------
    @IBOutlet weak var selectedImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//-------------------------------------------------------------------------------
// End of 'Constructor Junk'
//-------------------------------------------------------------------------------

    
//-------------------------------------------------------------------------------
// [Internal Actions]
//
// Actions (ie. a, b, & c (below) are linked with corresponding buttons from Main.storyboard
//
// Functions linked these actions are implemented elsewhere.
//-------------------------------------------------------------------------------
    
    // a) Save Action (saveUse)
    // Provisions for saving user's images as JPEG files to their photo library.
    @IBAction func saveUse(_ sender: UIButton)
    {
        let imageData = UIImageJPEGRepresentation(selectedImage.image!, 0.6) // Float value = compression quality, may need to change
        let compressedJPEGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPEGImage!, nil, nil, nil)
        saveNotice() // Linked from 'Outside Functions' (below)
    }
    
    // b) Camera Action (cameraUse)
    // Provides access to the phone's camera, allowing pictures to be taken.
    @IBAction func cameraUse(_ sender: UIButton)
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        {
            let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.camera
                ;
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    // c) Library Access Action (photoLibUse)
    // Opens user's photo library, and provides access to iOS built-in editing tool(s).
    @IBAction func photoLibUse(_ sender: UIButton)
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary)
        {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
//-------------------------------------------------------------------------------
// End of 'Internal Actions'
//-------------------------------------------------------------------------------
    
    
//-------------------------------------------------------------------------------
// [Outside Functions]
//
// Functions here enable the usage of the actions seen previously.
//-------------------------------------------------------------------------------
    
    // Provides functionality needed for saving the image once it has been set as UIImage.
    
    /*
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!)
    {
        selectedImage.image! = image
        self.dismiss(animated: true, completion: nil);
    
    }
   */
    
   /**/
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImageView
        {
            selectedImage.contentMode = .scaleAspectFit
            selectedImage.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    /**/
    
    // Notifies the user that their photo was saved to the camera roll.
    func saveNotice()
    {
        let alertController = UIAlertController(title: "Image Saved", message: "Photo saved to your camera roll.", preferredStyle: .alert) // This is what appears in the pop-up message
        let defaultAction = UIAlertAction(title: "Got it", style: .default, handler: nil)
        alertController.addAction(defaultAction) // Creates the "Dismiss Button" in the pop-up
        present(alertController, animated: true, completion: nil) // What appears on the "Dismiss Button" within the pop-up
    }
    
//-------------------------------------------------------------------------------
// End of 'Outside Functions'
//-------------------------------------------------------------------------------
    
    
//-------------------------------------------------------------------------------
//End of File
//-------------------------------------------------------------------------------
}


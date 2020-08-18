//
//  ViewController.swift
//  Fiftygram
//
//  Created by Devon Ross on 8/12/20.
//  Copyright © 2020 CS50. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let context = CIContext()
    var original: UIImage?
    @IBOutlet var imageView: UIImageView!
    
    @IBAction func choosePhoto(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            navigationController?.present(picker, animated: true, completion: nil)
        }
    }
    

    @IBAction func applyBloom(){
        if original == nil {
            return
        }
        
        let filter = CIFilter(name:"CIBloom")
        filter?.setValue(1.0, forKey: kCIInputImageKey)
        filter?.setValue(3.0, forKey: kCIInputIntensityKey)
        filter?.setValue(5.0, forKey: kCIInputRadiusKey)
        display(filter: filter!)
        }
    
    
    
    @IBAction func applySepia(){
        if original == nil {
            return
        }
        let filter = CIFilter(name: "CISepiaTone")
        filter?.setValue(0.5, forKey: kCIInputIntensityKey)
        display(filter: filter!)
    }
    
    @IBAction func applyNoir(){
        if original == nil {
            return
        }
        let filter = CIFilter(name: "CIPhotoEffectNoir")
        display(filter: filter!)
    }
    
    @IBAction func applyVintage(){
        if original == nil {
            return
        }
        let filter = CIFilter(name: "CIPhotoEffectProcess")
        display(filter: filter!)
    }
    
    @IBAction func applyOriginal(){
        if original == nil {
            return
        }
            imageView.image = original
    }
    
    func display(filter: CIFilter) {
        filter.setValue(CIImage(image: original!), forKey: kCIInputImageKey)
        let output = filter.outputImage
        imageView.image = UIImage(cgImage: self.context.createCGImage(output!, from: output!.extent)!)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        navigationController?.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage]
            as? UIImage {
            imageView.image = image
            original = image
    }
            
    }
    @IBAction func savePhoto(){
        guard let image = imageView.image else {return}
        UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
        print("Button Works")
    }
}


//
//  CameraViewController.swift
//  BP
//
//  Created by Aleš Kůtek on 04.02.2021.
//
//  https://developer.apple.com/documentation/avfoundation/cameras_and_media_capture/avcam_building_a_camera_app
//

import Foundation
import UIKit
import AVKit


class CameraViewController : UIViewController, AVCapturePhotoCaptureDelegate {
    @IBOutlet weak var previewView: PreviewView!
    private var session = AVCaptureSession()
    
    private var photoOutput: AVCapturePhotoOutput!
    
    private var photoSettings: AVCapturePhotoSettings!

    override func viewDidLoad() {
        
        AVCaptureDevice.requestAccess(for: .video) { (Bool) in
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        startSesssion(position: .back)
    }
    
    func startSesssion(position: AVCaptureDevice.Position) {
        session = AVCaptureSession()
        
        previewView.videoPreviewLayer.session = session
        
        session.beginConfiguration()
        let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                  for: .video, position: position)
        guard
            let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice!),
            session.canAddInput(videoDeviceInput)
            else { return }
        session.addInput(videoDeviceInput)
        
        
        photoOutput = AVCapturePhotoOutput()
        guard session.canAddOutput(photoOutput) else { return }
        session.sessionPreset = .photo
        session.addOutput(photoOutput)
        session.commitConfiguration()
        
        session.startRunning()
        
        if let photoOutputConnection = self.photoOutput.connection(with: .video) {
            photoOutputConnection.videoOrientation = .portrait
            
            photoSettings = AVCapturePhotoSettings()

            // Capture HEIF photos when supported. Enable auto-flash and high-resolution photos.
            if  self.photoOutput.availablePhotoCodecTypes.contains(.hevc) {
                photoSettings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.hevc])
            }

            if videoDeviceInput.device.isFlashAvailable {
                photoSettings.flashMode = .auto
            }

            photoSettings.photoQualityPrioritization = .balanced
        }
    }
    @IBAction func frontCamera(_ sender: Any) {
        startSesssion(position: .front)
    }
    @IBAction func backCamera(_ sender: Any) {
        startSesssion(position: .back)
    }
    @IBAction func capture(_ sender: Any) {
        photoOutput.capturePhoto(with: photoSettings, delegate: self)
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
               if let uiImage = UIImage(data: imageData){
                DispatchQueue.main.async {
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "PhotoPreviewController") as! PhotoPreviewController
                    vc.image = uiImage
                    
                    self.present(vc, animated: true, completion: nil)
                }
               }
           }

    }
}

class PhotoPreviewController : UIViewController {
    var image: UIImage!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        imageView.image = image
    }
    
}

class PreviewView: UIView {
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
    /// Convenience wrapper to get layer as its statically known type.
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }
}

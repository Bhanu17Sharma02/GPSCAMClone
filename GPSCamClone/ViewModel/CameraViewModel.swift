//
//  SwiftUIView.swift
//  GPSCamClone
//
//  Created by Bhanu Sharma on 07/03/25.
//

import SwiftUI
import AVFoundation
import CoreLocation

class CameraViewModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate, CLLocationManagerDelegate {
    @Published var image: UIImage?
    @Published var location: CLLocationCoordinate2D?
     let captureSession = AVCaptureSession()
    private let photoOutput = AVCapturePhotoOutput()
    private var previewLayer: AVCaptureVideoPreviewLayer?
    let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        setupCamera()
        setupLocation()
    }
    
    private func setupCamera() {
        captureSession.sessionPreset = .photo
        guard let backCamera = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: backCamera) else { return }
        
        if captureSession.canAddInput(input) { captureSession.addInput(input) }
        if captureSession.canAddOutput(photoOutput) { captureSession.addOutput(photoOutput) }
    }
    
    private func setupLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func startSession() {
        if !captureSession.isRunning {
                self.captureSession.startRunning()
            
        }
    }
    
    func stopSession() {
        if captureSession.isRunning {
            captureSession.stopRunning()
        }
    }
    
    func capturePhoto() {
        let settings = AVCapturePhotoSettings()
        photoOutput.capturePhoto(with: settings, delegate: self)
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation(), let uiImage = UIImage(data: imageData) else { return }
        DispatchQueue.main.async {
            self.image = uiImage
            self.location = self.locationManager.location?.coordinate
            self.locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let newLocation = locations.last {
            location = newLocation.coordinate
        }
    }
}

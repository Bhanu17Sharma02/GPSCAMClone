//
//  Ui.swift
//  GPSCamClone
//
//  Created by Bhanu Sharma on 07/03/25.
//

import Foundation
import SwiftUI
import AVFoundation
import CoreLocation


struct CameraView: UIViewControllerRepresentable {
    let viewModel: CameraViewModel
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        viewModel.startSession()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: viewModel.captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = CGRect(x: UIScreen.main.bounds.minX, y: UIScreen.main.bounds.minY, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 210)
        
        viewController.view.layer.addSublayer(previewLayer)
        
        // Add L-Shaped Overlay
        
        let overlayView = LShapeOverlayView(frame: CGRect(x: UIScreen.main.bounds.minX, y: UIScreen.main.bounds.minY, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 200))
        overlayView.backgroundColor = .clear
        viewController.view.addSubview(overlayView)
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

class LShapeOverlayView: UIView {
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setStrokeColor(UIColor.white.cgColor)
        context.setLineWidth(4)
        
        let cornerLength: CGFloat = 30
        
        // Top Left
        context.move(to: CGPoint(x: 20, y: 20 + cornerLength))
        context.addLine(to: CGPoint(x: 20, y: 20))
        context.addLine(to: CGPoint(x: 20 + cornerLength, y: 20))
        
        // Top Right
        context.move(to: CGPoint(x: rect.width - 20 - cornerLength, y: 20))
        context.addLine(to: CGPoint(x: rect.width - 20, y: 20))
        context.addLine(to: CGPoint(x: rect.width - 20, y: 20 + cornerLength))
        
        // Bottom Left
        context.move(to: CGPoint(x: 20, y: rect.height - 20 - cornerLength))
        context.addLine(to: CGPoint(x: 20, y: rect.height - 20))
        context.addLine(to: CGPoint(x: 20 + cornerLength, y: rect.height - 20))
        
        // Bottom Right
        context.move(to: CGPoint(x: rect.width - 20 - cornerLength, y: rect.height - 20))
        context.addLine(to: CGPoint(x: rect.width - 20, y: rect.height - 20))
        context.addLine(to: CGPoint(x: rect.width - 20, y: rect.height - 20 - cornerLength))
        
        context.strokePath()
    }
}

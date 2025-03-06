//
//  FlashlightView.swift
//  GPSCamClone
//
//  Created by Bhanu Sharma on 07/03/25.
//

import SwiftUI
import AVFoundation

struct FlashlightView: View {
@State private var isFlashlightOn = false

var body: some View {
    VStack {
        Button(action: toggleFlashlight) {
            Image(systemName: isFlashlightOn ? "flashlight.on.fill" : "flashlight.off.fill")
                .font(.system(size: 30))
                .foregroundColor(isFlashlightOn ? .yellow : .white)
        }
        .padding()
    }
}

private func toggleFlashlight() {
    guard let device = AVCaptureDevice.default(for: .video), device.hasTorch else {
        print("Flashlight not available")
        return
    }

    do {
        try device.lockForConfiguration()
        device.torchMode = isFlashlightOn ? .off : .on
        isFlashlightOn.toggle()
        device.unlockForConfiguration()
    } catch {
        print("Error toggling flashlight: \(error)")
    }
}
}


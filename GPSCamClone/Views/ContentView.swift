//
//  ContentView.swift
//  GPSCamClone
//
//  Created by Bhanu Sharma on 06/03/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CameraViewModel()
    @State private var showCamera = false
    
    var body: some View {
        VStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: UIScreen.main.bounds.height - 280)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                if let location = viewModel.location {
                    Text("Latitude: \(location.latitude), Longitude: \(location.longitude)")
                        .padding()
                }
                
            }
            
            Text("Tap Down to See Camera Preview")
                .font(.headline)
                .fontWeight(.semibold)
            
          
            Button(action: {
                showCamera = true
                viewModel.locationManager.startUpdatingLocation()
            }) {
                Text("Open Camera")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .fullScreenCover(isPresented: $showCamera) {
                ZStack {
                    CameraView(viewModel: viewModel)
                    VStack{
                        
                        HStack{
                            FlashlightView()
                            
                            Spacer()
                            
                            Button(action: {}) {
                                HStack
                                {
                                    Image(systemName: "photo.on.rectangle.angled")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                    
                                    Text("Sample Image")
                                        .foregroundStyle(.white)
                                }
                                .background{
                                    Capsule()
                                        .stroke(lineWidth: 2)
                                        .frame(width: 150,height: 40)
                                    
                                }
                            }
                            .tint(.white)
                            
                            Spacer()
                            
                            Button(action: {
                                    
                                }) {
                                    Image(systemName: "gearshape.fill")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .tint(.white)
                                }
                                .padding(.trailing, 15)
                        }
                        .padding()
                        
                        Spacer()
                        
                        HStack{
                          Spacer()
                            
                            Button(action: {
                                    
                                }) {
                                    Image(systemName: "info.circle")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .tint(.white)
                                }
                                .padding(.trailing, 28)
                        }
                        .padding(.bottom, 150)
                        
                    }
                        
                      VStack {
                            Spacer()
                          
                            HStack{
                                
                                Image(systemName: "rectangle.fill")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .padding(.bottom, 50)
                                    .foregroundStyle(.gray)
                                
                                Spacer()
                                
                                Button(action: {
                                    viewModel.capturePhoto()
                                    showCamera = false
                                }) {
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 70, height: 70)
                                        .overlay(Circle().stroke(Color.gray, lineWidth: 3))
                                }
                                .padding(.bottom, 50)
                               
                                Spacer()
                                
                                Image(systemName: "photo.badge.plus")
                                    .resizable()
                                    .frame(width: 70, height: 60)
                                    .padding(.bottom, 50)
                            }

                        }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Geo Cam Clone")
    }
}

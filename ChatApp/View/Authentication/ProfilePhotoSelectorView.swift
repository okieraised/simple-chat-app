//
//  ProfilePhotoSelectorView.swift
//  ChatApp
//
//  Created by Tri Pham on 9/4/21.
//

import SwiftUI

struct ProfilePhotoSelectorView: View {
    @State private var ImagePickerPresented = false
    @State private var selectedImage: UIImage?
    @State private  var profileImage: Image?
//    @EnvironmentObject var viewModel: AuthViewModel
    @ObservedObject var viewModel = AuthViewModel()
    
    var body: some View {
        VStack {
            Button(action: { ImagePickerPresented.toggle() }, label: {
                if let profileImage = profileImage{
                    profileImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: 180, height: 180)
                        .clipShape(Circle())
                } else {
                    Image("INCOM.png")
                        .resizable()
                        .renderingMode(.template)
                        .scaledToFill()
                        .frame(width: 180, height: 180)
                        .clipped()
                        .padding(.top, 44)
                        .foregroundColor(.black)
                }
            })
            .sheet(isPresented: $ImagePickerPresented,
                   onDismiss: loadImage, content: {
                ImagePicker(image: $selectedImage)
            })
            
            Text(profileImage == nil ? "Select a profile photo" :
            "Great! Tap below to continue")
                .font(.system(size: 20, weight: .semibold))
            
            if let image = selectedImage {
                Button(action: {
                    viewModel.uploadProfileImage(image) // profileImage
                }, label: {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 340, height: 50)
                        .background(Color.blue)
                        .clipShape(Capsule())
                        .padding()

                })
                .shadow(color: .gray, radius: 10, x: 0.0, y: 0.0)
                .padding(.top, 24)
            }
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
    }
}



struct ProfilePhotoSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhotoSelectorView()
    }
}
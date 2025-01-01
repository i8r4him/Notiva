//
//  UserProfileView.swift
//  Notiva
//
//  Created by Ibrahim Abdullah
//

import SwiftUI

struct UserProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var userName = "Ibrahim Abdullah"
    @State private var isEditingName = false
    @State private var isImagePickerPresented = false
    
    var body: some View {
        Form {
            Section {
                HStack {
                    
                    Spacer()
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.accentColor, lineWidth: 2))
                        .onTapGesture {
                            isImagePickerPresented = true
                        }
                    Spacer()
                }
                .listRowBackground(Color.clear)
                .padding(.vertical)
                
                HStack {
                    Text("Name")
                    Spacer()
                    Text(userName)
                        .foregroundColor(.secondary)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    isEditingName = true
                }
                
                HStack {
                    Text("Username")
                    Spacer()
                    Text("@i8r4him")
                        .foregroundColor(.secondary)
                }
            }
            
            Section(header: Text("Stats")) {
                HStack {
                    Text("Level")
                    Spacer()
                    Text("Lv.1")
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("Awards")
                    Spacer()
                    Text("6")
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("Streak")
                    Spacer()
                    Text("3 days")
                        .foregroundColor(.secondary)
                }
            }
            
            Section {
                Button(role: .destructive) {
                    // TODO: Implement sign out
                } label: {
                    Text("Sign Out")
                        .foregroundColor(.red)
                }
            }
        }
        .sheet(isPresented: $isEditingName) {
            NavigationStack {
                Form {
                    TextField("Name", text: $userName)
                }
                .navigationTitle("Edit Name")
                .navigationBarItems(
                    trailing: Button("Done") { isEditingName = false }
                )
            }
        }
        .sheet(isPresented: $isImagePickerPresented) {
            Text("Image Picker Goes Here") // TODO: Implement image picker
        }
    }
}

#Preview {
    NavigationStack {
        UserProfileView()
    }
}


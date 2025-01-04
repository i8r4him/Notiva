//
//  UserProfileView.swift
//  Notiva
//
//  Created by Ibrahim Abdullah
//

import SwiftUI
import SwiftData
import PhotosUI

struct UserProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    // Fetch any users in the database (should only be 0 or 1)
    @Query private var users: [User]
    
    // For editing user's name
    @State private var userName = ""
    @State private var isEditingName = false
    
    // For image picker
    @State private var isImagePickerPresented = false
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var userImage: Image? = nil
    
    /// This computed property guarantees exactly one User.
    /// If none exist, we create one on-the-fly.
    private var user: User {
        // If we already have at least one user, return it
        if let existingUser = users.first {
            return existingUser
        }
        
        // Otherwise, create a new user and save immediately
        let newUser = User(
            name: "Default User",
            level: 1,
            awards: 0,
            streak: 0
        )
        context.insert(newUser)
        try? context.save()
        
        return newUser
    }
    
    private var currentUser: User? { users.first }
    
    var body: some View {
        Form {
            // MARK: - User Image
            if let user = currentUser {
                Section {
                    HStack {
                        Spacer()
                        PhotosPicker(selection: $selectedItem, matching: .images) {
                            Group {
                                if let userImage {
                                    userImage
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                } else {
                                    Image(systemName: "person.circle.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                }
                            }
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color.accentColor, lineWidth: 2)
                            )
                        }
                        Spacer()
                    }
                    .listRowBackground(Color.clear)
                    .padding(.vertical)
                }
                
                // MARK: - Name (Editable)
                Section(header: Text("Name")) {
                    HStack {
                        Text("Name")
                        Spacer()
                        Text(user.name)
                            .foregroundColor(.secondary)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        userName = user.name
                        isEditingName = true
                    }
                }
                
                // MARK: - Stats (Read-Only)
                Section(header: Text("Stats")) {
                    HStack {
                        Text("Level")
                        Spacer()
                        Text("Lv.\(user.level)")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Awards")
                        Spacer()
                        Text("\(user.awards)")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Streak")
                        Spacer()
                        Text("\(user.streak) days")
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .onChange(of: selectedItem) { oldItem, newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                    user.imageData = data
                    try? context.save()
                    if let uiImage = UIImage(data: data) {
                        userImage = Image(uiImage: uiImage)
                    }
                }
            }
        }
        .onAppear {
            if let imageData = user.imageData,
               let uiImage = UIImage(data: imageData) {
                userImage = Image(uiImage: uiImage)
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        
        // MARK: - Edit Name Sheet
        .sheet(isPresented: $isEditingName) {
            NavigationStack {
                Form {
                    TextField("Name", text: $userName)
                        .textInputAutocapitalization(.words)
                        .disableAutocorrection(true)
                }
                .navigationTitle("Edit Name")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                            if !userName.isEmpty {
                                user.name = userName
                                try? context.save()
                            }
                            isEditingName = false
                        }
                    }
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            isEditingName = false
                        }
                    }
                }
            }
            .presentationDetents([.height(150)])
        }
        
        // MARK: - Image Picker Sheet
        .sheet(isPresented: $isImagePickerPresented) {
            Text("Image Picker Goes Here") // TODO: Implement actual image picker
        }
    }
}

#Preview {
    NavigationStack {
        UserProfileView()
            .modelContainer(for: User.self, inMemory: true)
    }
}

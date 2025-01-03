//
//  UserProfileView.swift
//  Notiva
//
//  Created by Ibrahim Abdullah
//

import SwiftUI
import SwiftData

struct UserProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    // Fetch any users in the database (should only be 0 or 1)
    @Query private var users: [User]
    
    // For editing the user's name
    @State private var userName = ""
    @State private var isEditingName = false
    
    // For image picker
    @State private var isImagePickerPresented = false
    
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
    
    var body: some View {
        Form {
            // MARK: - User Image
            Section {
                HStack {
                    Spacer()
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.accentColor, lineWidth: 2)
                        )
                        .onTapGesture {
                            isImagePickerPresented = true
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
                    // Set up the text field with the current user name
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
                            user.name = userName
                            try? context.save()
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
            .modelContainer(for: User.self)
    }
}

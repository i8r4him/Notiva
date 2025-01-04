//
//  ProfileHeaderView.swift
//  Notiva
//
//  Created by Ibrahim Abdullah on 31.12.24.
//

import SwiftUI
import SwiftData
import PhotosUI

struct ProfileHeaderView: View {
    // Remove Query and use passed user
    var user: User
    @Environment(\.modelContext) private var context
    
    // State for UI
    @State private var userImage: Image? = nil
    @State private var isImagePickerPresented = false
    @State private var isEditingName = false
    @State private var tempName = ""
    @State private var showLevelDetails = false
    @State private var showAwardsDetails = false
    @State private var showStreakDetails = false
    @State private var selectedItem: PhotosPickerItem? = nil
    
    var body: some View {
        // Remove default padding from HStack
        HStack(alignment: .center, spacing: 4) {
            // Profile Image with PhotosPicker
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
            .frame(width: 65, height: 65)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.accentColor, lineWidth: 1.5))
            .overlay(alignment: .bottomTrailing) {
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    Image(systemName: "pencil.circle.fill")
                        .symbolRenderingMode(.hierarchical)
                        .foregroundColor(.accentColor)
                        .font(.system(size: 20))
                        .background(Color(uiColor: .systemBackground))
                        .clipShape(Circle())
                }
                .offset(x: 8, y: 8)
            }
            
            // User Info and Stats
            VStack(alignment: .leading, spacing: 6) {
                // User Info
                HStack(spacing: 6) {
                    Text(user.name)
                        .font(.headline)
                        .fontWeight(.medium)
                    
                    Image(systemName: "pencil.circle.fill")
                        .foregroundColor(.accentColor)
                        .font(.system(size: 16))
                        .onTapGesture {
                            tempName = user.name
                            isEditingName = true
                        }
                }
                
                // Stats Row
                HStack(spacing: 16) {
                    // Level
                    CompactStatView(
                        icon: "leaf.fill",
                        iconColor: .green,
                        value: "Lv.\(user.level)",
                        action: { showLevelDetails = true }
                    )
                    
                    // Awards
                    CompactStatView(
                        icon: "star.fill",
                        iconColor: .yellow,
                        value: "\(user.awards)",
                        action: { showAwardsDetails = true }
                    )
                    
                    // Streak
                    CompactStatView(
                        icon: "flame.fill",
                        iconColor: .orange,
                        value: "\(user.streak)",
                        action: { showStreakDetails = true }
                    )
                }
                .font(.subheadline)
            }
            .padding(.leading, 8)
            
            Spacer(minLength: 0) // Update Spacer to have minimum length of 0
            
            // Premium badge if needed
            if user.isPremium {
                Image(systemName: "crown.fill")
                    .foregroundColor(.yellow)
                    .font(.system(size: 18))
                    .opacity(0.7)
                    .padding(.trailing, 4) // Add small trailing padding
            }
        }
        .padding(.vertical, 8) // Keep only vertical padding
        .frame(maxWidth: .infinity) // Ensure full width
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
            // Load existing image
            if let imageData = user.imageData,
               let uiImage = UIImage(data: imageData) {
                userImage = Image(uiImage: uiImage)
            }
        }
        .sheet(isPresented: $isEditingName) {
            NavigationStack {
                Form {
                    TextField("Name", text: $tempName)
                        .textInputAutocapitalization(.words)
                        .disableAutocorrection(true)
                }
                .navigationTitle("Edit Name")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                            if !tempName.isEmpty {
                                user.name = tempName
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
        .sheet(isPresented: $showLevelDetails) {
            Text("Level Details View") // TODO: Implement level details
        }
        .sheet(isPresented: $showAwardsDetails) {
            Text("Awards Details View") // TODO: Implement awards details
        }
        .sheet(isPresented: $showStreakDetails) {
            Text("Streak Details View") // TODO: Implement streak details
        }
    }
}

// CompactStatView remains the same
struct CompactStatView: View {
    let icon: String
    let iconColor: Color
    let value: String
    let action: () -> Void
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .foregroundColor(iconColor)
                .font(.system(size: 14))
            Text(value)
                .fontWeight(.medium)
        }
        .onTapGesture(perform: action)
    }
}

#Preview {
    ProfileHeaderView(user: User())
}

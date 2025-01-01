//
//  ProfileHeaderView.swift
//  Notiva
//
//  Created by Ibrahim Abdullah on 31.12.24.
//

import SwiftUI

struct ProfileHeaderView: View {
    @State private var userImage: Image? = nil
    @State private var isImagePickerPresented = false
    @State private var isEditingName = false
    @State private var userName = "Ibrahim Abdullah"
    @State private var showLevelDetails = false
    @State private var showAwardsDetails = false
    @State private var showStreakDetails = false
    
    var body: some View {
        // Remove default padding from HStack
        HStack(alignment: .center, spacing: 4) {
            // Profile Image
            (userImage ?? Image(systemName: "person.circle.fill"))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 65, height: 65)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.accentColor, lineWidth: 1.5))
                .onTapGesture {
                    isImagePickerPresented = true
                }
            
            // User Info and Stats
            VStack(alignment: .leading, spacing: 6) {
                // User Info
                HStack(spacing: 6) {
                    Text(userName)
                        .font(.headline)
                        .fontWeight(.medium)
                    
                    Image(systemName: "pencil.circle.fill")
                        .foregroundColor(.accentColor)
                        .font(.system(size: 16))
                        .onTapGesture {
                            isEditingName = true
                        }
                }
                
                // Stats Row
                HStack(spacing: 16) {
                    // Level
                    CompactStatView(icon: "leaf.fill",
                                  iconColor: .green,
                                  value: "Lv.1",
                                  action: { showLevelDetails = true })
                    
                    // Awards
                    CompactStatView(icon: "star.fill",
                                  iconColor: .yellow,
                                  value: "6",
                                  action: { showAwardsDetails = true })
                    
                    // Streak
                    CompactStatView(icon: "flame.fill",
                                  iconColor: .orange,
                                  value: "3",
                                  action: { showStreakDetails = true })
                }
                .font(.subheadline)
            }
            .padding(.leading, 8)
            
            Spacer(minLength: 0) // Update Spacer to have minimum length of 0
            
            // Premium badge if needed
            Image(systemName: "crown.fill")
                .foregroundColor(.yellow)
                .font(.system(size: 18))
                .opacity(0.7)
                .padding(.trailing, 4) // Add small trailing padding
        }
        .padding(.vertical, 8) // Keep only vertical padding
        .frame(maxWidth: .infinity) // Ensure full width
        // Sheets remain the same
        .sheet(isPresented: $isImagePickerPresented) {
            Text("Image Picker Goes Here") // TODO: Implement image picker
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
    ProfileHeaderView()
        .padding()
}

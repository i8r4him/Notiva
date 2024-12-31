//
//  ProfileHeaderView.swift
//  Notiva
//
//  Created by Ibrahim Abdullah on 31.12.24.
//

import SwiftUI

struct ProfileHeaderView: View {
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .foregroundColor(.gray)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Ibrahim Abdullah")
                    .font(.headline)
                
                HStack(spacing: 8) {
                    Label("Lv.1", systemImage: "leaf.fill")
                        .labelStyle(.iconOnly)
                        .foregroundColor(.green)
                    
                    Label("6 Awards", systemImage: "star.fill")
                        .labelStyle(.iconOnly)
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    ProfileHeaderView()
}

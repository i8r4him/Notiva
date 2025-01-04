//
//  EditSubjectView.swift
//  Notiva
//
//  Created by Ibrahim Abdullah on 03.01.25.
//

import SwiftUI
import SwiftData

struct EditSubjectView: View {
    // Environment variables
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    
    // Bindable subject to edit
    @Bindable var subject: Subject
    
    // State for color picker
    @State private var selectedColor: Color
    
    // Initialize with current color
    init(subject: Subject) {
        self.subject = subject
        _selectedColor = State(initialValue: subject.colorValue)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Subject Name", text: $subject.name)
                    
                    Stepper("Credits: \(subject.credit)", value: $subject.credit, in: 0...30)
                }
                
                Section {
                    Picker("Type", selection: $subject.type) {
                        ForEach(Type.allCases, id: \.self) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                }
                
                Section {
                    ColorPicker("Color", selection: $selectedColor)
                }
            }
            .navigationTitle("Edit Subject")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        // Update color
                        if let hexColor = selectedColor.toHex() {
                            subject.color = hexColor
                        }
                        try? context.save()
                        dismiss()
                    }
                }
            }
        }
    }
}

// End of file. No additional code.

//
//  AddSubjectView.swift
//  Notiva
//
//  Created by Ibrahim Abdullah on 03.01.25.
//

import SwiftUI
import SwiftData

struct AddSubjectView: View {
    // Environment variables
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    
    // Major reference
    let major: Major
    
    // State variables
    @State private var name = ""
    @State private var creditText = ""
    @State private var selectedType = Type.pflicht
    @State private var selectedColor = Color.blue
    
    /// Custom binding for credit text field that ensures only numeric input
    private var creditBinding: Binding<String> {
        Binding(
            get: { creditText },
            set: { newValue in
                let filtered = newValue.filter { $0.isNumber }
                creditText = filtered
            }
        )
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Subject Name", text: $name)
                    TextField("Credits", text: creditBinding)
                        .keyboardType(.numberPad)
                }
                
                Section {
                    Picker("Type", selection: $selectedType) {
                        ForEach(Type.allCases, id: \.self) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                }
                
                Section {
                    ColorPicker("Color", selection: $selectedColor)
                }
            }
            .navigationTitle("Add Subject")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if let credits = Int(creditText), !name.isEmpty {
                            let subject = Subject(
                                name: name,
                                credit: credits,
                                color: selectedColor.toHex() ?? "#007AFF",
                                type: selectedType,
                                major: major
                            )
                            context.insert(subject)
                            dismiss()
                        }
                    }
                    .disabled(name.isEmpty || creditText.isEmpty)
                }
            }
        }
    }
}

#Preview {
    AddSubjectView(major: Major())
}

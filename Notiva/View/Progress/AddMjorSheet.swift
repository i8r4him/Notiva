//
//  AddMjorSheet.swift
//  Notiva
//
//  Created by Ibrahim Abdullah on 03.01.25.
//

import SwiftUI
import SwiftData

struct AddMjorSheet: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var majorName = ""
    @State private var creditText = ""
    
    /// Custom binding for credit text field that ensures only numeric input
    /// - Returns: A binding that filters non-numeric characters from the input
    /// Usage:
    /// - Gets the current value from creditText
    /// - When setting new value, filters out any non-numeric characters
    /// - Updates creditText with only the numeric characters
    private var creditBinding: Binding<String> {
        Binding(
            get: { creditText },  // Return current value
            set: { newValue in
                // Filter out non-numeric characters and update creditText
                let filtered = newValue.filter { $0.isNumber }
                creditText = filtered
            }
        )
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Major Name", text: $majorName)
                    // Use creditBinding to ensure numeric-only input
                    TextField("Required Credits", text: creditBinding)
                        .keyboardType(.numberPad)
                }
            }
            .navigationTitle("Add Major")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        // 1. Try to convert creditText to an integer and check if majorName is not empty
                        if let credits = Int(creditText), !majorName.isEmpty {
                            // 2. Create a new Major instance with the entered values
                            let major = Major(name: majorName, credit: credits)
                            // 3. Insert the new major into SwiftData context
                            context.insert(major)
                            // 4. Dismiss the sheet
                            dismiss()
                        }
                    }
                    // 5. Disable the button if either field is empty
                    .disabled(majorName.isEmpty || creditText.isEmpty)
                }
            }
        }
    }
}

#Preview {
    AddMjorSheet()
}

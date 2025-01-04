//
//  ProgressView.swift
//  Notiva
//
//  Created by Ibrahim Abdullah on 30.12.24.
//

import SwiftUI
import SwiftData
import Charts

struct ProgressView: View {
    
    @Environment(\.modelContext) private var context
    
    @Query private var majors: [Major]
    
    // Manage sheets
    @State private var showingAddMajor = false
    @State private var showingAddSubject = false
    
    @State private var showingEditSubject = false
    @State private var selectedSubject: Subject? = nil

    
    // MARK: - Sorting
    enum SortOption {
        case alphabetical
        case creditDescending
        case type
    }
    
    @State private var sortOption: SortOption = .alphabetical
    
    var body: some View {
        NavigationStack {
            Group {
                if majors.isEmpty {
                    // MARK: - No Major
                    ContentUnavailableView {
                        Label("No Major Added", systemImage: "graduationcap.fill")
                    } description: {
                        Text("Add your major to track your academic progress")
                    } actions: {
                        Button(action: { showingAddMajor.toggle() }) {
                            Label("Add Major", systemImage: "plus.circle.fill")
                        }
                        .buttonStyle(.bordered)
                    }
                    
                } else if let major = majors.first {
                    // MARK: - Major Exists but No Subjects
                    if major.subjects.isEmpty {
                        ContentUnavailableView {
                            Label("No Subjects Added", systemImage: "books.vertical.fill")
                        } description: {
                            Text("Add subjects to \(major.name)")
                        } actions: {
                            Button(action: { showingAddSubject.toggle() }) {
                                Label("Add Subject", systemImage: "plus.circle.fill")
                            }
                            .buttonStyle(.bordered)
                        }
                        
                    } else {
                        // MARK: - Show Subject List & Chart
                        List {
                            Section {
                                ForEach(sortedSubjects(for: major)) { subject in
                                    HStack(spacing: 16) {
                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(subject.colorValue)
                                            .frame(width: 5, height: 45)
                                        
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(subject.name)
                                                .font(.headline)
                                            
                                            Text(subject.type.rawValue)
                                                .font(.caption)
                                                .foregroundStyle(.secondary)
                                        }
                                        
                                        Spacer()
                                        
                                        // Credits label
                                        Text("\(subject.credit)")
                                            .font(.title3.bold())
                                            + Text(" CP")
                                                .font(.caption2.bold())
                                                .baselineOffset(8)
                                                .foregroundStyle(.secondary)
                                    }
                                    .padding(.vertical, 4)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        withAnimation {
                                            selectedSubject = subject
                                            showingEditSubject = true
                                        }
                                    }
                                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                        Button(role: .destructive) {
                                            withAnimation {
                                                major.subjects.removeAll { $0.id == subject.id }
                                                context.delete(subject)
                                            }
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                    }
                                }
                                .onDelete { indexSet in
                                    // Delete from the sorted array
                                    let subjects = sortedSubjects(for: major)
                                    for index in indexSet {
                                        let subject = subjects[index]
                                        context.delete(subject)
                                    }
                                }
                            } header: {
                                VStack(spacing: 20) {
                                    // Animate chart whenever 'sortOption' changes
                                    Chart {
                                        ForEach(sortedSubjects(for: major)) { subject in
                                            SectorMark(
                                                angle: .value("Credits", subject.credit),
                                                innerRadius: .ratio(0.6),
                                                angularInset: 1
                                            )
                                            .cornerRadius(5)
                                            .foregroundStyle(subject.colorValue)
                                        }
                                        
                                        let remaining = major.credit - major.earnedCredits
                                        if remaining > 0 {
                                            SectorMark(
                                                angle: .value("Remaining", remaining),
                                                innerRadius: .ratio(0.6),
                                                angularInset: 1
                                            )
                                            .cornerRadius(5)
                                            .foregroundStyle(Color.gray.opacity(0.3))
                                        }
                                    }
                                    .chartLegend(position: .bottom, alignment: .center)
                                    .chartYScale(domain: 0...Double(major.credit))
                                    .frame(height: 200)
                                    // Add animation tied to sortOption here:
                                    .animation(.easeInOut, value: sortOption)
                                    
                                    // Credits summary section
                                    HStack(spacing: 16) {
                                        // Earned credits (left)
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text("Earned")
                                                .font(.caption)
                                                .fontWeight(.medium)
                                                .foregroundStyle(.secondary)
                                            
                                            HStack(alignment: .lastTextBaseline, spacing: 4) {
                                                Text("\(major.earnedCredits)")
                                                    .font(.title2)
                                                    .fontWeight(.bold)
                                                Text("CP")
                                                    .font(.caption)
                                                    .fontWeight(.medium)
                                                    .foregroundStyle(.secondary)
                                            }
                                        }
                                        
                                        // Simple dividing line
                                        Divider()
                                            .frame(height: 28)
                                        
                                        // Remaining credits (middle)
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text("Remaining")
                                                .font(.caption)
                                                .fontWeight(.medium)
                                                .foregroundStyle(.secondary)
                                            
                                            HStack(alignment: .lastTextBaseline, spacing: 4) {
                                                Text("\(major.credit - major.earnedCredits)")
                                                    .font(.title2)
                                                    .fontWeight(.bold)
                                                Text("CP")
                                                    .font(.caption)
                                                    .fontWeight(.medium)
                                                    .foregroundStyle(.secondary)
                                            }
                                        }
                                        
                                        // Simple dividing line
                                        Divider()
                                            .frame(height: 28)
                                        
                                        // Total credits (right)
                                        VStack(alignment: .trailing, spacing: 2) {
                                            Text("Total")
                                                .font(.caption)
                                                .fontWeight(.medium)
                                                .foregroundStyle(.secondary)
                                            
                                            HStack(alignment: .lastTextBaseline, spacing: 4) {
                                                Text("\(major.credit)")
                                                    .font(.title2)
                                                    .fontWeight(.bold)
                                                Text("CP")
                                                    .font(.caption)
                                                    .fontWeight(.medium)
                                                    .foregroundStyle(.secondary)
                                            }
                                        }
                                    }
                                }
                                .textCase(nil)
                            }
                        }
                        .listStyle(.plain)
                        .toolbar {
                            // Filter Menu on the Leading Side
                            ToolbarItem(placement: .topBarLeading) {
                                Menu {
                                    Button("Alphabetical") {
                                        withAnimation(.easeInOut) {
                                            sortOption = .alphabetical
                                        }
                                    }
                                    Button("Credit") {
                                        withAnimation(.easeInOut) {
                                            sortOption = .creditDescending
                                        }
                                    }
                                    Button("Type") {
                                        withAnimation(.easeInOut) {
                                            sortOption = .type
                                        }
                                    }
                                } label: {
                                    Image(systemName: "line.3.horizontal.decrease.circle")
                                }
                            }

                            // Add Button on the Trailing Side
                            ToolbarItem(placement: .topBarTrailing) {
                                Button(action: { showingAddSubject.toggle() }) {
                                    Image(systemName: "plus")
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Progress")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showingEditSubject, onDismiss: { selectedSubject = nil }) {
                if let subject = selectedSubject {
                    EditSubjectView(subject: subject)
                        .presentationDetents([.medium])
                        .interactiveDismissDisabled()
                }
            }
            .sheet(isPresented: $showingAddMajor) {
                AddMjorSheet()
                    .presentationDetents([.medium])
            }
            .sheet(isPresented: $showingAddSubject) {
                if let major = majors.first {
                    AddSubjectView(major: major)
                        .presentationDetents([.medium])
                }
            }
        }
    }
    
    // MARK: - Sorted Subjects Helper
    private func sortedSubjects(for major: Major) -> [Subject] {
        switch sortOption {
        case .alphabetical:
            return major.subjects.sorted { $0.name < $1.name }
        case .creditDescending:
            return major.subjects.sorted { $0.credit > $1.credit }
        case .type:
            let typeOrder: [String: Int] = [
                "Pflicht": 0,
                "Wahlpflicht": 1,
                "Praktikum": 2,
                "Other": 3
            ]
            return major.subjects.sorted { lhs, rhs in
                typeOrder[lhs.type.rawValue, default: 999] < typeOrder[rhs.type.rawValue, default: 999]
            }
        }
    }
}

// MARK: - Preview Provider with Sample Data
struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        // Create sample container and data
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Major.self, configurations: config)
        
        // Create sample major
        let sampleMajor = Major(name: "Computer Science", credit: 180)
        container.mainContext.insert(sampleMajor)
        
        // Add sample subjects
        let subjects: [(String, Int, String, Type)] = [
            ("Algorithms", 12, "#007AFF", .pflicht),
            ("Database Systems", 8, "#FF3B30", .wahlpflicht),
            ("Software Engineering", 6, "#34C759", .pflicht),
            ("Web Development", 6, "#5856D6", .praktikum)
        ]
        
        for (name, credit, color, type) in subjects {
            let subject = Subject(
                name: name,
                credit: credit,
                color: color,
                type: type,
                major: sampleMajor
            )
            container.mainContext.insert(subject)
            sampleMajor.subjects.append(subject)
        }
        
        // Return preview with sample data
        return NavigationStack {
            ProgressView()
        }
        .modelContainer(container)
    }
}

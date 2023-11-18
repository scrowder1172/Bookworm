//
//  SwiftDataExample.swift
//  Bookworm
//
//  Created by SCOTT CROWDER on 11/17/23.
//

import SwiftUI
import SwiftData

struct SwiftDataExample: View {
    
    @Query var students: [Student]
    
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack {
            Text("Students")
            List(students) { student in
                Text(student.name)
            }
            .navigationTitle("Classroom")
            .toolbar {
                Button("+Students") {
                    let firstNames: [String] = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                    let lastNames: [String] = ["Granger", "Lovegood", "Potter", "Weasley"]
                    
                    let chosenFirstName: String = firstNames.randomElement()!
                    let chosenLastName: String = lastNames.randomElement()!
                    
                    let student = Student(name: "\(chosenFirstName) \(chosenLastName)")
                    modelContext.insert(student)
                }
            }
            .frame(height: 300)
            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            .padding(.horizontal)
        }
    }
}

@Model
class Student {
    var id: UUID = UUID()
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

#Preview {
    SwiftDataExample()
}

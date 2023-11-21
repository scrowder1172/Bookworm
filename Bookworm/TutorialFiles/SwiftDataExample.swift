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
    @Query var teachers: [Teacher]
    
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack {
            Text("Teachers")
            List {
                ForEach(teachers) { teacher in
                    Text(teacher.name)
                }
                .onDelete(perform: deleteTeacher)
            }
            .navigationTitle("Classroom")
            .toolbar {
                Button("+Teachers", systemImage: "person.circle.fill") {
                    let firstNames: [String] = ["Joe", "Bob", "Gary", "Tina", "Margie"]
                    let lastNames: [String] = ["Smith", "Jones", "Davis", "Thompson"]
                    
                    let chosenFirstName: String = firstNames.randomElement()!
                    let chosenLastName: String = lastNames.randomElement()!
                    
                    let teacher = Teacher(name: "\(chosenFirstName) \(chosenLastName)")
                    modelContext.insert(teacher)
                }
            }
            .frame(height: 300)
            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            .padding(.horizontal)
            Text("Students")
            List {
                ForEach(students) { student in
                    Text(student.name)
                }
                .onDelete(perform: deleteStudent)
            }
            .navigationTitle("Classroom")
            .toolbar {
                Button("+Students", systemImage: "person.3") {
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
    
    func deleteTeacher(at offsets: IndexSet) {
        for offset in offsets {
            let teacher = teachers[offset]
            modelContext.delete(teacher)
        }
    }
    
    func deleteStudent(at offsets: IndexSet) {
        for offset in offsets {
            let student = students[offset]
            modelContext.delete(student)
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

@Model
class Teacher {
    var id: UUID = UUID()
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

#Preview {
    SwiftDataExample()
}

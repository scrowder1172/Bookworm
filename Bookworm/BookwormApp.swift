//
//  BookwormApp.swift
//  Bookworm
//
//  Created by SCOTT CROWDER on 11/17/23.
//

import SwiftUI
import SwiftData

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Book.self, Student.self, Teacher.self])
    }
}

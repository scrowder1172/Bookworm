//
//  AddBookView.swift
//  Bookworm
//
//  Created by SCOTT CROWDER on 11/20/23.
//

import SwiftUI

enum Genre: String, Identifiable, CaseIterable {
    var id: String { self.rawValue }
    
    case fantasy = "Fantasy"
    case horror = "Horror"
    case kids = "Kids"
    case mystery = "Mystery"
    case poetry = "Poetry"
    case romance = "Romance"
    case thriller = "Thriller"
    
}

struct AddBookView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var rating: Int = 3
    @State private var review: String = ""
    
    @State private var genre: Genre = .fantasy
    
    @State private var formMissingData: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(Genre.allCases) {genre in
                            Text(genre.rawValue).tag(genre)
                        }
                    }
                }
                
                Section("Write a review") {
                    TextEditor(text: $review)
                    
                    Picker("Rating", selection: $rating) {
                        ForEach(0..<6) {
                            Text(String($0))
                        }
                    }
                    
                    RatingView(rating: $rating)
                }
                
                Section {
                    Button("Save") {
                        if validateForm() {
                            let newBook = Book(title: title, author: author, genre: genre.rawValue, review: review, rating: rating)
                            modelContext.insert(newBook)
                            dismiss()
                        } else {
                            formMissingData = true
                        }
                    }
                }
            }.navigationTitle("Add Book")
                .alert("Form Incomplete", isPresented: $formMissingData) {
                    Button("OK") {}
                } message: {
                    Text("Please complete all fields")
                }
        }
    }
    
    func validateForm() -> Bool {
        guard title.isEmpty == false else {return false}
        guard author.isEmpty == false else {return false}
        guard review.isEmpty == false else {return false}
        
        return true
    }
}

#Preview {
    AddBookView()
}

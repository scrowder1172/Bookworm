//
//  ContentView.swift
//  Bookworm
//
//  Created by SCOTT CROWDER on 11/17/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query(sort: [
        SortDescriptor(\Book.rating, order: .reverse),
        SortDescriptor(\Book.author),
        SortDescriptor(\Book.title)
    ]) var books: [Book]
    
    @Query(filter: #Predicate<Book> { $0.author.contains("Stephen")},
        sort: [
        SortDescriptor(\Book.rating, order: .reverse),
        SortDescriptor(\Book.author),
        SortDescriptor(\Book.title)
    ]) var stephenBooks: [Book]
    
    @State private var showingAddScreen: Bool = false
    
    @State private var showingStudents: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section("Stephen Books") {
                    ForEach(stephenBooks) {book in
                        NavigationLink(value: book) {
                            HStack {
                                EmojiRatingView(rating: book.rating)
                                
                                VStack(alignment: .leading) {
                                    Text(book.title)
                                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                        .foregroundStyle(book.rating == 1 ? Color.red : Color.blue)
                                    Text(book.author)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteStephensBooks)
                }
                
                Section("All Books") {
                    ForEach(books) {book in
                        NavigationLink(value: book) {
                            HStack {
                                EmojiRatingView(rating: book.rating)
                                
                                VStack(alignment: .leading) {
                                    Text(book.title)
                                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                        .foregroundStyle(book.rating == 1 ? Color.red : Color.blue)
                                    Text(book.author)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteBooks)
                }
            }
            .navigationTitle("Bookworm")
            .navigationDestination(for: Book.self) { book in
                BookDetailview(book: book)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Book", systemImage: "plus") {
                        showingAddScreen.toggle()
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
            }
        }
        Button("See Students") {
            showingStudents = true
        }
        .sheet(isPresented: $showingStudents) {
            SwiftDataExample()
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            modelContext.delete(book)
        }
    }
    
    func deleteStephensBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = stephenBooks[offset]
            modelContext.delete(book)
        }
    }
}

#Preview {
    ContentView()
}

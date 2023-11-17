//
//  TextEditorExample.swift
//  Bookworm
//
//  Created by SCOTT CROWDER on 11/17/23.
//

import SwiftUI

struct TextEditorExample: View {
    
    @State private var textFieldText: String = ""
    @State private var textEditorText: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("default text", text: $textFieldText, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                TextEditor(text: $textEditorText)
                    .border(.black)
            }
            .navigationTitle("TextEditor vs TextField")
        }
    }
}

#Preview {
    TextEditorExample()
}

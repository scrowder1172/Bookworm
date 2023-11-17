//
//  BindingExample.swift
//  Bookworm
//
//  Created by SCOTT CROWDER on 11/17/23.
//

import SwiftUI

struct BindingExample: View {
    @State private var toggleMe: Bool = false
    
    
    var body: some View {
        VStack {
            Toggle("Toggle Me", isOn: $toggleMe)
            
            Rectangle()
                .frame(width: 200, height: 1)
                .padding(.vertical)
            
            PushButton(isOn: $toggleMe, title: "Remember Me")
            
            Rectangle()
                .frame(width: 200, height: 1)
                .padding(.vertical)
            
            BadPushButton(isOn: toggleMe, title: "Don't Remember Me")
            
        }
        .padding(.horizontal)
    }
}

struct PushButton: View {
    @Binding var isOn: Bool
    let title: String
    
    var onColors: [Color] = [Color.red, Color.yellow]
    var offColors: [Color] = [Color(white: 0.6), Color(white: 0.4)]
    
    var body: some View {
        Button(title) {
            isOn.toggle()
        }
        .padding()
        .background(LinearGradient(colors: isOn ? onColors : offColors, startPoint: .top, endPoint: .bottom))
        .foregroundStyle(.white)
        .clipShape(.capsule)
        .shadow(radius: isOn ? 0 : 5)
    }
}

struct BadPushButton: View {
    @State var isOn: Bool
    let title: String
    
    var onColors: [Color] = [Color.red, Color.yellow]
    var offColors: [Color] = [Color(white: 0.6), Color(white: 0.4)]
    
    var body: some View {
        Button(title) {
            isOn.toggle()
        }
        .padding()
        .background(LinearGradient(colors: isOn ? onColors : offColors, startPoint: .top, endPoint: .bottom))
        .foregroundStyle(.white)
        .clipShape(.capsule)
        .shadow(radius: isOn ? 0 : 5)
    }
}

#Preview {
    BindingExample()
}

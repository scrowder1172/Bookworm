//
//  RatingView.swift
//  Bookworm
//
//  Created by SCOTT CROWDER on 11/20/23.
//

import SwiftUI

struct RatingView: View {
    
    @Binding var rating: Int
    
    var label: String = ""
    
    var maximumRating: Int = 5
    
    var offImage: Image?
    var onImage: Image = Image(systemName: "star.fill")
    
    var offColor: Color = Color.gray
    var onColor: Color = Color.yellow
    
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }
            
            ForEach(1..<maximumRating + 1, id: \.self) {number in
                Button {
                    rating = number
                } label: {
                    ratingImage(for: number)
                        .foregroundStyle(number > rating ? offColor : onColor)
                }
                .buttonStyle(.plain)
            }
        }
    }
    
    func ratingImage(for number: Int) -> Image {
        if number > rating {
            offImage ?? onImage
        } else {
            onImage
        }
    }
}

#Preview {
    RatingView(rating: .constant(2))
}

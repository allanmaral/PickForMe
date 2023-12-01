//
//  CardView.swift
//  EscolhaPraMim
//
//  Created by Allan Amaral on 23/11/23.
//

import SwiftUI

struct Card {
    let content: String
    let flipped: Bool
}

struct CardView: View {
    let card: Card
    
    var body: some View {
        Text(card.content)
            .font(.system(size: Constants.FontSize.largest))
            .minimumScaleFactor(Constants.FontSize.scaleFactor)
            .multilineTextAlignment(.center)
            .aspectRatio(1, contentMode: .fit)
            .foregroundColor(Color.primary)
            .padding(Constants.inset)
            .cardify(flipped: card.flipped)
    }
    
    private enum Constants {
        static let inset: CGFloat = 8
        
        enum FontSize {
            static let largest: CGFloat = 18
            static let smallest: CGFloat = 10
            static let scaleFactor = smallest / largest
        }
    }
}

#Preview {
    CardView(card: Card(content: "Sample Text", flipped: false))
}

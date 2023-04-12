//
//  KeypadView.swift
//  DoubleCheckCall
//
//  Created by Seungchul Lee on 2023/04/12.
//

import SwiftUI

struct KeypadButtonView: View {
    let digit: String
    let letters: String
    
    var body: some View {
        Button {
            
        } label: {
            VStack {
                Text(digit)
                    .font(.largeTitle)
                Text(letters)
                    .font(.caption)
            }
            .padding(20)
            .background(Color.white)
            .cornerRadius(0)
            .shadow(color: .gray, radius: 3, x: 0, y: 2)
            .frame(width: 150, height: 150, alignment: .center)
        }
    }
}

struct KeypadView: View {
    let digits = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "*", "0", "#"]
    let letters = ["", "ABC", "DEF", "GHI", "JKL", "MNO", "PQRS", "TUV", "WXYZ", "", "+", ""]

    var body: some View {
        VStack {
            ForEach(0..<3) { row in
                HStack {
                    ForEach(0..<3) { column in
                        let index = row * 3 + column
                        KeypadButtonView(digit: digits[index], letters: letters[index])
                    }
                }
            }
            HStack {
                KeypadButtonView(digit: "*", letters: "")
                KeypadButtonView(digit: "0", letters: "")
                KeypadButtonView(digit: "#", letters: "")
            }
        }
        .padding()
    }
}


struct KeypadView_Previews: PreviewProvider {
    static var previews: some View {
        KeypadView()
    }
}

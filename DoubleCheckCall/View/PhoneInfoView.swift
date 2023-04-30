//
//  PhoneInfoView.swift
//  DoubleCheckCall
//
//  Created by Seungchul Lee on 2023/04/17.
//

import SwiftUI

struct PhoneInfoView: View {
    
    var personInfo: PersonInfo
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    //GroupBox(
                        Button(action: {
                            phoneCall(number: personInfo.mobile)
                        }) {
                          Image(systemName: "phone")
                        }
                    //)
                }
            }
        }.padding()
    }
    
    func phoneCall(number: String?) {
        if let number = number, let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}

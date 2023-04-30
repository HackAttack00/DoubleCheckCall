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
            ScrollView(.vertical, showsIndicators: true) {
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        GroupBox {
                            Button(action: {
                                phoneCall(number: personInfo.mobile)
                            }) {
                              Image(systemName: "message")
                                    .resizable()
                            }
                        }
                        .padding(10)
                        .border(Color.red)
                        GroupBox {
                            Button(action: {
                                phoneCall(number: personInfo.mobile)
                            }) {
                              Image(systemName: "phone")
                                    .resizable()
                            }
                        }
                        .padding(10)
                        .border(Color.red)
                        GroupBox {
                            Button(action: {
                                phoneCall(number: personInfo.mobile)
                            }) {
                              Image(systemName: "video")
                                    .resizable()
                            }
                        }
                        .padding(10)
                        .border(Color.red)
                        GroupBox {
                            Button(action: {
                                phoneCall(number: personInfo.mobile)
                            }) {
                              Image(systemName: "mail")
                                    .resizable()
                            }
                        }
                        .padding(10)
                        .border(Color.red)
                    }
                    
                    GroupBox(label: Text("메모")) {
                        Divider().padding(.vertical, 4)
                        Button(action: {
                            phoneCall(number: personInfo.mobile)
                        }) {
                            Text("메세지보내기")
                                .padding(.leading, 0)
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    
                    Spacer(minLength: 10)
                    
                    GroupBox {
                        HStack {
                            Button(action: {
                                phoneCall(number: personInfo.mobile)
                            }) {
                                Text("연락처 공유")
                                    .padding(.leading, 0)
                            }
                            Spacer()
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    
                    Spacer(minLength: 10)
                    
                    GroupBox {
                        HStack {
                            Button(action: {
                                phoneCall(number: personInfo.mobile)
                            }) {
                                Text("이 발신자 차단")
                                    .padding(.leading, 0)
                            }
                            Spacer()
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                }
                
                .navigationViewStyle(StackNavigationViewStyle())
                .navigationBarTitle(Text(personInfo.name ?? "NONAME"), displayMode: .large)
            }
        }
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

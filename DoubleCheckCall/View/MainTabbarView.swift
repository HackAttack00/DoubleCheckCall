//
//  MainTabbarView.swift
//  DoubleCheckCall
//
//  Created by Seungchul Lee on 2023/04/12.
//

import SwiftUI

struct MainTabbarView: View {
    var body: some View {
        TabView {
            Text("최근통화목록")
            .tabItem{
                Image(systemName: "list.bullet")
                Text("최근통화")
            }
            KeypadView()
            .tabItem{
                Image(systemName: "phone")
                Text("키패드")
            }
            Text("설정")
            .tabItem{
                Image(systemName: "gear")
                Text("설정")
            }
        }
    }
}

struct MainTabbarView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabbarView()
    }
}

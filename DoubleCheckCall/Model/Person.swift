//
//  Person.swift
//  DoubleCheckCall
//
//  Created by Seungchul Lee on 2023/04/17.
//

import Foundation

class PersonData: ObservableObject {
    @Published var personInfoList: [PersonInfo]
    
    init() {
        personInfoList = []
    }
}

struct PersonInfo: Identifiable {
    let id = UUID()
    let name:String?
    let mobile:String?
    let home:String?
}

//
//  RecentCallListView.swift
//  DoubleCheckCall
//
//  Created by Seungchul Lee on 2023/04/17.
//

import Foundation
import CallKit
import SwiftUI
import Contacts

struct PhoneBookListView: View {
    @ObservedObject var personData: PersonData = PersonData()
    @State var queryString: String = ""
    
    var body: some View {
        NavigationView {
            List() {
                ForEach(personData.personInfoList.filter { personInfo in
                    if queryString.isEmpty {
                        return true
                    } else if self.includedString(queryString, personName: personInfo.name)
                        || self.includedString(queryString, personName: personInfo.initial) {
                        return true
                    } else {
                        return false
                    }
                }) { list in
                    HStack {
                        Text(list.name ?? "")
                            .foregroundColor(.white)
                        Spacer()
                        Text(list.mobile ?? "")
                            .foregroundColor(.gray)
                    }
                }
            }
            .onAppear {
                self.fetchContacts(completion: { personInfoList in
                    self.personData.personInfoList = personInfoList
                })
            }
        }
        .searchable(text: $queryString, placement: .navigationBarDrawer(displayMode: .always)) {
            let _ = print("queryString = \(queryString)")
            
            if queryString.isEmpty {
                let _ = print("비었다")
            } else {
                //self.personData.personInfolist 필터링
            }
        }
    }

    func fetchContacts(completion: @escaping ([PersonInfo]) -> Void) {
        
        var personInfoList:[PersonInfo] = []
        
        let store = CNContactStore()
        let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]

        let request = CNContactFetchRequest(keysToFetch: keysToFetch as [CNKeyDescriptor])
        DispatchQueue.global(qos: .default).async {
            do {
                try store.enumerateContacts(with: request) {
                    contact, stop in
                    let fullName = "\(contact.givenName) \(contact.familyName)"
                    print("Name: \(fullName)")
                    var number: CNPhoneNumber? = nil
                    for phoneNumber in contact.phoneNumbers {
                        number = phoneNumber.value
                        var localizedLabel = "없다"
                        if let label = phoneNumber.label {
                            localizedLabel = CNLabeledValue<CNPhoneNumber>.localizedString(forLabel: label)
                            print("\(localizedLabel): \(number?.stringValue ?? "")")
                        }
                    }
                    
                    let initial = extractInitial(fullName)
                    let personInfo = PersonInfo(name: fullName, mobile: number?.stringValue, home: nil, initial: initial)
                    personInfoList.append(personInfo)
                }
                DispatchQueue.main.async {
                    completion(personInfoList)
                }
            } catch {
                print("Unable to fetch contacts.")
            }
        }
    }
    
    func includedString(_ name:String, personName:String?) -> Bool {
        if let personName = personName {
            return personName.contains(name)
        }
        return false
    }
    
    func extractInitial(_ string: String) -> String {
        let koreanInitials: [Character] = ["ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]
        
        var initial = ""
        
        for character in string {
            guard let scalar = character.unicodeScalars.first else {
                continue
            }
            
            let code = scalar.value
            
            if code >= 44032 && code <= 55203 { // check if the character is a Korean syllable
                let initialCode = Int((code - 44032) / 28 / 21)
                initial += String(koreanInitials[initialCode])
            } else {
                initial += String(character)
            }
        }
        
        return initial
    }
}

struct PhoneBookListView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneBookListView()
    }
}

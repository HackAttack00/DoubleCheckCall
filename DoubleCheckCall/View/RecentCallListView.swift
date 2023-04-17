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

struct RecentCallListView: View {
    @ObservedObject var personData: PersonData = PersonData()
    
    var body: some View {
        List(personData.personInfoList) { list in
            HStack {
                Text(list.name ?? "")
                    .foregroundColor(.white)
                Spacer()
                Text(list.mobile ?? "")
                    .foregroundColor(.gray)
            }
        }.onAppear {
            self.fetchContacts(completion: { personInfoList in
                self.personData.personInfoList = personInfoList
            })
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
                    
                    let personInfo = PersonInfo(name: fullName, mobile: number?.stringValue, home: nil)
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
}

//struct RecentCallListView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecentCallListView()
//    }
//}

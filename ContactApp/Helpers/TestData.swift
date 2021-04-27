//
//  TestData.swift
//  ContactApp
//
//  Created by Roma Marshall on 25.04.21.
//

import Foundation

struct TestData {
    static func nameDuplicates() -> [Duplicate] {
        let contacts = self.contacts()
        let testData = [
            Duplicate(
                value: "test1",
                contacts: [
                    contacts[0], contacts[1]
                ]
            ),
            Duplicate(
                value: "test2",
                contacts: [
                    contacts[1], contacts[2]
                ]
            )
        ]
        return testData
    }
    
    static func contacts() -> [Contact] {
        let contact1 = Contact(
            id: "0",
            firstName: "Vasya",
            lastName: "Pupkin",
            phones: ["+000", "+111", "+222"],
            emails: ["vasya@mail.com"],
            birthday: DateComponents(),
            company: "Apple"
        )
        let contact2 = Contact(
            id: "1",
            firstName: "Irina",
            lastName: "Labuda",
            phones: ["+333"],
            emails: ["irina@mail.com"],
            birthday: DateComponents(),
            company: "Google Inc"
        )
        let contact3 = Contact(
            id: "2",
            firstName: "Mark",
            lastName: "Alamoha",
            phones: ["+444", "+555"],
            emails: ["mark@mail.com"],
            birthday: DateComponents(),
            company: "Facebook"
        )
        let contacts = [
            contact1,
            contact2,
            contact3
        ]
        return contacts
    }
    
    static func testBirthdayData() -> [BirthdaySection] {
        let contacts = self.contacts()
        var sections = [BirthdaySection]()
        sections.append(BirthdaySection(title: "11 Jan", contacts: [contacts[0], contacts[1]]))
        sections.append(BirthdaySection(title: "22 Dec", contacts: [contacts[2]]))
        return sections
    }
    
    static func testCompanyData() -> [CompanySection] {
        let contacts = self.contacts()
        var sections = [CompanySection]()
        sections.append(CompanySection(title: "Google", contacts: [contacts[0], contacts[1]]))
        sections.append(CompanySection(title: "Apple", contacts: [contacts[2]]))
        return sections
    }
}

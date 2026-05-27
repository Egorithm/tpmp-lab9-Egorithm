//
//  Department.swift
//  FPMI_App
//
//  Created by user on 13.05.26.
//  Kurdeko Egor

import Foundation

struct Department {
    let name: String
    let imageName: String
    let headName: String
    let courses: [String]
    
    static func loadFromPlist() -> [Department] {
        guard let path = Bundle.main.path(forResource: "Departments", ofType: "plist"),
              let array = NSArray(contentsOfFile: path) as? [[String: Any]] else { return [] }
        return array.map { Department(name: $0["name"] as? String ?? "", imageName: $0["imageName"] as? String ?? "", headName: $0["headName"] as? String ?? "", courses: $0["courses"] as? [String] ?? []) }
    }
}

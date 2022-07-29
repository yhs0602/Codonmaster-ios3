//
//  UserDefaults+DomainSchemas.swift
//  CodonMaster
//
//  Created by 양현서 on 2022/07/29.
//

import Foundation

extension UserDefaults {
    var announcements: [Announcement] {
        get {
            guard let data = UserDefaults.standard.data(forKey: "announcements") else { return [] }
            return (try? PropertyListDecoder().decode([Announcement].self, from: data)) ?? []
        }
        set {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: "announcements")
        }
    }
}

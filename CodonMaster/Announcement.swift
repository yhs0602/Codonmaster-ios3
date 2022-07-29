//
//  Announcement.swift
//  CodonMaster
//
//  Created by 양현서 on 2022/07/29.
//

import Foundation

struct Announcement: Codable, Hashable {
    var title: String
    var lang: String
    var time: String
    var content: String
    var image: String
}

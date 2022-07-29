//
//  AnnounceView.swift
//  CodonMaster
//
//  Created by 양현서 on 2022/07/21.
//

import Foundation
import SwiftUI


struct AnnounceView: View {
    let announcements: [Announcement]
    
    init() {
        announcements = UserDefaults.standard.announcements
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .center) {
                ForEach(announcements, id: \.self) { announcement in
                    NavigationLink {
                        AnnouncementDetailView(announcement: announcement)
                    } label: {
                        /*@START_MENU_TOKEN@*/Text(announcement.title)/*@END_MENU_TOKEN@*/
                    }
                }
            }
        }.navigationTitle("Announcement")
    }
}


struct AnnouncementDetailView: View {
    let announcement: Announcement
    
    var body: some View {
        HStack {
            Text(announcement.image)
            VStack {
                Text(announcement.title)
                Text(announcement.content)
                Text(announcement.time)
            }
        }
    }
}

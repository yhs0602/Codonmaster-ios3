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
        VStack {
            Text(announcement.title).font(.largeTitle).padding()
//            Text(announcement.image)
            Text(announcement.content).font(.body)
            HStack {
                Spacer()
                Text(announcement.time).font(.footnote)
            }
            Spacer()
        }.padding()
    }
}

//
//  SongView.swift
//  MentalHealthApplication
//
//  Created by Victor on 31/03/2024.
//

import SwiftUI
import JournalingSuggestions

struct SongView: View {
//    @Environment(\.dismiss) var dismiss
//    @Binding var songs: [JournalingSuggestion.Song]
    @Binding var song: [String]
    
    var body: some View {
        Button("Exit") {
//                   dismiss()
               }
               .font(.title)
               .padding()
               .background(.black)
//        ForEach(songs, id: \.song){song in
//            Text(song.album ?? "" + "by " + song.artist ?? "")
//            Text(song.song ?? "")
//        }
    }
}

//#Preview {
//    SongView()
//}

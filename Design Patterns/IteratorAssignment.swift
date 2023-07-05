//
//  IteratorAssignment.swift
//  
//
//  Created by Damir Aliyev on 26.04.2023.
//

class Song {
    let title: String
    let artist: String
    
    init(title: String, artist: String) {
        self.title = title
        self.artist = artist
    }
}

protocol Iterator {
    func hasNext() -> Bool
    func next() -> Song?
}

protocol Playlist {
    func createIterator() -> Iterator
    
    func addSong(song: Song)
}

class PlaylistIterator: Iterator {
    private var songs: [Song]
    private var current = -1
    
    init(playlist: PlaylistImpl) {
        self.songs = playlist.songs
    }
    
    func hasNext() -> Bool {
        return current < songs.count - 1
    }
    
    func next() -> Song? {
        let nextSong = hasNext() ? songs[current + 1] : nil
        current += 1
        
        return nextSong
    }
}

class PlaylistImpl: Playlist {
    var songs: [Song] = []
    
    func createIterator() -> Iterator {
        let playlistIterator = PlaylistIterator(playlist: self)
        
        return playlistIterator
    }
    
    func addSong(song: Song) {
        self.songs.append(song)
    }
}

let song1 = Song(title: "Song 1", artist: "Artist 1")
let song2 = Song(title: "Song 2", artist: "Artist 2")
let song3 = Song(title: "Song 3", artist: "Arist 3")

let playlist = PlaylistImpl()
playlist.addSong(song: song1)
playlist.addSong(song: song2)
playlist.addSong(song: song3)

let iterator = playlist.createIterator()

while iterator.hasNext() {
    print(iterator.next()!.title)
}
//Output:
//Song 1
//Song 2
//Song 3


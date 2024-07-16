//
//  FlickerResult.swift
//  CVS_Challenge
//
//  Created by Derek Howes on 7/13/24.
//

import Foundation

struct Results: Codable, Hashable {
    var items: [Item]
}


struct Item: Codable, Hashable {
    var title: String
    var link: String
    var mediaURL: String
    var description: String
    var published: String

    enum CodingKeys: String, CodingKey {
        case title
        case link
        case media
        case description
        case published
    }

    enum MediaKeys: String, CodingKey {
        case m
    }
    
    init(title: String, link: String, mediaURL: String, description: String, published: String) {
        self.title = title
        self.link = link
        self.mediaURL = mediaURL
        self.description = description
        self.published = published
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        link = try container.decode(String.self, forKey: .link)
        description = try container.decode(String.self, forKey: .description)
        published = try container.decode(String.self, forKey: .published)
        
        let mediaContainer = try container.nestedContainer(keyedBy: MediaKeys.self, forKey: .media)
        mediaURL = try mediaContainer.decode(String.self, forKey: .m)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(link, forKey: .link)
        try container.encode(description, forKey: .description)
        try container.encode(published, forKey: .published)
        
        var mediaContainer = container.nestedContainer(keyedBy: MediaKeys.self, forKey: .media)
        try mediaContainer.encode(mediaURL, forKey: .m)
    }
    
    static var mock: Item {
        return Item(
            title: "Short Title",
            link: "https://www.flickr.com//photos//72842252@N04//53849534118//",
            mediaURL: "https://live.staticflickr.com//65535//53849534118_9e3fe73e8f_m.jpg",
            description: """
                        <p><a href="https://www.flickr.com/people/72842252@N04/">Steve &amp; Alison1</a> posted a photo:</p> <p><a href="https://www.flickr.com/photos/72842252@N04/53849534118/" title="Whitsunday spiny anteater Echidna Tachyglossus sp aff aculeatus Tachyglossidae Mandalay rainforest Airlie Beach"><img src="https://live.staticflickr.com/65535/53849534118_9e3fe73e8f_m.jpg" width="240" height="207" alt="Whitsunday spiny anteater Echidna Tachyglossus sp aff aculeatus Tachyglossidae Mandalay rainforest Airlie Beach" /></a></p> <p>about 320mm long on walkway near night lights</p>
                        """,
            published: "2023-07-14T00:00:00Z"
        )
    }
}

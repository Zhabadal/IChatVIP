//
//  MMessage.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 03.04.2021.
//

import UIKit
import FirebaseFirestore
import MessageKit

struct ImageItem: MediaItem {
    var url: URL?
    var image: UIImage?
    var placeholderImage: UIImage
    var size: CGSize
}

struct MMessage: Hashable, MessageType {
    
    let id: String?
    let content: String
    var sender: SenderType
    var sentDate: Date
    
    var messageId: String {
        return id ?? UUID().uuidString
    }
    
    var kind: MessageKind {
        if let image = image {
            let mediaItem = ImageItem(url: nil, image: nil, placeholderImage: image, size: image.size)
            return .photo(mediaItem)
        } else {
            return .text(content)
        }
    }
    
    var image: UIImage? = nil
    var downloadURL: URL? = nil
    
    var representation: [String: Any] {
        var rep: [String: Any] = [
            "created": sentDate,
            "senderID": sender.senderId,
            "senderName": sender.displayName
        ]
        
        if let url = downloadURL {
            rep["url"] = url.absoluteString
        } else {
            rep["content"] = content
        }
        
        return rep
    }
    
    init(user: MUser, content: String) {
        self.content = content
        sender = MSender(senderId: user.id, displayName: user.username)
        sentDate = Date()
        id = nil
    }
    
    init(user: MUser, image: UIImage) {
        sender = MSender(senderId: user.id, displayName: user.username)
        self.image = image
        content = ""
        sentDate = Date()
        id = nil
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let sentDate = data["created"] as? Timestamp else { return nil }
        guard let senderId = data["senderID"] as? String else { return nil }
        guard let senderName = data["senderName"] as? String else { return nil }
        
        self.id = document.documentID
        self.sentDate = sentDate.dateValue()
        sender = MSender(senderId: senderId, displayName: senderName)
        
        if let content = data["content"] as? String {
            self.content = content
            downloadURL = nil
        } else if let urlString = data["url"] as? String, let url = URL(string: urlString) {
            downloadURL = url
            self.content = ""
        } else {
            return nil
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(messageId)
    }
    
    static func == (lhs: MMessage, rhs: MMessage) -> Bool {
        return lhs.messageId == rhs.messageId
    }
    
}

extension MMessage: Comparable {
    
    static func < (lhs: MMessage, rhs: MMessage) -> Bool {
        return lhs.sentDate < rhs.sentDate
    }
    
}

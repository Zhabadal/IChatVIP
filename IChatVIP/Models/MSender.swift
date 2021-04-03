//
//  MSender.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 03.04.2021.
//

import Foundation
import MessageKit

struct MSender: SenderType, Equatable {
    var senderId: String
    var displayName: String
}

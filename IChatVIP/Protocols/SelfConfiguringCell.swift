//
//  SelfConfiguringCell.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 02.04.2021.
//

import Foundation

protocol SelfConfiguringCell {
    static var reuseId: String { get }
    func configure<U: Hashable>(with value: U)
}

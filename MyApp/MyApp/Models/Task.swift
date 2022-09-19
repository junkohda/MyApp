//
//  Task.swift
//  GoodList
//
//  Created by jun.kohda on 2022/09/14.
//

import Foundation

enum Priority: Int {
    case high
    case medium
    case low
}


struct Task {
    let title: String
    let priority: Priority
}

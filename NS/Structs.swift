//
//  Structs.swift
//  NS
//
//  Created by Даниил on 23.11.2023.
//

import Foundation
import SwiftUI

struct LoginResponse: Codable {
    let code: Int?
    let message: String
    let data: UserData
}

struct UserData: Codable {
    let token: String
    let id: Int
    let first_name: String
    let last_name: String
    let role: String
}


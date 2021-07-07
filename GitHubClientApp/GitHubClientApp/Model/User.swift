//
//  User.swift
//  GitHubClientApp
//
//  Created by 今村京平 on 2021/07/06.
//

import Foundation

final class User {
    let id: Int
    let name: String
    let iconUrl: String
    let webURL: String

    init(attributes: [String: Any]) {
        id  = attributes["id"] as! Int
        name = attributes["login"] as! String
        iconUrl = attributes["avatar_url"] as! String
        webURL = attributes["html_url"] as! String
    }
}

//
//  News.swift
//  HackerNewsClient
//
//  Created by Dinar Mukhametshin on 29.04.2020.
//  Copyright © 2020 Dinar Mukhametshin. All rights reserved.
//

import Foundation

struct Story: Decodable {
    let title: String
    let url: URL?
}

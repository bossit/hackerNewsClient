//
//  Job.swift
//  HackerNewsClient
//
//  Created by Dinar Mukhametshin on 01.05.2020.
//  Copyright © 2020 Dinar Mukhametshin. All rights reserved.
//

import Foundation

struct Job: Decodable {
    let title: String
    let type: String
    let url: String?
}

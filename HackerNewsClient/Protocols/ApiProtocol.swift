//
//  ApiProtocol.swift
//  HackerNewsClient
//
//  Created by Dinar Mukhametshin on 01.05.2020.
//  Copyright © 2020 Dinar Mukhametshin. All rights reserved.
//

import Foundation

protocol ApiProtocol {
    func fetchIds()
    func fetchData(_ ids: [Int])
}

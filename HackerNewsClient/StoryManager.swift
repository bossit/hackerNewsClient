//
//  StoryManager.swift
//  HackerNewsClient
//
//  Created by Dinar Mukhametshin on 29.04.2020.
//  Copyright © 2020 Dinar Mukhametshin. All rights reserved.
//

import Foundation

protocol StoryManagerDelegate {
    func didUpdateTableView(_ storyManager: StoryManager, story: Story)
    func didFailRequest(error: Error)
}

struct StoryManager {
    var delegate: StoryManagerDelegate?
    
    func fetchData() {
        fetchStoriesIds()
    }
    
    private func fetchStoriesIds() {
        if let url = URL(string: Constants.ApiGateway.bestStories) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailRequest(error: error!)
                    return
                }
                
                if let safeData = data {
                    let decoder = JSONDecoder()

                    do {
                        let storiesIds = try decoder.decode(Array<Int>.self, from: safeData)
                        
                        DispatchQueue.main.async {
                            self.fetchStories(storiesIds)
                        }
                        
                    } catch {
                        self.delegate?.didFailRequest(error: error)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    private func fetchStories(_ ids: [Int]) {
        
        for storyId in ids {
            if let url = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(storyId).json") {
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { (data, response, error) in
                    if error != nil {
                        self.delegate?.didFailRequest(error: error!)
                        return
                    }
                    
                    if let safeData = data {
                        let decoder = JSONDecoder()

                        do {
                            let story = try decoder.decode(Story.self, from: safeData)
                            
                            DispatchQueue.main.async {
                                if story.type == "story" {
                                    self.delegate?.didUpdateTableView(self, story: story)
                                }
                            }
                            
                        } catch {
                            self.delegate?.didFailRequest(error: error)
                        }
                    }
                }
                
                task.resume()
            }
        }
    }
}

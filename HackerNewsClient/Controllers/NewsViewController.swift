//
//  FirstViewController.swift
//  HackerNewsClient
//
//  Created by Dinar Mukhametshin on 29.04.2020.
//  Copyright © 2020 Dinar Mukhametshin. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    var newsArray = [Story]()
    var storyIds: [Int] = []
    var storyManager = StoryManager()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storyManager.delegate = self
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: Constants.Nibs.news, bundle: nil), forCellReuseIdentifier: Constants.Cells.newsItem)
        
        storyManager.fetchData()
    }
}


extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let news = newsArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.newsItem, for: indexPath) as! NewsCell
        cell.title?.text = news.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
//        let news = newsArray[indexPath.row]
    }
}


extension NewsViewController: StoryManagerDelegate {
    func didFailRequest(error: Error) {
        print(error)
    }
    
    func didUpdateTableView(_ storyManager: StoryManager, story: Story) {
        newsArray.append(story)
        
        tableView.reloadData()
    }
}

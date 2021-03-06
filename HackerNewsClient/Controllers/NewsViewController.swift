//
//  FirstViewController.swift
//  HackerNewsClient
//
//  Created by Dinar Mukhametshin on 29.04.2020.
//  Copyright © 2020 Dinar Mukhametshin. All rights reserved.
//

import UIKit
import SafariServices

class StoriesViewController: UIViewController, SFSafariViewControllerDelegate {
    
    var storiesArray = [Story]()
    var storyManager = StoryManager()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storyManager.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: Constants.Nibs.news, bundle: nil), forCellReuseIdentifier: Constants.Cells.newsItem)
        
        storyManager.fetchData()
    }
}


extension StoriesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let story = storiesArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.newsItem, for: indexPath) as! StoryCell
        cell.title?.text = story.title
        cell.tooltip?.text = "\(story.score) points by \(story.by)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storiesArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let story = storiesArray[indexPath.row]
        
        if let url = story.url {
          let webViewController = SFSafariViewController(url: URL(string: url)!)
          webViewController.delegate = self
          present(webViewController, animated: true, completion: nil)
        }
    }
}

extension StoriesViewController: StoryManagerDelegate {
    func didFailRequest(error: Error) {
        print(error)
    }
    
    func didUpdateTableView(_ storyManager: StoryManager, story: Story) {
        storiesArray.append(story)
        
        tableView.reloadData()
    }
}

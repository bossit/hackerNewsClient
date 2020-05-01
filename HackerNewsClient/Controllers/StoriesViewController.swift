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
    
    let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storyManager.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: Constants.Nibs.story, bundle: nil), forCellReuseIdentifier: Constants.Cells.story)
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshControlData(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        
        storyManager.fetchIds()
    }
    
    @objc private func refreshControlData(_ sender: Any) {
        storyManager.fetchIds()
        
        DispatchQueue.main.async() {
            self.refreshControl.endRefreshing()
        }
    }
}


extension StoriesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let story = storiesArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.story, for: indexPath) as! StoryCell
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

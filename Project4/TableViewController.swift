//
//  TableViewController.swift
//  Project4
//
//  Created by Tristan Jackson on 5/11/19.
//  Copyright © 2019 Tristan Jackson. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    // var allowedWebsites = ["audreysmonsters.com", "shawndimpfl.com"]
    var allowedWebsites = ["hero": "audreysmonsters.com",
                           "devil": "shawndimpfl.com"]
    var websiteCount = 0
    // var portfolios = [String]()
    
    // var titles = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Portfolio Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
      //  for website in allowedWebsites {
      //      portfolios.append(website.value)
      //  }
        
      //  portfolios.sort()
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // note count is a property, not a method
       // return portfolios.count
        
        allowedWebsites.map { websiteCount += 1 }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Portfolio", for: indexPath)
        for website in allowedWebsites {
            titles.append(website.key)
        }
        cell.textLabel?.text = titles[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Portfolio") as? ViewController {
            vc.selectedPortfolio = portfolios[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}

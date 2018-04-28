//
//  TableViewController.swift
//  SwiftToolTest
//
//  Created by yunna on 2018/4/28.
//  Copyright © 2018年 yunna. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    ///数据源
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
 

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

  

    

}

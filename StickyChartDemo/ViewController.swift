//
//  ViewController.swift
//  StickyChartDemo
//
//  Created by Han on 2023/10/27.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didClicked(_ sender: Any) {
        
        let incomeVC = Mine.Controller.GuildIncome()
        navigationController?.pushViewController(incomeVC, animated: true)
    }
    
}


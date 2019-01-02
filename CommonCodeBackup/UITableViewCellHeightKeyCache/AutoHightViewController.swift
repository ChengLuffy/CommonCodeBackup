//
//  AutoHightViewController.swift
//  AutoLayoutTest
//
//  Created by 成殿 on 2/1/2019.
//  Copyright © 2019 成殿. All rights reserved.
//

import UIKit
import SnapKit

class AutoHightViewController: UIViewController {

    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AutoHeightCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(self.view)
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AutoHightViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AutoHeightCell
        var text: String?
        switch indexPath.row % 4 {
        case 0:
            text = "1234567890sdadasjhadhajkshdkajshdkajshdkahdkahsdkajshdakj"
            break
        case 1:
            text = "1234567890sdadasjhadhajkshdkajshdkajshdkahdkahsdkajshdakjsdadalsjdlkajdalksjdlakjdksaljdlkajsdlkjaldkajsldkjalkdjalskd"
            break
        case 2:
            text = "1234567890sdadasjhadhajkshdkajshdkajshdkahdkahsdkajshdakjfleifihanda,sdna,nca,jsbcashkafkefhakjdlaksjdlakjdalksjflajflajflajfalksjlakjdladjkalsjdlajdafhiyfewbkajbcmbmbcasknlasjdlafjlaihfqwdnda,snda,snda,"
            break
        case 3:
            text = "1234567890sdadasjhadhajkshdkajshdkajshdkahdkahsdkajshdakj1234567890sdadasjhadhajkshdkajshdkajshdkahdkahsdkajshdakjfleifihanda,sdna,nca,jsbcashkafkefhakjdlaksjdlakjdalksjflajflajflajfalksjlakjdladjkalsjdlajdafhiyfewbkajbcmbmbcasknlasjdlafjlaihfqwdnda,snda,snda,sdadalslkdaldk;asdk;alda;skd;a"
            break
        default:
            break
        }
        cell.titleLabel.text = text
        return cell
    }
}

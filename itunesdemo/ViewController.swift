//
//  ViewController.swift
//  itunesdemo
//
//  Created by Yousaf on 11/04/2019.
//  Copyright © 2019 Codenterprise. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var maintableview : UITableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        //setting maintableview
      //  maintableview.frame = self.view.frame
        let barheight : CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displaywidth: CGFloat = self.view.frame.width
        let displayheight : CGFloat = self.view.frame.height
        maintableview = UITableView(frame: CGRect(x: 0, y: 0, width: displaywidth, height: displayheight - barheight))
        maintableview.separatorColor = UIColor.clear
        maintableview.backgroundColor = UIColor.gray
        maintableview.dataSource=self
        maintableview.delegate=self
         self.view.addSubview(maintableview)
        maintableview.register(MyTableViewCell.self, forCellReuseIdentifier: "Cell")

       
    }
    //uitableview datasource methods
    // func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //  }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MyTableViewCell else {fatalError("error in cell creation")}
        cell.myimage.image = UIImage(named: "noimage.jpeg")
        cell.namelbl.text = "Pink"
        cell.mediatypelbl.text = "Audio"
        return cell
    }
    //uitableview delegate method
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
       // return 118
        return 122
    }

}


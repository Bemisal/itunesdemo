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
    var names: [String] = []
    var imagesurls :[String] = []
    var mediaurls :[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        //setting maintableview
        maintableview.frame = self.view.frame
      //  maintableview = UITableView (frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
     /*   let barheight : CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displaywidth: CGFloat = self.view.frame.width
        let displayheight : CGFloat = self.view.frame.height
        maintableview = UITableView(frame: CGRect(x: 0, y: 0, width: displaywidth, height: displayheight - barheight)) */
        maintableview.separatorColor = UIColor.clear
        maintableview.backgroundColor = UIColor.gray
        maintableview.dataSource=self
        maintableview.delegate=self
         self.view.addSubview(maintableview)
        maintableview.register(MyTableViewCell.self, forCellReuseIdentifier: "Cell")
       //json parsing
        let serviceurl = "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/10/explicit.json"
        guard let url = URL (string: serviceurl) else {return}
        URLSession.shared.dataTask(with: url) {(data,response, err) in
            guard let mydata = data else { return }
            do {
                let resultJson = try JSONSerialization.jsonObject(with: mydata, options: []) as? NSDictionary
               if let dictionary = resultJson as? [String: Any] {
                   if let nestedDictionary = dictionary["feed"] as? NSDictionary
                    {
                    if let resultDictionary = nestedDictionary .object(forKey: "results") as? [[String: Any]]
                {
                     print(resultDictionary)
                   
                    for dic in resultDictionary{
                        self.names.append(dic["name"] as! String)
                        self.imagesurls.append(dic["artworkUrl100"] as! String)
                    }}}
                    }
                self.maintableview.reloadData()
                }
        catch {
            print ("error")
        }
    }.resume()
    }
   
    //uitableview datasource methods
    // func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //  }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MyTableViewCell else {fatalError("error in cell creation")}
        
        cell.myimage.image = UIImage(named: "noimage.jpeg")
        //cell.namelbl.text = "Pink"
        cell.namelbl.text = self.names[indexPath.row]
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


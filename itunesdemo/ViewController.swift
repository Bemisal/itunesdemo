//
//  ViewController.swift
//  itunesdemo
//
//  Created by Bemisal on 11/04/2019.
//  Copyright © 2019 Codenterprise. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var maintableview : UITableView = UITableView()
    var names: [String] = []
    var imagesurls :[String] = []
    var songsidentifiers :[String] = []
     var initialconstraints = [NSLayoutConstraint]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        //setting maintableview
        maintableview.frame = self.view.frame
        maintableview.separatorColor = UIColor.clear
        maintableview.backgroundColor = UIColor.gray
        maintableview.dataSource=self
        maintableview.delegate=self
         self.view.addSubview(maintableview)
        maintableview.register(MyTableViewCell.self, forCellReuseIdentifier: "Cell")
        //setting constraints for maintableview
        maintableview.translatesAutoresizingMaskIntoConstraints = false
        let leading = maintableview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0)
        let trailing = maintableview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
        let top = maintableview.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0)
        let bottom = maintableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        initialconstraints.append(contentsOf: [leading,trailing,top,bottom])
        NSLayoutConstraint.activate(initialconstraints)
       //json parsing
        let serviceurl = "https://rss.itunes.apple.com/api/v1/us/itunes-music/hot-tracks/all/10/explicit.json"
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
                         self.songsidentifiers.append(dic["id"] as! String)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MyTableViewCell else {fatalError("error in cell creation")}
        //getting image from url
        let link :String = self.imagesurls [indexPath.row]
        cell.myimage.sd_setImage(with: URL(string:link), placeholderImage: UIImage(named: "noimage.jpeg"))
        cell.namelbl.text = self.names[indexPath.row]
//        cell.songurl1 = self.mediaurls[indexPath.row]
       // cell.mediatypelbl.text = "Apple Music"
        return cell
    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
        let cell : MyTableViewCell = tableView.cellForRow(at: indexPath) as! MyTableViewCell
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let mediavc = storyBoard.instantiateViewController(withIdentifier: "MediaPlayerViewController") as! MediaPlayerViewController
        mediavc.strimage = cell.myimage.image!
        mediavc.strlbl = cell.namelbl.text!
      //  mediavc.songurl2 = self.mediaurls [indexPath.row]
      //  mediavc.songurl2 = "https://geo.itunes.apple.com/us/album/sanguine-paradise/1459322716?i=1459322719&mt=1&app=music"
        self.navigationController?.pushViewController(mediavc, animated: true)
     }
    //uitableview delegate method
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
       // return 118
        return 122
    }
}


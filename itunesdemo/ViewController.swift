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
    var session :URLSession = URLSession()

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
        
        //json parsing
        let session = URLSession.shared
        let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/10/explicit.json")!
        
        let task = session.dataTask(with: url) { data, response, error in
            
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            
            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print(json)
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }
        
        task.resume()

       
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
    /*
    //json parsing
    //step 1 : Set up the HTTP request with URLSession
   // let session = URLSession.shared
    
    let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/10/explicit.json")!
    //step 2 : Make the request with URLSessionDataTask
    let task = session.dataTask(with: url, completionHandler: { data, response, error in
        
        print(data)
        print(response)
        print(error)
    })
    task.resume()
    
    //let’s check if error is nil or not.
    if error != nil {
    // OH NO! An error occurred...
    self.handleClientError(error)
    return
    }
    //check if the HTTP status code is OK
    guard let httpResponse = response as? HTTPURLResponse,
    (200...299).contains(httpResponse.statusCode) else {
    self.handleServerError(response)
    return
    }
    //checks the so-called MIME type of the response
    guard let mime = response.mimeType, mime == "application/json" else {
    print("Wrong MIME type!")
    return
    }
    //Convert the response data to JSON
    do {
    let json = try JSONSerialization.jsonObject(with: data!, options: [])
    print(json)
    } catch {
    print("JSON error: \(error.localizedDescription)")
    }
    
    }
    
    */
}


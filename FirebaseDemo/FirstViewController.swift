//
//  FirstViewController.swift
//  FirebaseDemo
//
//  Created by Duncan on 2016/6/19.
//  Copyright © 2016年 Duncan. All rights reserved.
//

import UIKit
import Firebase

let DataRef = FIRDatabase.database().reference()


let storage = FIRStorage.storage()
let storageRef = storage.reference(forURL: "gs://fir-demo-19747.appspot.com")

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var urlpath: String? = "Test.jpg"
    //TODO: 要不要放入Default?
    var productArr = ["廣告", "招牌", "LED"]
        //= [0: "廣告", 1: "招牌", 2: "LED"]

    
    
    @IBOutlet weak var productTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rd2save = productArr.enumerated()
        for (index, value) in rd2save{
            print("\(index)" + ":" + "\(value)")
        }
        
        if UserDefaults.standard.object(forKey: "productCategory") != nil {
            //productArr = NSUserDefaults.standardUserDefaults().objectForKey("productCategory") as! Array
        }
        let myQuery = DataRef.child("product").child("商品分類")  //.queryOrderedByKey()
        //(DataRef.child("product").child("商品分類").queryOrderedByValue())
        myQuery.observeSingleEvent(of: .value, with: { (FIRDataSnapshot) in
            self.productArr = FIRDataSnapshot.value as! [String]
            //print(FIRDataSnapshot)
            self.productTableView.reloadData()
            //NSUserDefaults.standardUserDefaults().setObject(self.productArr, forKey: "productCategory")
        })
        
        /////////////COPY FROM FIREBAES//////////////////////
        // Create a reference to the file we want to download
        let starsRef = storageRef.child("/mackbook-pro-861x574.jpg")
        // Start the download (in this case writing to a file)
        urlpath = fileInDocumentsDirectory("0008.jpg")
        let localURL = URL(fileURLWithPath: urlpath!)
        let downloadTask = starsRef.write(toFile: localURL)
        
        // Observe changes in status
        downloadTask.observe(.resume) { (snapshot) -> Void in
            // Download resumed, also fires when the download starts
        }
        
        downloadTask.observe(.pause) { (snapshot) -> Void in
            // Download paused
        }
        
        downloadTask.observe(.progress) { (snapshot) -> Void in
            // Download reported progress
            //let percentComplete = 100.0 * (snapshot.progress?.completedUnitCount)! / (snapshot.progress?.totalUnitCount)!
        }
        
        downloadTask.observe(.success) { (snapshot) -> Void in
            print("Download Successed!")
        }
        
        // Errors only occur in the "Failure" case
        downloadTask.observe(.failure) { (snapshot) -> Void in
            guard let storageError = snapshot.error else { return }
            guard let errorCode = FIRStorageErrorCode(rawValue: storageError.code) else { return }
            switch errorCode {
            case .objectNotFound:
                self.showMessagePrompt("File doesn't exist")
            case .unauthorized:
                self.showMessagePrompt("You haven't logged in yet!")
            case .cancelled:
                self.showMessagePrompt("Download Cancelled")
            case .unknown:
                self.showMessagePrompt("Something goes wrong!")
            default: break
            }
        }
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //COPY FROM INTERNET
    
    func getDocumentsURL() -> URL {
        let documentsURL = FileManager.default.urlsForDirectory(.documentDirectory, inDomains: .userDomainMask)[0]
        return documentsURL
    }
    
    func fileInDocumentsDirectory(_ filename: String) -> String {
        
        let fileURL = try! getDocumentsURL().appendingPathComponent(filename)
        return fileURL.path!
        
    }
    
    // TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let nameLabel = cell.contentView.subviews[1] as! UILabel
        let Image = cell.contentView.subviews[0] as! UIImageView
        
        nameLabel.text = productArr[(indexPath as NSIndexPath).row]
        nameLabel.adjustsFontSizeToFitWidth = true
        if let data = try? Data(contentsOf: URL(fileURLWithPath: urlpath!)){
            Image.image = UIImage(data: data)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: (indexPath as NSIndexPath).row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let vc = segue.destinationViewController as! DetailViewController
        vc.navigationItem.title = productArr[sender as! Int] 
        
    }
    
    
}


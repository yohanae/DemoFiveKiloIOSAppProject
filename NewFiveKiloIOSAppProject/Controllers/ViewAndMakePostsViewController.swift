//
//  ViewAndMakePostsViewController.swift
//  NewFiveKiloIOSAppProject
//
//  Created by yoyo on 7/25/19.
//  Copyright © 2019 Compitence Over Identity Technologies. All rights reserved.
//

import UIKit
import Firebase

class ViewAndMakePostsViewController: UIViewController {

    
    var post: [Post] = [Post]()
    var cellForItemAtIndexPath: IndexPath?
    var scoreCell: UICollectionViewCell?
    var theCurrentIndexPathRow: Int = 0
    @IBOutlet weak var allUsersPostsCollectionView: UICollectionView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAndDisplayUserPosts()
        Timer.scheduledTimer(timeInterval: 00.1, target: self, selector: #selector(ViewAndMakePostsViewController.reloadCollectionviewData), userInfo: nil, repeats: true)
    }
    


    func getPost(at index: Int) -> Post {
        return post [index]
    }
    
    @objc func reloadCollectionviewData () {
        allUsersPostsCollectionView.reloadData()
    }
    
    
    
    func fetchAndDisplayUserPosts() {
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref.child("post").observe(.childAdded, with: { (snapshot) -> Void in
        
            // we're now Getting post values
            let value = snapshot.value as? [String:Any]
            self.post.append(Post(data: value!))
            self.allUsersPostsCollectionView.reloadData()
            
        })
    }
    
}




extension ViewAndMakePostsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (post.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        cellForItemAtIndexPath = indexPath
        theCurrentIndexPathRow = indexPath.row
        
        let userPostCell = self.allUsersPostsCollectionView.dequeueReusableCell(withReuseIdentifier: "userPostCell", for: self.cellForItemAtIndexPath!) as! UsersPostsCollectionViewCell
        
        let getPost = self.getPost(at: self.theCurrentIndexPathRow)
        let name = getPost.name
        let post = getPost.post
        
        userPostCell.usernameLabel.text = ("Anonymous User Name: \n \(name)")
        userPostCell.userPostLabel.text = post
        
        return userPostCell
    }
    
    
    
}

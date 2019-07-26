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
        
        let postID = Auth.auth().currentUser?.providerID
        ref.child("post").child(postID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // we're now Getting user value
            
            DispatchQueue.main.async {
                guard let value = snapshot.value as? [String:Any] else {
                    print("error here")
                    return
                }
                
                self.post.append(Post(data: value))
                print(self.post)
                
            }
        
            let userPostCell = self.allUsersPostsCollectionView.dequeueReusableCell(withReuseIdentifier: "userPostCell", for: (self.cellForItemAtIndexPath)!) as! UsersPostsCollectionViewCell
            self.scoreCell = userPostCell
        
            let getPost = self.getPost(at: self.theCurrentIndexPathRow)
            let name = getPost.name
            let post = getPost.post
        
            userPostCell.usernameLabel.text = name
            userPostCell.userPostLabel.text = post
            self.allUsersPostsCollectionView.reloadData()
        })
 }



    
    
    
    
//    func fetchAndDisplayUserPosts() {
//
//        var ref: DatabaseReference!
//        ref = Database.database().reference()
//        ref.child("post").observe(.value, with: { (snapshot) in
//            // we're now Getting user value
//
//            DispatchQueue.main.async {
//                if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
//                    for _ in snapshots {
//                        guard let value = snapshot.value as? [String:Any] else {
//                            print("error here")
//                            return
//                        }
//
//                self.post.append(Post(data: value))
//                print(self.post)
//
//                    }
//                }
//
//                let userPostCell = self.allUsersPostsCollectionView.dequeueReusableCell(withReuseIdentifier: "userPostCell", for: (self.cellForItemAtIndexPath)!) as! UsersPostsCollectionViewCell
//                self.scoreCell = userPostCell
//
//                let getPost = self.getPost(at: self.theCurrentIndexPathRow)
//                let name = getPost.name
//                let post = getPost.post
//
//                userPostCell.usernameLabel.text = name
//                userPostCell.userPostLabel.text = post
//                self.allUsersPostsCollectionView.reloadData()
//            }
//        })
//    }
//    
//    
    


    
}


extension ViewAndMakePostsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (post.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        cellForItemAtIndexPath = indexPath
        theCurrentIndexPathRow = indexPath.row
        fetchAndDisplayUserPosts()
        return scoreCell!
    }
    
    
    
}

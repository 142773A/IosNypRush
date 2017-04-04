//
//  ThreadsTableViewController.swift
//  NypSddpProject
//
//  Created by iOS on 13/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class ThreadsTableViewController: UITableViewController {
    
    var postCategory : PostCategory!
    
    //var tempThreadsList : [Post] = []
    var tempThreadsList = [Post]()
    var threadsList : [[Post]] = []
    
    var tempChallengeNameList : [Challenge] = []
    var challengeNameList : [String] = []
    
    var likeList : [Post] = []
    var dislikeList : [Post] = []
    
    var userLikeList : [PostUpVote] = []
    var userDislikeList : [PostDownVote] = []
    
    
    //let loginName = UserDefaults.standard.string(forKey: "username")
    //let loginId = UserDefaults.standard.integer(forKey: "loginId")
    
    @IBOutlet weak var threadsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.navigationItem.title = "\((postCategory!.postCategoryType)!) Forum"
        
        loadData()
        
        //remove lines
        threadsTableView.tableFooterView = UIView()
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData()
        //self.tableView.reloadData()
    }
    
    func loadData() {
        
        
        tempChallengeNameList.removeAll()
        challengeNameList.removeAll()
        
        tempThreadsList.removeAll()
        threadsList.removeAll()
        
        tempChallengeNameList = ChallengeDataManager.loadChallengeName(categoryId: "\((postCategory!.postCategoryId)!)")
        
        for (cIndex, cElement) in tempChallengeNameList.enumerated() {
            //print("Item \(cIndex): \(cElement.challengeName!)")
            
            challengeNameList.append(cElement.challengeName!)
            
            tempThreadsList = PostDataManager.loadPostOnCategoryAndChallengeName(categoryId: "\((postCategory!.postCategoryId)!)", challengeName: cElement.challengeName!)
            
            //sort date in descending
            tempThreadsList.sort(by: { $0.convertedPostDate.compare($1.convertedPostDate) == .orderedDescending })
            
            var post = [Post]()
            
            for item in tempThreadsList
            {
                let epochTime: TimeInterval = Double(item.convertedPostDate)!
                let date = Date(timeIntervalSince1970: epochTime)
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd MMM yyyy hh:mm:ss"
                
                let formatedDate = dateFormatter.string(from: date)
                //print(formatedDate)
                
                let tempData = item
                item.convertedPostDate = "\(formatedDate)"
                
                post.append(item)
            }
            
            threadsList.append(post)
        }
        
        
        
        
        likeList = PostDataManager.loadPostLikeOnCategory(
            categoryId: "\((postCategory!.postCategoryId)!)")
        
        dislikeList = PostDataManager.loadPostDislikeOnCategory(
            categoryId: "\((postCategory!.postCategoryId)!)")
        
        userLikeList = PostUpVoteDataManager.loadAllLikePost()
        
        userDislikeList = PostDownVoteDataManager.loadAllDislikePost()
        
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 0
    //    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "ShowPostDetails") {
            
            let c = segue.destination as! ThreadDetailsTableViewController
            
            
            let indexPath = self.threadsTableView.indexPathForSelectedRow
            
            if(indexPath != nil){
                
                let post = threadsList[indexPath!.section][indexPath!.row]
                c.post = post
                
                let postCat = self.postCategory!.postCategoryId!
                c.postCat = postCat
            }
        }
            
        else if(segue.identifier == "newThread") {
            
            let c = segue.destination as! NewThreadTableViewController
            
            let postCatId = self.postCategory!.postCategoryId!
            c.postCategoryId = postCatId
            
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0,y: 0,width: self.tableView.frame.width, height: 35))
        view.backgroundColor = UIColor.groupTableViewBackground
        
        let label = UILabel(frame: CGRect(x: 16,y: 3,width: 222,height: 21))
        
        label.font =  UIFont.boldSystemFont(ofSize: 15.0)
        
        label.textColor = UIColor.lightGray
        
        label.text = self.tableView(tableView, titleForHeaderInSection: section)
        view.addSubview(label)
        
        
        return view
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return challengeNameList.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var header : String
        
        if threadsList.count > 0
        {
            header = challengeNameList[section]
        }
        else
        {
            header = "There are no \((postCategory!.postCategoryType)!) Forum"
        }
        
        return header
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return threadsList[section].count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : ThreadsTableViewCell = threadsTableView.dequeueReusableCell(withIdentifier: "ThreadsTableViewCell", for: indexPath) as! ThreadsTableViewCell
        
        let threadItems = self.threadsList[indexPath.section][indexPath.row]
        
        //set sender.tag = postId
        cell.likeButton.tag = threadItems.postId!
        
        //set sender.tag = postId
        cell.dislikeButton.tag = threadItems.postId!
        
        let userId = threadItems.userId
        let loginId = UserDefaults.standard.integer(forKey: "userId")
        
        
        if likeList.count > 0
        {
            //set total number of likes
            for item in likeList
            {
                if (item.postId! == threadItems.postId!)
                {
                    cell.likeCount.text = "\(item.numOfLikes!)"
                    break
                }
                else {
                    cell.likeCount.text = "\(0)"
                }
            }
        }
        else
        {
            cell.likeCount.text = "\(0)"
        }
        
        //_________________________________________________________________________________
        
        if dislikeList.count > 0
        {
            //set total number of dislikes
            for item in dislikeList
            {
                if (item.postId! == threadItems.postId!)
                {
                    cell.dislikeCount.text = "\(item.numOfDislikes!)"
                    break
                }
                else {
                    cell.dislikeCount.text = "\(0)"
                }
            }
        }
        else
        {
            cell.dislikeCount.text = "\(0)"
        }
        
        //_________________________________________________________________________________
        
        //set like button color
        for item in userLikeList
        {
            if (item.postId! == threadItems.postId!)
            {
                
                //set sender.titleLabel.tag = upVoteUserId
                cell.likeButton.titleLabel?.tag = item.upVoteUserId!
                
                //set sender.imageview.tag = upvoteId
                cell.likeButton.imageView?.tag = item.upVoteId!
                
                if (item.upVoteUserId! == loginId)
                {
                    //print("likebutton \(threadItems.postId!) - \(userLikeList.count)")
                    cell.likeButton.setImage(UIImage(named: "selected-like-icon.png"), for: UIControlState.normal)
                    break
                }
                else
                {
                    cell.likeButton.setImage(UIImage(named: "like-icon.png"), for: UIControlState.normal)
                }
                
            }
            else
            {
                cell.likeButton.setImage(UIImage(named: "like-icon.png"), for: UIControlState.normal)
            }
        }
        
        
        //_________________________________________________________________________________
        
        
        
        //set dislike button color
        for item in userDislikeList
        {
            if (item.postId! == threadItems.postId!)
            {
                
                //set sender.titleLabel.tag = downVoteUserId
                cell.dislikeButton.titleLabel?.tag = item.downVoteUserId!
                
                //set sender.imageView.tag = downVoteId
                cell.dislikeButton.imageView?.tag = item.downVoteId!
                
                if (item.downVoteUserId! == loginId)
                {
                    //print("dislike \(threadItems.postId!) - \(dislikeList.count)")
                    cell.dislikeButton.setImage(UIImage(named: "selected-dislike-icon.png"), for: UIControlState.normal)
                    break
                }
                else
                {
                    cell.dislikeButton.setImage(UIImage(named: "dislike-icon.png"), for: UIControlState.normal)
                }
                
            }
            else
            {
                cell.dislikeButton.setImage(UIImage(named: "dislike-icon.png"), for: UIControlState.normal)
            }
        }
        
        
        //_________________________________________________________________________________
        
        cell.titleLabel.text = threadItems.postTitle!
        cell.userLabel.text = threadItems.postShortname!
        
        let formattedDate = threadItems.convertedPostDate!
        
        let substringDate = formattedDate[formattedDate.index(formattedDate.startIndex,offsetBy: 0)...formattedDate.index(formattedDate.startIndex, offsetBy: 10)]
        cell.dateLabel.text = substringDate
        
        cell.likeButton.addTarget(self, action: #selector(ThreadsTableViewController.likeHandler(_:)), for: UIControlEvents.touchUpInside)
        
        cell.dislikeButton.addTarget(self, action: #selector(ThreadsTableViewController.dislikeHandler(_:)), for: UIControlEvents.touchUpInside)
        
        
        //hide right arrow button
        cell.accessoryType = UITableViewCellAccessoryType.none
        
        return cell
        
    }
    
    func likeHandler(_ sender: UIButton)
    {
        print("")
        print("like")
        let postId = sender.tag
        let userId = (sender.titleLabel?.tag)!
        let upVoteId = (sender.imageView?.tag)!
        
        print("postId :\(postId) userId: \(userId) upVoteId: \(upVoteId)")
        print("")
        
        var upVoteList : [PostUpVote] = []
        var downVoteList : [PostDownVote] = []
        var loginId = UserDefaults.standard.integer(forKey: "userId")
        upVoteList = PostUpVoteDataManager.loadUpVotePostId(postId: "\(postId)", userId: "\(loginId)")
        
        downVoteList = PostDownVoteDataManager.loadDownVotePostId(postId: "\(postId)", userId: "\(loginId)")
        
        print("upvote count: \(upVoteList.count)")
        print("________________________________")
        print("downvote count: \(downVoteList.count)")
        print("________________________________")
        
        
        //has upvote no downvote
        if (upVoteList.count == 1 && downVoteList.count == 0)
        {
            
            print("has upvote no downvote")
            //delete upvote
            let deleteUpVoteResult = PostUpVoteDataManager.deleteUpVotePost(
                postUpVote: PostUpVote(
                    postId: postId,
                    userId: loginId))
            
            if(deleteUpVoteResult == true)
            {
                print("Success")
            }
            
            
        }//end of if statement
            
            //no upvote has downvote
        else if (upVoteList.count == 0 && downVoteList.count == 1)
        {
            
            print("no upvote has downvote")
            //delete downvote
            let deleteDownVoteResult = PostDownVoteDataManager.deleteDownVotePost(
                postDownVote: PostDownVote(
                    postId: postId,
                    userId: loginId))
            
            if(deleteDownVoteResult == true)
            {
                print("Success")
            }
            
            
            //insert like
            let insertUpVoteResult = PostUpVoteDataManager.insertUpVote(
                postUpVote: PostUpVote(
                    postId: postId,
                    userId: loginId))
            
            if(insertUpVoteResult == true)
            {
                print("Success")
            }
            
            
        }
            
            //no upvote and downvote
        else if (upVoteList.count == 0 && downVoteList.count == 0)
        {
            print("no upvote and downvote")
            //insert like
            let insertUpVoteResult = PostUpVoteDataManager.insertUpVote(
                postUpVote: PostUpVote(
                    postId: postId,
                    userId: loginId))
            
            if(insertUpVoteResult == true)
            {
                print("Success")
            }
            
        }
        
        loadData()
    }
    
    
    func dislikeHandler(_ sender: UIButton)
    {
        print("")
        print("dislike")
        let postId = sender.tag
        let userId = (sender.titleLabel?.tag)!
        let downVoteId = (sender.imageView?.tag)!
        
        print("postId :\(postId) userId: \(userId) downVoteId: \(downVoteId)")
        print("")
        
        var upVoteList : [PostUpVote] = []
        var downVoteList : [PostDownVote] = []
        var loginId = UserDefaults.standard.integer(forKey: "userId")
        upVoteList = PostUpVoteDataManager.loadUpVotePostId(postId: "\(postId)", userId: "\(loginId)")
        
        downVoteList = PostDownVoteDataManager.loadDownVotePostId(postId: "\(postId)", userId: "\(loginId)")
        
        print("upvote count: \(upVoteList.count)")
        print("________________________________")
        print("downvote count: \(downVoteList.count)")
        print("________________________________")
        
        
        //has upvote no downvote
        if (upVoteList.count == 1 && downVoteList.count == 0)
        {
            
            print("has upvote no downvote")
            //delete upvote
            let deleteUpVoteResult = PostUpVoteDataManager.deleteUpVotePost(
                postUpVote: PostUpVote(
                    postId: postId,
                    userId: loginId))
            
            if(deleteUpVoteResult == true)
            {
                print("Success")
            }
            
            //insert dislike
            let insertDownVoteResult = PostDownVoteDataManager.insertDownVote(
                postDownVote: PostDownVote(
                    postId: postId,
                    userId: loginId))
            
            if(insertDownVoteResult == true)
            {
                print("Success")
            }
            
            
        }//end of if statement
            
            //no upvote has downvote
        else if (upVoteList.count == 0 && downVoteList.count == 1)
        {
            
            print("no upvote has downvote")
            //delete upvote
            let deleteDownVoteResult = PostDownVoteDataManager.deleteDownVotePost(
                postDownVote: PostDownVote(
                    postId: postId,
                    userId: loginId))
            
            if(deleteDownVoteResult == true)
            {
                print("Success")
            }
            
            
        }
            
            //no upvote and downvote
        else if (upVoteList.count == 0 && downVoteList.count == 0)
        {
            print("no upvote and downvote")
            //insert dislike
            let insertDownVoteResult = PostDownVoteDataManager.insertDownVote(
                postDownVote: PostDownVote(
                    postId: postId,
                    userId: loginId))
            
            if(insertDownVoteResult == true)
            {
                print("Success")
            }
            
        }
        
        loadData()
        
        
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}



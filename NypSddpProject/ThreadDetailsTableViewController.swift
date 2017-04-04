//
//  ThreadDetailsTableViewController.swift
//  NypSddpProject
//
//  Created by ℜ . on 17/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit
import UserNotifications

class ThreadDetailsTableViewController: UITableViewController, UITextViewDelegate {
    
    
    @IBOutlet var ThreadDetailsTableView: UITableView!
    
    
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var threadTitle: UILabel!
    
    @IBOutlet weak var threadDesc: UILabel!
    
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var dislikeCount: UILabel!
    @IBOutlet weak var dislikeButton: UIButton!
    
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var commentButton: UIButton!
    
    
    @IBOutlet weak var imageButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    var post : Post!
    var postCat : Int!
    
    
    var likeList : [Post] = []
    var dislikeList : [Post] = []
    
    
    var userLikeList : [PostUpVote] = []
    var userDislikeList : [PostDownVote] = []
    
    var tempCommentList : [Comment] = []
    var commentList : [Comment] = []
    var commentLikeList : [Comment] = []
    var commentDislikeList : [Comment] = []
    
    
    var userCommentLikeList : [CommentUpVote] = []
    var userCommentDislikeList : [CommentDownVote] = []
    
    //let loginName = UserDefaults.standard.string(forKey: "username")
    //let loginId = UserDefaults.standard.integer(forKey: "loginId")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTextView.delegate = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        self.navigationItem.title = "\((post!.postTitle)!)"
        
        loadPostData()
        
        loadComments()
        
        setReply()
        
        //setDelegate()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func loadPostData()
    {
        //ThreadDetailsTableView.allowsSelection = false;
        
        let postId = post!.postId!
        
        let loginId = UserDefaults.standard.integer(forKey: "userId")
        
        let postImage = post!.postImage!.trimmingCharacters(in: .whitespaces)
        
        //hide post image if empty
        if postImage == ""
        {
            imageButton.isHidden = true
        }
        else
        {
            imageButton.isHidden = false
        }
        
        //check if userpost the current post or not
        if post!.userId! == loginId
        {
            deleteButton.isHidden = false
        }
        else
        {
            deleteButton.isHidden = true
        }
        
         //set profile image and other values
        
        var newImg: UIImage!
        
        if post!.profileImg! != ""
        {
            newImg = UIImage(named: post!.profileImg!)
        }
        else
        {
            newImg = UIImage(named: "person.png")
        }
        
        userIcon.layer.borderColor = UIColor(white: 0.7, alpha: 0.9).cgColor
        userIcon.layer.borderWidth = 1.5
        userIcon.layer.cornerRadius = userIcon.frame.height/2
        userIcon.clipsToBounds = true
        userIcon.image = newImg
     
        
        let formattedDate = post!.convertedPostDate!
        
        let substringDate = formattedDate[formattedDate.index(formattedDate.startIndex,offsetBy: 0)...formattedDate.index(formattedDate.startIndex, offsetBy: 16)]
        
        username.text = post!.postShortname!
        date.text = substringDate
        threadTitle.text = post!.postTitle!
        threadDesc.text = post!.postDesc!
        
        //get the total number of likes for current post
        likeList = PostDataManager.loadTotalLikePostOnId(postId: "\(postId)")
        
        //get the total number of dislikes for current post
        dislikeList = PostDataManager.loadTotalDislikePostOnId(postId: "\(postId)")
        
        //get all like post
        userLikeList = PostUpVoteDataManager.loadAllLikePost()
        
        //get all dislike post
        userDislikeList = PostDownVoteDataManager.loadAllDislikePost()
        
        
        //if likelist has row
        if (likeList.count > 0)
        {
            //set number of likes ([0] because it falls into the first row)
            likeCount.text = "\(likeList[0].numOfLikes!)"
        }
        else
        {
            likeCount.text = "\(0)"
        }
        
        //if dislikelist has row
        if (dislikeList.count > 0)
        {
            //set number of dislikes ([0] because it falls into the first row)
            dislikeCount.text = "\(dislikeList[0].numOfDislikes!)"
        }
        else
        {
            dislikeCount.text = "\(0)"
        }
        
        
        //set like button color
        for item in userLikeList
        {
            if (item.postId! == postId)
            {
                if (item.upVoteUserId! == loginId)
                {
                    //print("likebutton \(threadItems.postId!) - \(userLikeList.count)")
                    likeButton.setImage(UIImage(named: "selected-like-icon.png"), for: UIControlState.normal)
                    break
                }
                else
                {
                    likeButton.setImage(UIImage(named: "like-icon.png"), for: UIControlState.normal)
                }
                
            }
            else
            {
                likeButton.setImage(UIImage(named: "like-icon.png"), for: UIControlState.normal)
            }
        }
        
        
        //_________________________________________________________________________________
        
        
        
        //set dislike button color
        for item in userDislikeList
        {
            if (item.postId! == postId)
            {
                
                if (item.downVoteUserId! == loginId)
                {
                    dislikeButton.setImage(UIImage(named: "selected-dislike-icon.png"), for: UIControlState.normal)
                    break
                }
                else
                {
                    dislikeButton.setImage(UIImage(named: "dislike-icon.png"), for: UIControlState.normal)
                }
                
            }
            else
            {
                dislikeButton.setImage(UIImage(named: "dislike-icon.png"), for: UIControlState.normal)
            }
        }
        
    }
    
    
    func loadComments()
    {
        let postId = post!.postId!
        
        tempCommentList = CommentDataManager.loadCommentsOnPostId(postId: "\(postId)")
        
        //sort comment date in ascending
        tempCommentList.sort(by: { $0.convertedCommentDate.compare($1.convertedCommentDate) == .orderedAscending })
        
        //retrieve the date and sort thr list
        for item in tempCommentList
        {
            let epochTime: TimeInterval = Double(item.convertedCommentDate)!
            let date = Date(timeIntervalSince1970: epochTime)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy hh:mm"
            
            let formatedDate = dateFormatter.string(from: date)
            //print(formatedDate)
            
            let tempData = item
            item.convertedCommentDate = "\(formatedDate)"
            
            commentList.append(tempData)
            
        }
        
        
        
        //get all like comment
        userCommentLikeList = CommentUpVoteDataManager.loadAllLikeComments()
        
        //get all dislike post
        userCommentDislikeList = CommentDownVoteDataManager.loadAllDislikeComments()
        
        self.tableView.reloadData()
    }
    
    func setReply()
    {
        //set text placeholder
        commentTextView.delegate = self
        commentTextView.text = "Type your reply"
        commentTextView.textColor = UIColor.lightGray
        
        
        
        //set rounded post comment button
        //commentButton.backgroundColor = .clear
        commentButton.layer.cornerRadius = 5
        commentButton.layer.borderWidth = 1
        commentButton
            .layer.borderColor = UIColor.clear.cgColor
        
    }
    
//    func setDelegate()
//    {
//        if #available(iOS 10.0, *) {
//            UNUserNotificationCenter.current().delegate = self
//        } else {
//            // Fallback on earlier versions
//        }
//        
//    }
    
    //set text view type function
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if commentTextView.textColor == UIColor.lightGray
        {
            commentTextView.text = ""
            commentTextView.textColor = UIColor.black
        }
    }
    
    //    func textViewDidEndEditing(_ textView: UITextView) {
    //
    //
    //        if commentTextView.text == "" && commentTextView.textColor == UIColor.black
    //        {
    //
    //            commentTextView.text = "type your reply"
    //            commentTextView.textColor = UIColor.lightGray
    //        }
    //    }
    //
    //    func textViewDidChange(_ textView: UITextView) {
    //
    //        if commentTextView.text == "" && commentTextView.textColor == UIColor.black
    //        {
    //
    //            commentTextView.text = "type your reply"
    //            commentTextView.textColor = UIColor.lightGray
    //        }
    //    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    @IBAction func imageHandler(_ sender: AnyObject) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "PopOverViewController") as! PopOverViewController
        
        controller.post = post!
        
        controller.modalPresentationStyle = .overCurrentContext
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func deleteHandler(_ sender: Any) {
        
        let postId = post!.postId!
        let loginId = UserDefaults.standard.integer(forKey: "userId")
        
        let refreshAlert = UIAlertController(title: "", message: "This post will be deleted and you'll no longer be able to find it.", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Delete Post", style: .destructive, handler: {
            (action: UIAlertAction!) in
            print("Handle Ok logic here")
            
            
            print("delete comments")
            let deleteCommentResults = CommentDataManager.deleteComments(
                comment: Comment(
                    postId: postId))
            
            if deleteCommentResults == true
            {
                print("success")
                print("delete post")
                
                //delete post
                let deletePostResult = PostDataManager.deletePost(
                    post: Post(
                        id: postId,
                        userId: loginId))
                
                if(deletePostResult == true)
                {
                    print("Success")
                    
                }
                
                self.navigationController?.popViewController(animated: true)
                self.loadPostData()
            }
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
        
        
    }
    
    //like handler
    @IBAction func likeHandler(_ sender: AnyObject) {
        print("")
        print("like")
        print("")
        
        let postId = post!.postId!
        
        var upVoteList : [PostUpVote] = []
        var downVoteList : [PostDownVote] = []
        let loginId = UserDefaults.standard.integer(forKey: "userId")
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
        loadPostData()
        
        
    }
    
    
    
    
    //dislike handler
    @IBAction func dislikeHandler(_ sender: AnyObject) {
        print("")
        print("dislike")
        print("")
        
        let postId = post!.postId!
        var upVoteList : [PostUpVote] = []
        var downVoteList : [PostDownVote] = []
        let loginId = UserDefaults.standard.integer(forKey: "userId")
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
        loadPostData()
    }
    
    
    
    
    
    
    
    @IBAction func postCommentHandler(_ sender: Any) {
        
        
        let currentTime = NSDate().timeIntervalSince1970
        print(currentTime)
        
        let notificationTime = NSDate().timeIntervalSince1970 + 5
        
        let epochTime: TimeInterval = notificationTime
        
        let date = Date(timeIntervalSince1970: epochTime)
        
        let loginId = UserDefaults.standard.integer(forKey: "userId")
        let loginName = UserDefaults.standard.string(forKey: "username")
        let userList = UserDataManager.loadUserByUsername(username: loginName!)
        
        var userShortName : String!
        
        userShortName = userList.shortname
        
        var comment : String!
        
        
        comment = commentTextView.text.trimmingCharacters(in: .whitespaces)
        
        if comment != ""
        {
            print("post comment")
            //insert comment
            let insertCommentResult = CommentDataManager.postComment(comment:
                Comment(
                    desc: comment,
                    date: currentTime,
                    userId: loginId,
                    postId: post!.postId!))
            
            if(insertCommentResult == true)
            {
                print("Success")
                
                var notificationId : Int!
                var notificationName : String!
                var commentId : Int!
                
                //get Forum Id from notification table
                let notificationList = NotificationDataManager.loadNotification(category: "Forum Activity")[0]
                
                //get the last commentedId
                let commentIdList = CommentDataManager.loadLatestCommentId()[0]
                
                
                //get the selected forumId and set notificationId
                notificationId = notificationList.notificationId!
                
                notificationName = notificationList.notificationCategory!
                
                //get the lastest commentId and set it on a variable set commentId
                commentId = commentIdList.commentId!
                
                let postUserId = post!.userId!
                
                //insert notification into db
                if postUserId != loginId
                {
                    let insertNotificationResult = NotificationDataManager.insertNotification(notification: Notification(
                        desc: "\(userShortName!) has commented on your post",
                        dateToNotified: notificationTime,
                        hasNotified: 0,
                        notificationId : notificationId!,
                        commentId: commentId!,
                        userId: loginId))
                    
                    
                    if(insertNotificationResult == true)
                    {
                        print("Success")
                    }
                    
                    //set local notification
                    setNotification(loginId: loginId, userShortName: userShortName!, commentId: commentId!, notificationId: notificationId!, notificationName: notificationName)
                    
                    //empty the text view
                    commentTextView.text = ""
                    

                }
            }
            
            
        }
        
        //remove all list
        tempCommentList.removeAll()
        commentList.removeAll()
        
        //reload again
        loadComments()
        
    }
    
    
    func setNotification(loginId: Int, userShortName: String, commentId: Int, notificationId: Int, notificationName : String)
    {
        if #available(iOS 10.0, *) {
            
            print("notification will be triggered in five seconds..Hold on tight")
            let content = UNMutableNotificationContent()
            //content.title = "New Comment"
            //content.subtitle = "Lets code,Talk is cheap"
            content.body = "\(userShortName) has commented on your post"
            content.userInfo = ["userId" : "\(loginId)", "commentId" : "\(commentId)", "notificationId" : "\(notificationId)", "notificationName" : "\(notificationName)"]
            
            content.sound = UNNotificationSound.default()
            content.badge = NSNumber(integerLiteral: UIApplication.shared.applicationIconBadgeNumber + 1);
            content.categoryIdentifier = "notificationCategory"
            
            //To Present image in notification
            if let path = Bundle.main.path(forResource: "Circle-icons-running.svg copy", ofType: "png") {
                let url = URL(fileURLWithPath: path)
                
                do {
                    let attachment = try UNNotificationAttachment(identifier: "sampleImage", url: url, options: nil)
                    content.attachments = [attachment]
                } catch {
                    print("attachment not found.")
                }
            }
            
            let requestIdentifier = "myNotification" //identifier
            
            // Deliver the notification in five seconds.
            let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 25, repeats: false)
            let request = UNNotificationRequest(identifier:requestIdentifier, content: content, trigger: trigger)
            
            //UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().add(request){(error) in
                
                if (error != nil){
                    
                    print(error?.localizedDescription)
                }
            }
            
            
        } else {
            // Fallback on earlier versions
        }
    }
    
    func removeNotification()
    {
        print("Removed all pending notifications")
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            let requestIdentifier = "myNotification" //identifier
            
            center.removePendingNotificationRequests(withIdentifiers: [requestIdentifier])
            
        } else {
            // Fallback on earlier versions
        }
        
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return commentList.count
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
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var title : String
        
        if commentList.count == 0
        {
            title = ""
        }
        else
        {
            title = "Showing \(commentList.count) of \(commentList.count) comments"
        }
        
        return title
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : ThreadDetailsTableViewCell = ThreadDetailsTableView.dequeueReusableCell(withIdentifier: "ThreadDetailsTableViewCell", for: indexPath) as! ThreadDetailsTableViewCell
        
        cell.selectionStyle = .none
        
        let commentItems = commentList[indexPath.row]
        
        let loginId = UserDefaults.standard.integer(forKey: "userId")
        
        //get the total number of likes for current comment
        commentLikeList = CommentDataManager.loadTotalLikeCommentOnId(commentId: "\(commentItems.commentId!)")
        //print("commentLikeList \(commentLikeList)")
        
        //get the total number of dislikes for current comment
        commentDislikeList = CommentDataManager.loadTotalDislikeCommentOnId(commentId: "\(commentItems.commentId!)")
        
        //print("commentDislikeList \(commentDislikeList)")
        
        //set sender.tag = commentId
        cell.commentLikeButton.tag = commentItems.commentId!
        
        //set sender.tag = commentId
        cell.commentDislikeButton.tag = commentItems.commentId!
        
        //set sender.tag = postId
        cell.deleteButton.tag = commentItems.commentId!
        
        //set titleLabel.tag = commentId
        cell.deleteButton.titleLabel?.tag = commentItems.postId!
        
        if commentItems.userId == loginId
        {
            cell.deleteButton.isHidden = false
        }
        else
        {
            cell.deleteButton.isHidden = true
        }
        
        if commentLikeList.count > 0
        {
            //set total number of likes
            for item in commentLikeList
            {
                if (item.commentId! == commentItems.commentId!)
                {
                    cell.commentLikeCount.text = "\(item.numOfLikes!)"
                    break
                }
                else
                {
                    cell.commentLikeCount.text = "\(0)"
                }
            }
        }
        else
        {
            cell.commentLikeCount.text = "\(0)"
        }
        //_________________________________________________________________________________
        
        if commentDislikeList.count > 0
        {
            //set total number of dislikes
            for item in commentDislikeList
            {
                if (item.commentId! == commentItems.commentId!)
                {
                    cell.commentDislikeCount.text = "\(item.numOfDislikes!)"
                    break
                }
                else
                {
                    cell.commentDislikeCount.text = "\(0)"
                }
            }
        }
        else
        {
            cell.commentDislikeCount.text = "\(0)"
        }
        
        //_________________________________________________________________________________
        
        //set like button color
        
        if userCommentLikeList.count > 0
        {
            for item in userCommentLikeList
            {
                if (item.commentId! == commentItems.commentId!)
                {
                    
                    //set sender.titleLabel.tag = commentUpVoteUserId
                    cell.commentLikeButton.titleLabel?.tag = item.commentUpVoteUserId!
                    
                    //set sender.imageview.tag = commentUpvoteId
                    cell.commentLikeButton.imageView?.tag = item.commentUpVoteId!
                    
                    if (item.commentUpVoteUserId! == loginId)
                    {
                        //print("likebutton \(threadItems.postId!) - \(userLikeList.count)")
                        cell.commentLikeButton.setImage(UIImage(named: "selected-like-icon.png"), for: UIControlState.normal)
                        break
                    }
                    else
                    {
                        cell.commentLikeButton.setImage(UIImage(named: "like-icon.png"), for: UIControlState.normal)
                    }
                }
                else
                {
                    cell.commentLikeButton.setImage(UIImage(named: "like-icon.png"), for: UIControlState.normal)
                }
            }
        }
        else
        {
            cell.commentLikeButton.setImage(UIImage(named: "like-icon.png"), for: UIControlState.normal)
        }
        
        //_________________________________________________________________________________
        
        
        if userCommentDislikeList.count > 0
        {
            //set dislike button color
            for item in userCommentDislikeList
            {
                if (item.commentId! == commentItems.commentId!)
                {
                    
                    //set sender.titleLabel.tag = commentDownVoteUserId
                    cell.commentDislikeButton.titleLabel?.tag = item.commentDownVoteUserId!
                    
                    //set sender.imageView.tag = commentDownVoteId
                    cell.commentDislikeButton.imageView?.tag = item.commentDownVoteId!
                    
                    if (item.commentDownVoteUserId! == loginId)
                    {
                        //print("dislike \(threadItems.postId!) - \(dislikeList.count)")
                        cell.commentDislikeButton.setImage(UIImage(named: "selected-dislike-icon.png"), for: UIControlState.normal)
                        break
                    }
                    else
                    {
                        cell.commentDislikeButton.setImage(UIImage(named: "dislike-icon.png"), for: UIControlState.normal)
                    }
                }
                else
                {
                    cell.commentDislikeButton.setImage(UIImage(named: "dislike-icon.png"), for: UIControlState.normal)
                }
            }
        }
        else
        {
            cell.commentDislikeButton.setImage(UIImage(named: "dislike-icon.png"), for: UIControlState.normal)
        }
        
        
        //_________________________________________________________________________________
        //set image and other values
        var newCommentImg: UIImage!
        
        if commentItems.profileImg != ""
        {
            newCommentImg = UIImage(named: commentItems.profileImg)
        }
        else
        {
            newCommentImg = UIImage(named: "person.png")
        }
        
        cell.commentUserIcon.layer.borderColor = UIColor(white: 0.7, alpha: 0.9).cgColor
        cell.commentUserIcon.layer.borderWidth = 1.5
        cell.commentUserIcon.layer.cornerRadius = userIcon.frame.height/3.5
        cell.commentUserIcon.clipsToBounds = true
        cell.commentUserIcon.image = newCommentImg
        
        cell.commentUsername.text = commentItems.userShortName!
        cell.commentDate.text = "\(commentItems.convertedCommentDate!)"
        cell.commentDesc.text = commentItems.commentDesc!
        
        cell.commentLikeButton.addTarget(self, action: #selector(ThreadDetailsTableViewController.commentLikeHandler(_:)), for: UIControlEvents.touchUpInside)
        
        cell.commentDislikeButton.addTarget(self, action: #selector(ThreadDetailsTableViewController.commentDislikeHandler(_:)), for: UIControlEvents.touchUpInside)
        
        cell.deleteButton.addTarget(self, action: #selector(ThreadDetailsTableViewController.commentDeleteHandler(_:)), for: UIControlEvents.touchUpInside)
        
        
        //hide right arrow button
        cell.accessoryType = UITableViewCellAccessoryType.none
        
        return cell
    }
    
    func commentDeleteHandler(_ sender: UIButton)
    {
        
        
        let refreshAlert = UIAlertController(title: "", message: "This comment will be deleted and you'll no longer be able to find it.", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Delete Comment", style: .destructive, handler: {
            (action: UIAlertAction!) in
            print("Handle Ok logic here")
            
            
            print("delete comment")
            let commentId = sender.tag
            let postId = (sender.titleLabel?.tag)!
            print("commentId", commentId, "postId", postId)
            
            let loginId = UserDefaults.standard.integer(forKey: "userId")
            
            let deleteCommentResults = CommentDataManager.deleteSpecificComments(
                comment: Comment(
                    postId: postId, commentId: commentId, userId: loginId))
            
            if deleteCommentResults == true
            {
                print("success")
                
                //remove all list
                self.tempCommentList.removeAll()
                self.commentList.removeAll()
                
                //reload again
                self.loadComments()
                
            }
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
        
    }
    
    func commentLikeHandler(_ sender: UIButton)
    {
        print("")
        print("like")
        let commentId = sender.tag
        let userId = (sender.titleLabel?.tag)!
        let commentUpVoteId = (sender.imageView?.tag)!
        
        print("commentId :\(commentId) userId: \(userId) upVoteId: \(commentUpVoteId)")
        print("")
        
        var upVoteList : [CommentUpVote] = []
        var downVoteList : [CommentDownVote] = []
        let loginId = UserDefaults.standard.integer(forKey: "userId")
        
        upVoteList = CommentUpVoteDataManager.loadUpVoteCommentId(commentId: "\(commentId)", userId: "\(loginId)")
        
        downVoteList = CommentDownVoteDataManager.loadDownVoteCommentId(commentId: "\(commentId)", userId: "\(loginId)")
        
        print("upvote count: \(upVoteList.count)")
        print("________________________________")
        print("downvote count: \(downVoteList.count)")
        print("________________________________")
        
        
        //has upvote no downvote
        if (upVoteList.count == 1 && downVoteList.count == 0)
        {
            
            print("has upvote no downvote")
            //delete upvote
            let deleteUpVoteResult = CommentUpVoteDataManager.deleteUpVoteComment(
                commentUpVote: CommentUpVote(
                    commentId: commentId,
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
            let deleteDownVoteResult = CommentDownVoteDataManager.deleteDownVoteComment(
                commentDownVote: CommentDownVote(
                    commentId: commentId,
                    userId: loginId))
            
            if(deleteDownVoteResult == true)
            {
                print("Success")
            }
            
            
            //insert like
            let insertUpVoteResult = CommentUpVoteDataManager.insertUpVoteComment(
                commentUpVote: CommentUpVote(
                    commentId: commentId,
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
            let insertUpVoteResult = CommentUpVoteDataManager.insertUpVoteComment(
                commentUpVote: CommentUpVote(
                    commentId: commentId,
                    userId: loginId))
            
            if(insertUpVoteResult == true)
            {
                print("Success")
            }
            
        }
        
        //remove all list
        tempCommentList.removeAll()
        commentList.removeAll()
        
        //reload again
        loadComments()
    }
    
    
    func commentDislikeHandler(_ sender: UIButton)
    {
        print("")
        print("dislike")
        let commentId = sender.tag
        let userId = (sender.titleLabel?.tag)!
        let commentDownVoteId = (sender.imageView?.tag)!
        
        print("commentId :\(commentId) userId: \(userId) downVoteId: \(commentDownVoteId)")
        print("")
        
        var upVoteList : [CommentUpVote] = []
        var downVoteList : [CommentDownVote] = []
        let loginId = UserDefaults.standard.integer(forKey: "userId")
        
        upVoteList = CommentUpVoteDataManager.loadUpVoteCommentId(commentId: "\(commentId)", userId: "\(loginId)")
        
        downVoteList = CommentDownVoteDataManager.loadDownVoteCommentId(commentId: "\(commentId)", userId: "\(loginId)")
        
        print("upvote count: \(upVoteList.count)")
        print("________________________________")
        print("downvote count: \(downVoteList.count)")
        print("________________________________")
        
        
        //has upvote no downvote
        if (upVoteList.count == 1 && downVoteList.count == 0)
        {
            
            print("has upvote no downvote")
            //delete upvote
            let deleteUpVoteResult = CommentUpVoteDataManager.deleteUpVoteComment(
                commentUpVote: CommentUpVote(
                    commentId: commentId,
                    userId: loginId))
            
            if(deleteUpVoteResult == true)
            {
                print("Success")
            }
            
            //insert dislike
            let insertDownVoteResult = CommentDownVoteDataManager.insertDownVoteComment(
                commentDownVote: CommentDownVote(
                    commentId: commentId,
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
            let deleteDownVoteResult = CommentDownVoteDataManager.deleteDownVoteComment(
                commentDownVote: CommentDownVote(
                    commentId: commentId,
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
            let insertDownVoteResult = CommentDownVoteDataManager.insertDownVoteComment(
                commentDownVote: CommentDownVote(
                    commentId: commentId,
                    userId: loginId))
            
            if(insertDownVoteResult == true)
            {
                print("Success")
            }
            
        }
        
        //remove all list
        tempCommentList.removeAll()
        commentList.removeAll()
        
        //reload again
        loadComments()
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

//
////extension to threads details controller
//extension ThreadDetailsTableViewController:UNUserNotificationCenterDelegate{
//    
//    
//    //This is key callback to present notification while the app is in foreground
//    @available(iOS 10.0, *)
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        
//        print("")
//        print("will present")
//        let userInfo = notification.request.content.userInfo
//        let notificationId = notification.request.content.userInfo["notificationId"].unsafelyUnwrapped
//        let commentId = notification.request.content.userInfo["commentId"].unsafelyUnwrapped
//        let tempUserId = "\(notification.request.content.userInfo["userId"].unsafelyUnwrapped)"
//        let notificationName = "\(notification.request.content.userInfo["notificationName"].unsafelyUnwrapped)"
//        
//        badgeNumber = notification.request.content.badge as! Int
//        
//        let userId = Int(tempUserId)
//        let loginId = UserDefaults.standard.integer(forKey: "userId")
//        
//        
//        print("userInfo", userInfo)
//        print("notificationId", notificationId)
//        print("commentId", commentId)
//        print("userId", userId!)
//        print("notificationName", notificationName)
//        
//        //You can either present alert ,sound or increase badge while the app is in foreground too with ios 10
//        //to distinguish between notifications
//        
//        //if current login user has the same notificationId ignore notification
//        if loginId == userId!
//        {
//            completionHandler([])
//            
//            print("Notification being triggered same Id")
//        }
//        else
//        {
//            
//            completionHandler( [.alert,.sound,.badge])
//            
//            if badgeNumber == 0
//            {
//                tabBarController?.tabBar.items?[2].badgeValue = nil
//            }
//            else
//            {
//                tabBarController?.tabBar.items?[2].badgeValue = "\(badgeNumber)"
//            }
//            
//            print("Notification being triggered not same Id")
//            
//        }
//        
//    }
//    
//    
//    @available(iOS 10.0, *)
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        
//        print("")
//        print("did receive")
//        let userInfo = response.notification.request.content.userInfo
//        let tempNotificationId = "\(userInfo["notificationId"].unsafelyUnwrapped)"
//        let tempCommentId = "\(userInfo["commentId"].unsafelyUnwrapped)"
//        let tempUserId = "\(userInfo["userId"].unsafelyUnwrapped)"
//        
//        let tempNotificationName = "\(userInfo["notificationName"].unsafelyUnwrapped)"
//        
//        badgeNumber = response.notification.request.content.badge as! Int
//        
//        let userId = Int(tempUserId)
//        let notificationId = Int(tempNotificationId)
//        let commentId = Int(tempCommentId)
//        let notificationName = String(tempNotificationName)
//        
//        let loginId = UserDefaults.standard.integer(forKey: "userId")
//        
//        
//        print("userInfo", userInfo)
//        print("notificationId", notificationId!)
//        print("commentId", commentId!)
//        print("userId", userId!)
//        print("notificationName", notificationName!)
//        
//        //You can either present alert ,sound or increase badge while the app is in foreground too with ios 10
//        //to distinguish between notifications
//        
//        //if current login user has the same notificationId ignore notification
//        if loginId == userId!
//        {
//            //completionHandler()
//            
//            print("Tapped in notification same Id")
//        }
//        else
//        {
//            
//            //completionHandler()
//            
//            if badgeNumber == 0
//            {
//                tabBarController?.tabBar.items?[2].badgeValue = nil
//            }
//            else
//            {
//                tabBarController?.tabBar.items?[2].badgeValue = "\(badgeNumber)"
//            }
//            
//            //let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//            
//            //let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ChallengeArt") as! ChallengerArtViewController
//           // self.presentViewController(nextViewController, animated:true, completion:nil)
//            
//          //  let nextViewController = ChallengerArtViewController()
//            self.performSegue(withIdentifier: "unwindToThisNotificationController", sender: self)
//            
//        }
//    }
//    
//    
//}

//
//  PostStore.swift
//  Glance
//
//  Created by Jonah Starling on 4/30/16.
//  Copyright © 2016 In The Belly. All rights reserved.
//

import UIKit

class PostStore {
    static let sharedInstance:PostStore = PostStore()
    
    var allPosts = [Post]()
    
    func addPost(newPost: Post) {
        allPosts.append(newPost)
    }
    
    func addMultiplePosts(newPosts: [Post]) {
        allPosts += newPosts
    }
    
    func replaceAllPosts(newPosts: [Post]) {
        allPosts.removeAll()
        allPosts = newPosts
    }
    
    func removeAllPosts() {
        allPosts.removeAll()
    }
    
    func getCount() -> Int {
        return allPosts.count
    }
    
    func getPostAt(index: Int) -> Post {
        return allPosts[index]
    }
}
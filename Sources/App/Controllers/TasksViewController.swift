//
//  TasksViewController.swift
//  TODOListVapor
//
//  Created by Hayden Goldman on 5/15/17.
//
//

import Foundation
import Vapor
import HTTP
import VaporSQLite

class Task : NodeRepresentable {
    
    var taskId :Int!
    var title :String!
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node :["taskId":self.taskId,"title":self.title])
    }
}

extension Task {
    convenience init?(node :Node) {
        self.init()
        
        guard let taskId  = node["taskId"]?.int,
            let title = node["title"]?.string else {
                return nil
        }
        
        self.taskId = taskId
        self.title = title
    }
}


final class TasksViewController {
    
    func addRoutes (drop :Droplet) {
        
        drop.get("tasks","all",handler :getAll)
        
    }
    
    func getAll(_req :Request) throws -> ResponseRepresentable {
        
        let result = try drop.database?.driver.raw("SELECT taskId, title from Tasks;")
        
        guard let nodes = result?.nodeArray else {
            return try JSON(node :[])
        }
        
        let tasks = nodes.flatMap(Task.init)
        
        return try JSON(node :tasks)
    }
    
    
}

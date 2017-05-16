import Vapor
import HTTP
//import VaporSQLite
import PostgreSQL
import VaporPostgreSQL

let drop = Droplet()

try drop.addProvider(VaporPostgreSQL.Provider.self)


let controller = TasksViewController()

controller.addRoutes(drop: drop)


drop.get("") { request in
    
    let result = try drop.database?.driver.raw("SELECT id, title from tasks;")
    
    
    guard let nodes = result?.nodeArray else {
        return try JSON(node :[])
    }
    
    let tasks = nodes.flatMap(Task.init)
    
    return try drop.view.make("index", ["tasks" : tasks.makeNode()])
    
}

drop.post("tasks") { request in
    
    guard let title = request.data["title"]?.string else {
        throw Abort.badRequest
    }
    
    let result = try drop.database?.driver.raw("INSERT INTO tasks(title) VALUES($1)",[title])
    
    return Response(redirect:"/")
}

drop.post("tasks","remove") { request in
    
    guard let id = request.data["id"]?.int else {
        throw Abort.badRequest
    }
    
    let result = try drop.database?.driver.raw("DELETE FROM tasks WHERE id = $1",[id])
    
    return Response(redirect:"/")
    
}



drop.run()

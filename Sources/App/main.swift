import Vapor
import HTTP
import VaporSQLite

let drop = Droplet()

try drop.addProvider(VaporSQLite.Provider.self)

let controller = TasksViewController()

controller.addRoutes(drop: drop)

drop.run()

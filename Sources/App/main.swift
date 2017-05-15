import Vapor
import HTTP
import VaporSQLite

let drop = Droplet()

try drop.addProvider(VaporSQLite.Provider.self)

drop.run()

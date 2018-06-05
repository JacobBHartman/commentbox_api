import FluentMySQL
import Vapor

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    /// Register providers first
    try services.register(FluentMySQLProvider())

    /// Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    let myService = NIOServerConfig.default(hostname: "0.0.0.0", port: 5000)
    services.register(myService)

    /// Register middleware
    var middlewares = MiddlewareConfig()
    middlewares.use(ErrorMiddleware.self)
    services.register(middlewares)

    /// Register the configured SQLite database to the database config.
    let mysqlConfig = MySQLDatabaseConfig(
        hostname: "localhost",
        port: 3306,
        username: "root",
        password: "root",
        database: "comment_db")
    services.register(mysqlConfig)

    /// Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: Comment.self, database: .mysql)
    services.register(migrations)

}

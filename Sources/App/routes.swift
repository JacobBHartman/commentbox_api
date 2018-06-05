import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }

    // Example of configuring a controller
    let commentController = CommentController()
    router.get("comments", use: commentController.index)
    router.post("comments", use: commentController.create)
    router.delete("comments", Comment.parameter, use: commentController.delete)
}

import Vapor

/// Controls basic CRUD operations on `Comment`s.
final class CommentController {
    /// Returns a list of all `Comment`s.
    func index(_ req: Request) throws -> Future<[Comment]> {
        return Comment.query(on: req).all()
    }

    /// Saves a decoded `Comment` to the database.
    func create(_ req: Request) throws -> Future<Comment> {
        return try req.content.decode(Comment.self).flatMap { comment in
            return comment.save(on: req)
        }
    }

    /// Deletes a parameterized `Comment`.
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Comment.self).flatMap { comment in
            return comment.delete(on: req)
        }.transform(to: .ok)
    }
}

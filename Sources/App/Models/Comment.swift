import FluentMySQL
import Vapor

/// A single entry of a Comment.
final class Comment: MySQLModel {
    var id: Int?
    var placeID: String
    var actual: String
    
    /// Creates a new `Comment`.
    init(id: Int? = nil, placeID: String, actual: String) {
        self.id = id
	self.placeID = placeID
        self.actual = actual
    }
}

/// Allows `Comment` to be used as a dynamic migration.
extension Comment: Migration { }

/// Allows `Comment` to be encoded to and decoded from HTTP messages.
extension Comment: Content { }

/// Allows `Comment` to be used as a dynamic parameter in route definitions.
extension Comment: Parameter { }

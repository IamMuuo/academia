/// DatabaseOperations.
///
/// An abstract class that defines the CRUD operations.
/// All model helpers should implement this class to
/// ensure consistency within the codebase.
abstract class DatabaseOperations {
  /// Create.
  /// For inserting data.
  Future<int> create(Map<String, dynamic> data);

  /// queryAll.
  /// should return all data in a table.
  Future<List<Map<String, dynamic>>> queryAll();

  /// update.
  /// Should update an entity in a table.
  Future<int> update(Map<String, dynamic> data);

  /// Delete.
  /// Should delete an entity from a table.
  Future<int> delete(int id);
}

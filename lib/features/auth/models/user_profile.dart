import 'package:drift/drift.dart';
import './user.dart';

class UserProfile extends Table {
  @JsonKey("user_id")
  TextColumn get userId => text().references(User, #id)();

  TextColumn get bio => text().nullable()();
  @JsonKey("vibe_points")
  IntColumn get vibePoints => integer().withDefault(const Constant(0))();
  @JsonKey("profile_picture_url")
  TextColumn get profilePictureUrl => text().nullable()();
  @JsonKey("last_seen")
  DateTimeColumn get lastSeen =>
      dateTime().withDefault(Constant(DateTime.now()))();
  @JsonKey("created_at")
  DateTimeColumn get createdAt =>
      dateTime().withDefault(Constant(DateTime.now()))();
  @JsonKey("modified_at")
  DateTimeColumn get modifiedAt =>
      dateTime().withDefault(Constant(DateTime.now()))();
  @JsonKey("admission_number")
  TextColumn get admissionNumber => text().nullable()();
  @JsonKey("campus")
  TextColumn get campus => text().withDefault(const Constant("athi"))();
  @JsonKey("date_of_birth")
  DateTimeColumn get dateOfBirth => dateTime()();

  @override
  Set<Column<Object>>? get primaryKey => {userId};
}

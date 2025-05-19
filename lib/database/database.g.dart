// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $AttendanceModelTable extends AttendanceModel
    with TableInfo<$AttendanceModelTable, AttendanceModelData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttendanceModelTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _studentIDMeta =
      const VerificationMeta('studentID');
  @override
  late final GeneratedColumn<String> studentID = GeneratedColumn<String>(
      'student_i_d', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  static const VerificationMeta _checkInMeta =
      const VerificationMeta('checkIn');
  @override
  late final GeneratedColumn<String> checkIn = GeneratedColumn<String>(
      'check_in', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: Constant("present"));
  static const VerificationMeta _campusMeta = const VerificationMeta('campus');
  @override
  late final GeneratedColumn<String> campus = GeneratedColumn<String>(
      'campus', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: Constant("athi river"));
  @override
  List<GeneratedColumn> get $columns => [studentID, date, checkIn, campus];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attendance_model';
  @override
  VerificationContext validateIntegrity(
      Insertable<AttendanceModelData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('student_i_d')) {
      context.handle(
          _studentIDMeta,
          studentID.isAcceptableOrUnknown(
              data['student_i_d']!, _studentIDMeta));
    } else if (isInserting) {
      context.missing(_studentIDMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    }
    if (data.containsKey('check_in')) {
      context.handle(_checkInMeta,
          checkIn.isAcceptableOrUnknown(data['check_in']!, _checkInMeta));
    }
    if (data.containsKey('campus')) {
      context.handle(_campusMeta,
          campus.isAcceptableOrUnknown(data['campus']!, _campusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  AttendanceModelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AttendanceModelData(
      studentID: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}student_i_d'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      checkIn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}check_in'])!,
      campus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}campus'])!,
    );
  }

  @override
  $AttendanceModelTable createAlias(String alias) {
    return $AttendanceModelTable(attachedDatabase, alias);
  }
}

class AttendanceModelData extends DataClass
    implements Insertable<AttendanceModelData> {
  final String studentID;
  final DateTime date;
  final String checkIn;
  final String campus;
  const AttendanceModelData(
      {required this.studentID,
      required this.date,
      required this.checkIn,
      required this.campus});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['student_i_d'] = Variable<String>(studentID);
    map['date'] = Variable<DateTime>(date);
    map['check_in'] = Variable<String>(checkIn);
    map['campus'] = Variable<String>(campus);
    return map;
  }

  AttendanceModelCompanion toCompanion(bool nullToAbsent) {
    return AttendanceModelCompanion(
      studentID: Value(studentID),
      date: Value(date),
      checkIn: Value(checkIn),
      campus: Value(campus),
    );
  }

  factory AttendanceModelData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AttendanceModelData(
      studentID: serializer.fromJson<String>(json['student_id']),
      date: serializer.fromJson<DateTime>(json['date']),
      checkIn: serializer.fromJson<String>(json['check_in']),
      campus: serializer.fromJson<String>(json['campus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'student_id': serializer.toJson<String>(studentID),
      'date': serializer.toJson<DateTime>(date),
      'check_in': serializer.toJson<String>(checkIn),
      'campus': serializer.toJson<String>(campus),
    };
  }

  AttendanceModelData copyWith(
          {String? studentID,
          DateTime? date,
          String? checkIn,
          String? campus}) =>
      AttendanceModelData(
        studentID: studentID ?? this.studentID,
        date: date ?? this.date,
        checkIn: checkIn ?? this.checkIn,
        campus: campus ?? this.campus,
      );
  AttendanceModelData copyWithCompanion(AttendanceModelCompanion data) {
    return AttendanceModelData(
      studentID: data.studentID.present ? data.studentID.value : this.studentID,
      date: data.date.present ? data.date.value : this.date,
      checkIn: data.checkIn.present ? data.checkIn.value : this.checkIn,
      campus: data.campus.present ? data.campus.value : this.campus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AttendanceModelData(')
          ..write('studentID: $studentID, ')
          ..write('date: $date, ')
          ..write('checkIn: $checkIn, ')
          ..write('campus: $campus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(studentID, date, checkIn, campus);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AttendanceModelData &&
          other.studentID == this.studentID &&
          other.date == this.date &&
          other.checkIn == this.checkIn &&
          other.campus == this.campus);
}

class AttendanceModelCompanion extends UpdateCompanion<AttendanceModelData> {
  final Value<String> studentID;
  final Value<DateTime> date;
  final Value<String> checkIn;
  final Value<String> campus;
  final Value<int> rowid;
  const AttendanceModelCompanion({
    this.studentID = const Value.absent(),
    this.date = const Value.absent(),
    this.checkIn = const Value.absent(),
    this.campus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AttendanceModelCompanion.insert({
    required String studentID,
    this.date = const Value.absent(),
    this.checkIn = const Value.absent(),
    this.campus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : studentID = Value(studentID);
  static Insertable<AttendanceModelData> custom({
    Expression<String>? studentID,
    Expression<DateTime>? date,
    Expression<String>? checkIn,
    Expression<String>? campus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (studentID != null) 'student_i_d': studentID,
      if (date != null) 'date': date,
      if (checkIn != null) 'check_in': checkIn,
      if (campus != null) 'campus': campus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AttendanceModelCompanion copyWith(
      {Value<String>? studentID,
      Value<DateTime>? date,
      Value<String>? checkIn,
      Value<String>? campus,
      Value<int>? rowid}) {
    return AttendanceModelCompanion(
      studentID: studentID ?? this.studentID,
      date: date ?? this.date,
      checkIn: checkIn ?? this.checkIn,
      campus: campus ?? this.campus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (studentID.present) {
      map['student_i_d'] = Variable<String>(studentID.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (checkIn.present) {
      map['check_in'] = Variable<String>(checkIn.value);
    }
    if (campus.present) {
      map['campus'] = Variable<String>(campus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttendanceModelCompanion(')
          ..write('studentID: $studentID, ')
          ..write('date: $date, ')
          ..write('checkIn: $checkIn, ')
          ..write('campus: $campus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserTable extends User with TableInfo<$UserTable, UserData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _usernameMeta =
      const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _firstnameMeta =
      const VerificationMeta('firstname');
  @override
  late final GeneratedColumn<String> firstname = GeneratedColumn<String>(
      'firstname', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _othernamesMeta =
      const VerificationMeta('othernames');
  @override
  late final GeneratedColumn<String> othernames = GeneratedColumn<String>(
      'othernames', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 5, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 10),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
      'active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _pictureMeta =
      const VerificationMeta('picture');
  @override
  late final GeneratedColumn<Uint8List> picture = GeneratedColumn<Uint8List>(
      'picture', aliasedName, true,
      type: DriftSqlType.blob, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _modifiedAtMeta =
      const VerificationMeta('modifiedAt');
  @override
  late final GeneratedColumn<DateTime> modifiedAt = GeneratedColumn<DateTime>(
      'modified_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _nationalIdMeta =
      const VerificationMeta('nationalId');
  @override
  late final GeneratedColumn<String> nationalId = GeneratedColumn<String>(
      'national_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        username,
        firstname,
        othernames,
        phone,
        email,
        gender,
        active,
        picture,
        createdAt,
        modifiedAt,
        nationalId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user';
  @override
  VerificationContext validateIntegrity(Insertable<UserData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('firstname')) {
      context.handle(_firstnameMeta,
          firstname.isAcceptableOrUnknown(data['firstname']!, _firstnameMeta));
    } else if (isInserting) {
      context.missing(_firstnameMeta);
    }
    if (data.containsKey('othernames')) {
      context.handle(
          _othernamesMeta,
          othernames.isAcceptableOrUnknown(
              data['othernames']!, _othernamesMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    } else if (isInserting) {
      context.missing(_genderMeta);
    }
    if (data.containsKey('active')) {
      context.handle(_activeMeta,
          active.isAcceptableOrUnknown(data['active']!, _activeMeta));
    }
    if (data.containsKey('picture')) {
      context.handle(_pictureMeta,
          picture.isAcceptableOrUnknown(data['picture']!, _pictureMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('modified_at')) {
      context.handle(
          _modifiedAtMeta,
          modifiedAt.isAcceptableOrUnknown(
              data['modified_at']!, _modifiedAtMeta));
    } else if (isInserting) {
      context.missing(_modifiedAtMeta);
    }
    if (data.containsKey('national_id')) {
      context.handle(
          _nationalIdMeta,
          nationalId.isAcceptableOrUnknown(
              data['national_id']!, _nationalIdMeta));
    } else if (isInserting) {
      context.missing(_nationalIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username'])!,
      firstname: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}firstname'])!,
      othernames: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}othernames']),
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender'])!,
      active: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}active'])!,
      picture: attachedDatabase.typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}picture']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      modifiedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}modified_at'])!,
      nationalId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}national_id'])!,
    );
  }

  @override
  $UserTable createAlias(String alias) {
    return $UserTable(attachedDatabase, alias);
  }
}

class UserData extends DataClass implements Insertable<UserData> {
  final String id;
  final String username;
  final String firstname;
  final String? othernames;
  final String? phone;
  final String? email;
  final String gender;
  final bool active;
  final Uint8List? picture;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final String nationalId;
  const UserData(
      {required this.id,
      required this.username,
      required this.firstname,
      this.othernames,
      this.phone,
      this.email,
      required this.gender,
      required this.active,
      this.picture,
      required this.createdAt,
      required this.modifiedAt,
      required this.nationalId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['username'] = Variable<String>(username);
    map['firstname'] = Variable<String>(firstname);
    if (!nullToAbsent || othernames != null) {
      map['othernames'] = Variable<String>(othernames);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    map['gender'] = Variable<String>(gender);
    map['active'] = Variable<bool>(active);
    if (!nullToAbsent || picture != null) {
      map['picture'] = Variable<Uint8List>(picture);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['modified_at'] = Variable<DateTime>(modifiedAt);
    map['national_id'] = Variable<String>(nationalId);
    return map;
  }

  UserCompanion toCompanion(bool nullToAbsent) {
    return UserCompanion(
      id: Value(id),
      username: Value(username),
      firstname: Value(firstname),
      othernames: othernames == null && nullToAbsent
          ? const Value.absent()
          : Value(othernames),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      gender: Value(gender),
      active: Value(active),
      picture: picture == null && nullToAbsent
          ? const Value.absent()
          : Value(picture),
      createdAt: Value(createdAt),
      modifiedAt: Value(modifiedAt),
      nationalId: Value(nationalId),
    );
  }

  factory UserData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserData(
      id: serializer.fromJson<String>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      firstname: serializer.fromJson<String>(json['firstname']),
      othernames: serializer.fromJson<String?>(json['othernames']),
      phone: serializer.fromJson<String?>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
      gender: serializer.fromJson<String>(json['gender']),
      active: serializer.fromJson<bool>(json['active']),
      picture: serializer.fromJson<Uint8List?>(json['profile_picture']),
      createdAt: serializer.fromJson<DateTime>(json['created_at']),
      modifiedAt: serializer.fromJson<DateTime>(json['modified_at']),
      nationalId: serializer.fromJson<String>(json['national_id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'username': serializer.toJson<String>(username),
      'firstname': serializer.toJson<String>(firstname),
      'othernames': serializer.toJson<String?>(othernames),
      'phone': serializer.toJson<String?>(phone),
      'email': serializer.toJson<String?>(email),
      'gender': serializer.toJson<String>(gender),
      'active': serializer.toJson<bool>(active),
      'profile_picture': serializer.toJson<Uint8List?>(picture),
      'created_at': serializer.toJson<DateTime>(createdAt),
      'modified_at': serializer.toJson<DateTime>(modifiedAt),
      'national_id': serializer.toJson<String>(nationalId),
    };
  }

  UserData copyWith(
          {String? id,
          String? username,
          String? firstname,
          Value<String?> othernames = const Value.absent(),
          Value<String?> phone = const Value.absent(),
          Value<String?> email = const Value.absent(),
          String? gender,
          bool? active,
          Value<Uint8List?> picture = const Value.absent(),
          DateTime? createdAt,
          DateTime? modifiedAt,
          String? nationalId}) =>
      UserData(
        id: id ?? this.id,
        username: username ?? this.username,
        firstname: firstname ?? this.firstname,
        othernames: othernames.present ? othernames.value : this.othernames,
        phone: phone.present ? phone.value : this.phone,
        email: email.present ? email.value : this.email,
        gender: gender ?? this.gender,
        active: active ?? this.active,
        picture: picture.present ? picture.value : this.picture,
        createdAt: createdAt ?? this.createdAt,
        modifiedAt: modifiedAt ?? this.modifiedAt,
        nationalId: nationalId ?? this.nationalId,
      );
  UserData copyWithCompanion(UserCompanion data) {
    return UserData(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      firstname: data.firstname.present ? data.firstname.value : this.firstname,
      othernames:
          data.othernames.present ? data.othernames.value : this.othernames,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      gender: data.gender.present ? data.gender.value : this.gender,
      active: data.active.present ? data.active.value : this.active,
      picture: data.picture.present ? data.picture.value : this.picture,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      modifiedAt:
          data.modifiedAt.present ? data.modifiedAt.value : this.modifiedAt,
      nationalId:
          data.nationalId.present ? data.nationalId.value : this.nationalId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserData(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('firstname: $firstname, ')
          ..write('othernames: $othernames, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('gender: $gender, ')
          ..write('active: $active, ')
          ..write('picture: $picture, ')
          ..write('createdAt: $createdAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('nationalId: $nationalId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      username,
      firstname,
      othernames,
      phone,
      email,
      gender,
      active,
      $driftBlobEquality.hash(picture),
      createdAt,
      modifiedAt,
      nationalId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserData &&
          other.id == this.id &&
          other.username == this.username &&
          other.firstname == this.firstname &&
          other.othernames == this.othernames &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.gender == this.gender &&
          other.active == this.active &&
          $driftBlobEquality.equals(other.picture, this.picture) &&
          other.createdAt == this.createdAt &&
          other.modifiedAt == this.modifiedAt &&
          other.nationalId == this.nationalId);
}

class UserCompanion extends UpdateCompanion<UserData> {
  final Value<String> id;
  final Value<String> username;
  final Value<String> firstname;
  final Value<String?> othernames;
  final Value<String?> phone;
  final Value<String?> email;
  final Value<String> gender;
  final Value<bool> active;
  final Value<Uint8List?> picture;
  final Value<DateTime> createdAt;
  final Value<DateTime> modifiedAt;
  final Value<String> nationalId;
  final Value<int> rowid;
  const UserCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.firstname = const Value.absent(),
    this.othernames = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.gender = const Value.absent(),
    this.active = const Value.absent(),
    this.picture = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
    this.nationalId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserCompanion.insert({
    required String id,
    required String username,
    required String firstname,
    this.othernames = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    required String gender,
    this.active = const Value.absent(),
    this.picture = const Value.absent(),
    required DateTime createdAt,
    required DateTime modifiedAt,
    required String nationalId,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        username = Value(username),
        firstname = Value(firstname),
        gender = Value(gender),
        createdAt = Value(createdAt),
        modifiedAt = Value(modifiedAt),
        nationalId = Value(nationalId);
  static Insertable<UserData> custom({
    Expression<String>? id,
    Expression<String>? username,
    Expression<String>? firstname,
    Expression<String>? othernames,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? gender,
    Expression<bool>? active,
    Expression<Uint8List>? picture,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? modifiedAt,
    Expression<String>? nationalId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (firstname != null) 'firstname': firstname,
      if (othernames != null) 'othernames': othernames,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (gender != null) 'gender': gender,
      if (active != null) 'active': active,
      if (picture != null) 'picture': picture,
      if (createdAt != null) 'created_at': createdAt,
      if (modifiedAt != null) 'modified_at': modifiedAt,
      if (nationalId != null) 'national_id': nationalId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserCompanion copyWith(
      {Value<String>? id,
      Value<String>? username,
      Value<String>? firstname,
      Value<String?>? othernames,
      Value<String?>? phone,
      Value<String?>? email,
      Value<String>? gender,
      Value<bool>? active,
      Value<Uint8List?>? picture,
      Value<DateTime>? createdAt,
      Value<DateTime>? modifiedAt,
      Value<String>? nationalId,
      Value<int>? rowid}) {
    return UserCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      firstname: firstname ?? this.firstname,
      othernames: othernames ?? this.othernames,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      active: active ?? this.active,
      picture: picture ?? this.picture,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      nationalId: nationalId ?? this.nationalId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (firstname.present) {
      map['firstname'] = Variable<String>(firstname.value);
    }
    if (othernames.present) {
      map['othernames'] = Variable<String>(othernames.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (picture.present) {
      map['picture'] = Variable<Uint8List>(picture.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (modifiedAt.present) {
      map['modified_at'] = Variable<DateTime>(modifiedAt.value);
    }
    if (nationalId.present) {
      map['national_id'] = Variable<String>(nationalId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('firstname: $firstname, ')
          ..write('othernames: $othernames, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('gender: $gender, ')
          ..write('active: $active, ')
          ..write('picture: $picture, ')
          ..write('createdAt: $createdAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('nationalId: $nationalId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserProfileTable extends UserProfile
    with TableInfo<$UserProfileTable, UserProfileData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfileTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES user (id)'));
  static const VerificationMeta _bioMeta = const VerificationMeta('bio');
  @override
  late final GeneratedColumn<String> bio = GeneratedColumn<String>(
      'bio', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _vibePointsMeta =
      const VerificationMeta('vibePoints');
  @override
  late final GeneratedColumn<int> vibePoints = GeneratedColumn<int>(
      'vibe_points', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _profilePictureUrlMeta =
      const VerificationMeta('profilePictureUrl');
  @override
  late final GeneratedColumn<String> profilePictureUrl =
      GeneratedColumn<String>('profile_picture_url', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastSeenMeta =
      const VerificationMeta('lastSeen');
  @override
  late final GeneratedColumn<DateTime> lastSeen = GeneratedColumn<DateTime>(
      'last_seen', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  static const VerificationMeta _modifiedAtMeta =
      const VerificationMeta('modifiedAt');
  @override
  late final GeneratedColumn<DateTime> modifiedAt = GeneratedColumn<DateTime>(
      'modified_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  static const VerificationMeta _admissionNumberMeta =
      const VerificationMeta('admissionNumber');
  @override
  late final GeneratedColumn<String> admissionNumber = GeneratedColumn<String>(
      'admission_number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _campusMeta = const VerificationMeta('campus');
  @override
  late final GeneratedColumn<String> campus = GeneratedColumn<String>(
      'campus', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant("athi"));
  static const VerificationMeta _dateOfBirthMeta =
      const VerificationMeta('dateOfBirth');
  @override
  late final GeneratedColumn<DateTime> dateOfBirth = GeneratedColumn<DateTime>(
      'date_of_birth', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        userId,
        bio,
        vibePoints,
        profilePictureUrl,
        lastSeen,
        createdAt,
        modifiedAt,
        admissionNumber,
        campus,
        dateOfBirth
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profile';
  @override
  VerificationContext validateIntegrity(Insertable<UserProfileData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('bio')) {
      context.handle(
          _bioMeta, bio.isAcceptableOrUnknown(data['bio']!, _bioMeta));
    }
    if (data.containsKey('vibe_points')) {
      context.handle(
          _vibePointsMeta,
          vibePoints.isAcceptableOrUnknown(
              data['vibe_points']!, _vibePointsMeta));
    }
    if (data.containsKey('profile_picture_url')) {
      context.handle(
          _profilePictureUrlMeta,
          profilePictureUrl.isAcceptableOrUnknown(
              data['profile_picture_url']!, _profilePictureUrlMeta));
    }
    if (data.containsKey('last_seen')) {
      context.handle(_lastSeenMeta,
          lastSeen.isAcceptableOrUnknown(data['last_seen']!, _lastSeenMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('modified_at')) {
      context.handle(
          _modifiedAtMeta,
          modifiedAt.isAcceptableOrUnknown(
              data['modified_at']!, _modifiedAtMeta));
    }
    if (data.containsKey('admission_number')) {
      context.handle(
          _admissionNumberMeta,
          admissionNumber.isAcceptableOrUnknown(
              data['admission_number']!, _admissionNumberMeta));
    } else if (isInserting) {
      context.missing(_admissionNumberMeta);
    }
    if (data.containsKey('campus')) {
      context.handle(_campusMeta,
          campus.isAcceptableOrUnknown(data['campus']!, _campusMeta));
    }
    if (data.containsKey('date_of_birth')) {
      context.handle(
          _dateOfBirthMeta,
          dateOfBirth.isAcceptableOrUnknown(
              data['date_of_birth']!, _dateOfBirthMeta));
    } else if (isInserting) {
      context.missing(_dateOfBirthMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId};
  @override
  UserProfileData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfileData(
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      bio: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}bio']),
      vibePoints: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}vibe_points'])!,
      profilePictureUrl: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}profile_picture_url']),
      lastSeen: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_seen'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      modifiedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}modified_at'])!,
      admissionNumber: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}admission_number'])!,
      campus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}campus']),
      dateOfBirth: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}date_of_birth'])!,
    );
  }

  @override
  $UserProfileTable createAlias(String alias) {
    return $UserProfileTable(attachedDatabase, alias);
  }
}

class UserProfileData extends DataClass implements Insertable<UserProfileData> {
  final String userId;
  final String? bio;
  final int vibePoints;
  final String? profilePictureUrl;
  final DateTime lastSeen;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final String admissionNumber;
  final String? campus;
  final DateTime dateOfBirth;
  const UserProfileData(
      {required this.userId,
      this.bio,
      required this.vibePoints,
      this.profilePictureUrl,
      required this.lastSeen,
      required this.createdAt,
      required this.modifiedAt,
      required this.admissionNumber,
      this.campus,
      required this.dateOfBirth});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    if (!nullToAbsent || bio != null) {
      map['bio'] = Variable<String>(bio);
    }
    map['vibe_points'] = Variable<int>(vibePoints);
    if (!nullToAbsent || profilePictureUrl != null) {
      map['profile_picture_url'] = Variable<String>(profilePictureUrl);
    }
    map['last_seen'] = Variable<DateTime>(lastSeen);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['modified_at'] = Variable<DateTime>(modifiedAt);
    map['admission_number'] = Variable<String>(admissionNumber);
    if (!nullToAbsent || campus != null) {
      map['campus'] = Variable<String>(campus);
    }
    map['date_of_birth'] = Variable<DateTime>(dateOfBirth);
    return map;
  }

  UserProfileCompanion toCompanion(bool nullToAbsent) {
    return UserProfileCompanion(
      userId: Value(userId),
      bio: bio == null && nullToAbsent ? const Value.absent() : Value(bio),
      vibePoints: Value(vibePoints),
      profilePictureUrl: profilePictureUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(profilePictureUrl),
      lastSeen: Value(lastSeen),
      createdAt: Value(createdAt),
      modifiedAt: Value(modifiedAt),
      admissionNumber: Value(admissionNumber),
      campus:
          campus == null && nullToAbsent ? const Value.absent() : Value(campus),
      dateOfBirth: Value(dateOfBirth),
    );
  }

  factory UserProfileData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfileData(
      userId: serializer.fromJson<String>(json['user_id']),
      bio: serializer.fromJson<String?>(json['bio']),
      vibePoints: serializer.fromJson<int>(json['vibe_points']),
      profilePictureUrl:
          serializer.fromJson<String?>(json['profile_picture_url']),
      lastSeen: serializer.fromJson<DateTime>(json['last_seen']),
      createdAt: serializer.fromJson<DateTime>(json['created_at']),
      modifiedAt: serializer.fromJson<DateTime>(json['modified_at']),
      admissionNumber: serializer.fromJson<String>(json['admission_number']),
      campus: serializer.fromJson<String?>(json['campus']),
      dateOfBirth: serializer.fromJson<DateTime>(json['date_of_birth']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'user_id': serializer.toJson<String>(userId),
      'bio': serializer.toJson<String?>(bio),
      'vibe_points': serializer.toJson<int>(vibePoints),
      'profile_picture_url': serializer.toJson<String?>(profilePictureUrl),
      'last_seen': serializer.toJson<DateTime>(lastSeen),
      'created_at': serializer.toJson<DateTime>(createdAt),
      'modified_at': serializer.toJson<DateTime>(modifiedAt),
      'admission_number': serializer.toJson<String>(admissionNumber),
      'campus': serializer.toJson<String?>(campus),
      'date_of_birth': serializer.toJson<DateTime>(dateOfBirth),
    };
  }

  UserProfileData copyWith(
          {String? userId,
          Value<String?> bio = const Value.absent(),
          int? vibePoints,
          Value<String?> profilePictureUrl = const Value.absent(),
          DateTime? lastSeen,
          DateTime? createdAt,
          DateTime? modifiedAt,
          String? admissionNumber,
          Value<String?> campus = const Value.absent(),
          DateTime? dateOfBirth}) =>
      UserProfileData(
        userId: userId ?? this.userId,
        bio: bio.present ? bio.value : this.bio,
        vibePoints: vibePoints ?? this.vibePoints,
        profilePictureUrl: profilePictureUrl.present
            ? profilePictureUrl.value
            : this.profilePictureUrl,
        lastSeen: lastSeen ?? this.lastSeen,
        createdAt: createdAt ?? this.createdAt,
        modifiedAt: modifiedAt ?? this.modifiedAt,
        admissionNumber: admissionNumber ?? this.admissionNumber,
        campus: campus.present ? campus.value : this.campus,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      );
  UserProfileData copyWithCompanion(UserProfileCompanion data) {
    return UserProfileData(
      userId: data.userId.present ? data.userId.value : this.userId,
      bio: data.bio.present ? data.bio.value : this.bio,
      vibePoints:
          data.vibePoints.present ? data.vibePoints.value : this.vibePoints,
      profilePictureUrl: data.profilePictureUrl.present
          ? data.profilePictureUrl.value
          : this.profilePictureUrl,
      lastSeen: data.lastSeen.present ? data.lastSeen.value : this.lastSeen,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      modifiedAt:
          data.modifiedAt.present ? data.modifiedAt.value : this.modifiedAt,
      admissionNumber: data.admissionNumber.present
          ? data.admissionNumber.value
          : this.admissionNumber,
      campus: data.campus.present ? data.campus.value : this.campus,
      dateOfBirth:
          data.dateOfBirth.present ? data.dateOfBirth.value : this.dateOfBirth,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfileData(')
          ..write('userId: $userId, ')
          ..write('bio: $bio, ')
          ..write('vibePoints: $vibePoints, ')
          ..write('profilePictureUrl: $profilePictureUrl, ')
          ..write('lastSeen: $lastSeen, ')
          ..write('createdAt: $createdAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('admissionNumber: $admissionNumber, ')
          ..write('campus: $campus, ')
          ..write('dateOfBirth: $dateOfBirth')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(userId, bio, vibePoints, profilePictureUrl,
      lastSeen, createdAt, modifiedAt, admissionNumber, campus, dateOfBirth);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfileData &&
          other.userId == this.userId &&
          other.bio == this.bio &&
          other.vibePoints == this.vibePoints &&
          other.profilePictureUrl == this.profilePictureUrl &&
          other.lastSeen == this.lastSeen &&
          other.createdAt == this.createdAt &&
          other.modifiedAt == this.modifiedAt &&
          other.admissionNumber == this.admissionNumber &&
          other.campus == this.campus &&
          other.dateOfBirth == this.dateOfBirth);
}

class UserProfileCompanion extends UpdateCompanion<UserProfileData> {
  final Value<String> userId;
  final Value<String?> bio;
  final Value<int> vibePoints;
  final Value<String?> profilePictureUrl;
  final Value<DateTime> lastSeen;
  final Value<DateTime> createdAt;
  final Value<DateTime> modifiedAt;
  final Value<String> admissionNumber;
  final Value<String?> campus;
  final Value<DateTime> dateOfBirth;
  final Value<int> rowid;
  const UserProfileCompanion({
    this.userId = const Value.absent(),
    this.bio = const Value.absent(),
    this.vibePoints = const Value.absent(),
    this.profilePictureUrl = const Value.absent(),
    this.lastSeen = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
    this.admissionNumber = const Value.absent(),
    this.campus = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserProfileCompanion.insert({
    required String userId,
    this.bio = const Value.absent(),
    this.vibePoints = const Value.absent(),
    this.profilePictureUrl = const Value.absent(),
    this.lastSeen = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
    required String admissionNumber,
    this.campus = const Value.absent(),
    required DateTime dateOfBirth,
    this.rowid = const Value.absent(),
  })  : userId = Value(userId),
        admissionNumber = Value(admissionNumber),
        dateOfBirth = Value(dateOfBirth);
  static Insertable<UserProfileData> custom({
    Expression<String>? userId,
    Expression<String>? bio,
    Expression<int>? vibePoints,
    Expression<String>? profilePictureUrl,
    Expression<DateTime>? lastSeen,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? modifiedAt,
    Expression<String>? admissionNumber,
    Expression<String>? campus,
    Expression<DateTime>? dateOfBirth,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (bio != null) 'bio': bio,
      if (vibePoints != null) 'vibe_points': vibePoints,
      if (profilePictureUrl != null) 'profile_picture_url': profilePictureUrl,
      if (lastSeen != null) 'last_seen': lastSeen,
      if (createdAt != null) 'created_at': createdAt,
      if (modifiedAt != null) 'modified_at': modifiedAt,
      if (admissionNumber != null) 'admission_number': admissionNumber,
      if (campus != null) 'campus': campus,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserProfileCompanion copyWith(
      {Value<String>? userId,
      Value<String?>? bio,
      Value<int>? vibePoints,
      Value<String?>? profilePictureUrl,
      Value<DateTime>? lastSeen,
      Value<DateTime>? createdAt,
      Value<DateTime>? modifiedAt,
      Value<String>? admissionNumber,
      Value<String?>? campus,
      Value<DateTime>? dateOfBirth,
      Value<int>? rowid}) {
    return UserProfileCompanion(
      userId: userId ?? this.userId,
      bio: bio ?? this.bio,
      vibePoints: vibePoints ?? this.vibePoints,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      lastSeen: lastSeen ?? this.lastSeen,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      admissionNumber: admissionNumber ?? this.admissionNumber,
      campus: campus ?? this.campus,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (bio.present) {
      map['bio'] = Variable<String>(bio.value);
    }
    if (vibePoints.present) {
      map['vibe_points'] = Variable<int>(vibePoints.value);
    }
    if (profilePictureUrl.present) {
      map['profile_picture_url'] = Variable<String>(profilePictureUrl.value);
    }
    if (lastSeen.present) {
      map['last_seen'] = Variable<DateTime>(lastSeen.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (modifiedAt.present) {
      map['modified_at'] = Variable<DateTime>(modifiedAt.value);
    }
    if (admissionNumber.present) {
      map['admission_number'] = Variable<String>(admissionNumber.value);
    }
    if (campus.present) {
      map['campus'] = Variable<String>(campus.value);
    }
    if (dateOfBirth.present) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfileCompanion(')
          ..write('userId: $userId, ')
          ..write('bio: $bio, ')
          ..write('vibePoints: $vibePoints, ')
          ..write('profilePictureUrl: $profilePictureUrl, ')
          ..write('lastSeen: $lastSeen, ')
          ..write('createdAt: $createdAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('admissionNumber: $admissionNumber, ')
          ..write('campus: $campus, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserCredentialTable extends UserCredential
    with TableInfo<$UserCredentialTable, UserCredentialData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserCredentialTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES user (id)'));
  static const VerificationMeta _admnoMeta = const VerificationMeta('admno');
  @override
  late final GeneratedColumn<String> admno = GeneratedColumn<String>(
      'admno', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _accessTokenMeta =
      const VerificationMeta('accessToken');
  @override
  late final GeneratedColumn<String> accessToken = GeneratedColumn<String>(
      'access_token', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _usernameMeta =
      const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES user (username)'));
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES user (email)'));
  static const VerificationMeta _passwordMeta =
      const VerificationMeta('password');
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
      'password', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastLoginMeta =
      const VerificationMeta('lastLogin');
  @override
  late final GeneratedColumn<DateTime> lastLogin = GeneratedColumn<DateTime>(
      'last_login', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [userId, admno, accessToken, username, email, password, lastLogin];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_credential';
  @override
  VerificationContext validateIntegrity(Insertable<UserCredentialData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('admno')) {
      context.handle(
          _admnoMeta, admno.isAcceptableOrUnknown(data['admno']!, _admnoMeta));
    }
    if (data.containsKey('access_token')) {
      context.handle(
          _accessTokenMeta,
          accessToken.isAcceptableOrUnknown(
              data['access_token']!, _accessTokenMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('last_login')) {
      context.handle(_lastLoginMeta,
          lastLogin.isAcceptableOrUnknown(data['last_login']!, _lastLoginMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId};
  @override
  UserCredentialData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserCredentialData(
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id']),
      admno: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}admno']),
      accessToken: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}access_token']),
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username']),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      password: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password'])!,
      lastLogin: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_login']),
    );
  }

  @override
  $UserCredentialTable createAlias(String alias) {
    return $UserCredentialTable(attachedDatabase, alias);
  }
}

class UserCredentialData extends DataClass
    implements Insertable<UserCredentialData> {
  final String? userId;
  final String? admno;
  final String? accessToken;
  final String? username;
  final String? email;
  final String password;
  final DateTime? lastLogin;
  const UserCredentialData(
      {this.userId,
      this.admno,
      this.accessToken,
      this.username,
      this.email,
      required this.password,
      this.lastLogin});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    if (!nullToAbsent || admno != null) {
      map['admno'] = Variable<String>(admno);
    }
    if (!nullToAbsent || accessToken != null) {
      map['access_token'] = Variable<String>(accessToken);
    }
    if (!nullToAbsent || username != null) {
      map['username'] = Variable<String>(username);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    map['password'] = Variable<String>(password);
    if (!nullToAbsent || lastLogin != null) {
      map['last_login'] = Variable<DateTime>(lastLogin);
    }
    return map;
  }

  UserCredentialCompanion toCompanion(bool nullToAbsent) {
    return UserCredentialCompanion(
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      admno:
          admno == null && nullToAbsent ? const Value.absent() : Value(admno),
      accessToken: accessToken == null && nullToAbsent
          ? const Value.absent()
          : Value(accessToken),
      username: username == null && nullToAbsent
          ? const Value.absent()
          : Value(username),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      password: Value(password),
      lastLogin: lastLogin == null && nullToAbsent
          ? const Value.absent()
          : Value(lastLogin),
    );
  }

  factory UserCredentialData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserCredentialData(
      userId: serializer.fromJson<String?>(json['user_id']),
      admno: serializer.fromJson<String?>(json['admission_number']),
      accessToken: serializer.fromJson<String?>(json['access_token']),
      username: serializer.fromJson<String?>(json['username']),
      email: serializer.fromJson<String?>(json['email']),
      password: serializer.fromJson<String>(json['password']),
      lastLogin: serializer.fromJson<DateTime?>(json['last_login']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'user_id': serializer.toJson<String?>(userId),
      'admission_number': serializer.toJson<String?>(admno),
      'access_token': serializer.toJson<String?>(accessToken),
      'username': serializer.toJson<String?>(username),
      'email': serializer.toJson<String?>(email),
      'password': serializer.toJson<String>(password),
      'last_login': serializer.toJson<DateTime?>(lastLogin),
    };
  }

  UserCredentialData copyWith(
          {Value<String?> userId = const Value.absent(),
          Value<String?> admno = const Value.absent(),
          Value<String?> accessToken = const Value.absent(),
          Value<String?> username = const Value.absent(),
          Value<String?> email = const Value.absent(),
          String? password,
          Value<DateTime?> lastLogin = const Value.absent()}) =>
      UserCredentialData(
        userId: userId.present ? userId.value : this.userId,
        admno: admno.present ? admno.value : this.admno,
        accessToken: accessToken.present ? accessToken.value : this.accessToken,
        username: username.present ? username.value : this.username,
        email: email.present ? email.value : this.email,
        password: password ?? this.password,
        lastLogin: lastLogin.present ? lastLogin.value : this.lastLogin,
      );
  UserCredentialData copyWithCompanion(UserCredentialCompanion data) {
    return UserCredentialData(
      userId: data.userId.present ? data.userId.value : this.userId,
      admno: data.admno.present ? data.admno.value : this.admno,
      accessToken:
          data.accessToken.present ? data.accessToken.value : this.accessToken,
      username: data.username.present ? data.username.value : this.username,
      email: data.email.present ? data.email.value : this.email,
      password: data.password.present ? data.password.value : this.password,
      lastLogin: data.lastLogin.present ? data.lastLogin.value : this.lastLogin,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserCredentialData(')
          ..write('userId: $userId, ')
          ..write('admno: $admno, ')
          ..write('accessToken: $accessToken, ')
          ..write('username: $username, ')
          ..write('email: $email, ')
          ..write('password: $password, ')
          ..write('lastLogin: $lastLogin')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      userId, admno, accessToken, username, email, password, lastLogin);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserCredentialData &&
          other.userId == this.userId &&
          other.admno == this.admno &&
          other.accessToken == this.accessToken &&
          other.username == this.username &&
          other.email == this.email &&
          other.password == this.password &&
          other.lastLogin == this.lastLogin);
}

class UserCredentialCompanion extends UpdateCompanion<UserCredentialData> {
  final Value<String?> userId;
  final Value<String?> admno;
  final Value<String?> accessToken;
  final Value<String?> username;
  final Value<String?> email;
  final Value<String> password;
  final Value<DateTime?> lastLogin;
  final Value<int> rowid;
  const UserCredentialCompanion({
    this.userId = const Value.absent(),
    this.admno = const Value.absent(),
    this.accessToken = const Value.absent(),
    this.username = const Value.absent(),
    this.email = const Value.absent(),
    this.password = const Value.absent(),
    this.lastLogin = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserCredentialCompanion.insert({
    this.userId = const Value.absent(),
    this.admno = const Value.absent(),
    this.accessToken = const Value.absent(),
    this.username = const Value.absent(),
    this.email = const Value.absent(),
    required String password,
    this.lastLogin = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : password = Value(password);
  static Insertable<UserCredentialData> custom({
    Expression<String>? userId,
    Expression<String>? admno,
    Expression<String>? accessToken,
    Expression<String>? username,
    Expression<String>? email,
    Expression<String>? password,
    Expression<DateTime>? lastLogin,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (admno != null) 'admno': admno,
      if (accessToken != null) 'access_token': accessToken,
      if (username != null) 'username': username,
      if (email != null) 'email': email,
      if (password != null) 'password': password,
      if (lastLogin != null) 'last_login': lastLogin,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserCredentialCompanion copyWith(
      {Value<String?>? userId,
      Value<String?>? admno,
      Value<String?>? accessToken,
      Value<String?>? username,
      Value<String?>? email,
      Value<String>? password,
      Value<DateTime?>? lastLogin,
      Value<int>? rowid}) {
    return UserCredentialCompanion(
      userId: userId ?? this.userId,
      admno: admno ?? this.admno,
      accessToken: accessToken ?? this.accessToken,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      lastLogin: lastLogin ?? this.lastLogin,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (admno.present) {
      map['admno'] = Variable<String>(admno.value);
    }
    if (accessToken.present) {
      map['access_token'] = Variable<String>(accessToken.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (lastLogin.present) {
      map['last_login'] = Variable<DateTime>(lastLogin.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserCredentialCompanion(')
          ..write('userId: $userId, ')
          ..write('admno: $admno, ')
          ..write('accessToken: $accessToken, ')
          ..write('username: $username, ')
          ..write('email: $email, ')
          ..write('password: $password, ')
          ..write('lastLogin: $lastLogin, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CourseTable extends Course with TableInfo<$CourseTable, CourseData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CourseTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
      'unit', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userMeta = const VerificationMeta('user');
  @override
  late final GeneratedColumn<String> user = GeneratedColumn<String>(
      'user', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES user (id)'));
  static const VerificationMeta _sectionMeta =
      const VerificationMeta('section');
  @override
  late final GeneratedColumn<String> section = GeneratedColumn<String>(
      'section', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _weekDayMeta =
      const VerificationMeta('weekDay');
  @override
  late final GeneratedColumn<String> weekDay = GeneratedColumn<String>(
      'week_day', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _campusMeta = const VerificationMeta('campus');
  @override
  late final GeneratedColumn<String> campus = GeneratedColumn<String>(
      'campus', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _roomMeta = const VerificationMeta('room');
  @override
  late final GeneratedColumn<String> room = GeneratedColumn<String>(
      'room', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lecturerMeta =
      const VerificationMeta('lecturer');
  @override
  late final GeneratedColumn<String> lecturer = GeneratedColumn<String>(
      'lecturer', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _periodMeta = const VerificationMeta('period');
  @override
  late final GeneratedColumn<String> period = GeneratedColumn<String>(
      'period', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
      'color', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  @override
  List<GeneratedColumn> get $columns => [
        unit,
        user,
        section,
        weekDay,
        campus,
        room,
        lecturer,
        period,
        color,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'course';
  @override
  VerificationContext validateIntegrity(Insertable<CourseData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('unit')) {
      context.handle(
          _unitMeta, unit.isAcceptableOrUnknown(data['unit']!, _unitMeta));
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('user')) {
      context.handle(
          _userMeta, user.isAcceptableOrUnknown(data['user']!, _userMeta));
    }
    if (data.containsKey('section')) {
      context.handle(_sectionMeta,
          section.isAcceptableOrUnknown(data['section']!, _sectionMeta));
    } else if (isInserting) {
      context.missing(_sectionMeta);
    }
    if (data.containsKey('week_day')) {
      context.handle(_weekDayMeta,
          weekDay.isAcceptableOrUnknown(data['week_day']!, _weekDayMeta));
    } else if (isInserting) {
      context.missing(_weekDayMeta);
    }
    if (data.containsKey('campus')) {
      context.handle(_campusMeta,
          campus.isAcceptableOrUnknown(data['campus']!, _campusMeta));
    } else if (isInserting) {
      context.missing(_campusMeta);
    }
    if (data.containsKey('room')) {
      context.handle(
          _roomMeta, room.isAcceptableOrUnknown(data['room']!, _roomMeta));
    } else if (isInserting) {
      context.missing(_roomMeta);
    }
    if (data.containsKey('lecturer')) {
      context.handle(_lecturerMeta,
          lecturer.isAcceptableOrUnknown(data['lecturer']!, _lecturerMeta));
    } else if (isInserting) {
      context.missing(_lecturerMeta);
    }
    if (data.containsKey('period')) {
      context.handle(_periodMeta,
          period.isAcceptableOrUnknown(data['period']!, _periodMeta));
    } else if (isInserting) {
      context.missing(_periodMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {unit};
  @override
  CourseData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CourseData(
      unit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit'])!,
      user: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user']),
      section: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}section'])!,
      weekDay: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}week_day'])!,
      campus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}campus'])!,
      room: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}room'])!,
      lecturer: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lecturer'])!,
      period: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}period'])!,
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
    );
  }

  @override
  $CourseTable createAlias(String alias) {
    return $CourseTable(attachedDatabase, alias);
  }
}

class CourseData extends DataClass implements Insertable<CourseData> {
  final String unit;
  final String? user;
  final String section;
  final String weekDay;
  final String campus;
  final String room;
  final String lecturer;
  final String period;
  final int? color;
  final DateTime? createdAt;
  const CourseData(
      {required this.unit,
      this.user,
      required this.section,
      required this.weekDay,
      required this.campus,
      required this.room,
      required this.lecturer,
      required this.period,
      this.color,
      this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['unit'] = Variable<String>(unit);
    if (!nullToAbsent || user != null) {
      map['user'] = Variable<String>(user);
    }
    map['section'] = Variable<String>(section);
    map['week_day'] = Variable<String>(weekDay);
    map['campus'] = Variable<String>(campus);
    map['room'] = Variable<String>(room);
    map['lecturer'] = Variable<String>(lecturer);
    map['period'] = Variable<String>(period);
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<int>(color);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    return map;
  }

  CourseCompanion toCompanion(bool nullToAbsent) {
    return CourseCompanion(
      unit: Value(unit),
      user: user == null && nullToAbsent ? const Value.absent() : Value(user),
      section: Value(section),
      weekDay: Value(weekDay),
      campus: Value(campus),
      room: Value(room),
      lecturer: Value(lecturer),
      period: Value(period),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory CourseData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CourseData(
      unit: serializer.fromJson<String>(json['unit']),
      user: serializer.fromJson<String?>(json['user']),
      section: serializer.fromJson<String>(json['section']),
      weekDay: serializer.fromJson<String>(json['day_of_the_week']),
      campus: serializer.fromJson<String>(json['campus']),
      room: serializer.fromJson<String>(json['room']),
      lecturer: serializer.fromJson<String>(json['lecturer']),
      period: serializer.fromJson<String>(json['period']),
      color: serializer.fromJson<int?>(json['color']),
      createdAt: serializer.fromJson<DateTime?>(json['created_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'unit': serializer.toJson<String>(unit),
      'user': serializer.toJson<String?>(user),
      'section': serializer.toJson<String>(section),
      'day_of_the_week': serializer.toJson<String>(weekDay),
      'campus': serializer.toJson<String>(campus),
      'room': serializer.toJson<String>(room),
      'lecturer': serializer.toJson<String>(lecturer),
      'period': serializer.toJson<String>(period),
      'color': serializer.toJson<int?>(color),
      'created_at': serializer.toJson<DateTime?>(createdAt),
    };
  }

  CourseData copyWith(
          {String? unit,
          Value<String?> user = const Value.absent(),
          String? section,
          String? weekDay,
          String? campus,
          String? room,
          String? lecturer,
          String? period,
          Value<int?> color = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent()}) =>
      CourseData(
        unit: unit ?? this.unit,
        user: user.present ? user.value : this.user,
        section: section ?? this.section,
        weekDay: weekDay ?? this.weekDay,
        campus: campus ?? this.campus,
        room: room ?? this.room,
        lecturer: lecturer ?? this.lecturer,
        period: period ?? this.period,
        color: color.present ? color.value : this.color,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
      );
  CourseData copyWithCompanion(CourseCompanion data) {
    return CourseData(
      unit: data.unit.present ? data.unit.value : this.unit,
      user: data.user.present ? data.user.value : this.user,
      section: data.section.present ? data.section.value : this.section,
      weekDay: data.weekDay.present ? data.weekDay.value : this.weekDay,
      campus: data.campus.present ? data.campus.value : this.campus,
      room: data.room.present ? data.room.value : this.room,
      lecturer: data.lecturer.present ? data.lecturer.value : this.lecturer,
      period: data.period.present ? data.period.value : this.period,
      color: data.color.present ? data.color.value : this.color,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CourseData(')
          ..write('unit: $unit, ')
          ..write('user: $user, ')
          ..write('section: $section, ')
          ..write('weekDay: $weekDay, ')
          ..write('campus: $campus, ')
          ..write('room: $room, ')
          ..write('lecturer: $lecturer, ')
          ..write('period: $period, ')
          ..write('color: $color, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(unit, user, section, weekDay, campus, room,
      lecturer, period, color, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CourseData &&
          other.unit == this.unit &&
          other.user == this.user &&
          other.section == this.section &&
          other.weekDay == this.weekDay &&
          other.campus == this.campus &&
          other.room == this.room &&
          other.lecturer == this.lecturer &&
          other.period == this.period &&
          other.color == this.color &&
          other.createdAt == this.createdAt);
}

class CourseCompanion extends UpdateCompanion<CourseData> {
  final Value<String> unit;
  final Value<String?> user;
  final Value<String> section;
  final Value<String> weekDay;
  final Value<String> campus;
  final Value<String> room;
  final Value<String> lecturer;
  final Value<String> period;
  final Value<int?> color;
  final Value<DateTime?> createdAt;
  final Value<int> rowid;
  const CourseCompanion({
    this.unit = const Value.absent(),
    this.user = const Value.absent(),
    this.section = const Value.absent(),
    this.weekDay = const Value.absent(),
    this.campus = const Value.absent(),
    this.room = const Value.absent(),
    this.lecturer = const Value.absent(),
    this.period = const Value.absent(),
    this.color = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CourseCompanion.insert({
    required String unit,
    this.user = const Value.absent(),
    required String section,
    required String weekDay,
    required String campus,
    required String room,
    required String lecturer,
    required String period,
    this.color = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : unit = Value(unit),
        section = Value(section),
        weekDay = Value(weekDay),
        campus = Value(campus),
        room = Value(room),
        lecturer = Value(lecturer),
        period = Value(period);
  static Insertable<CourseData> custom({
    Expression<String>? unit,
    Expression<String>? user,
    Expression<String>? section,
    Expression<String>? weekDay,
    Expression<String>? campus,
    Expression<String>? room,
    Expression<String>? lecturer,
    Expression<String>? period,
    Expression<int>? color,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (unit != null) 'unit': unit,
      if (user != null) 'user': user,
      if (section != null) 'section': section,
      if (weekDay != null) 'week_day': weekDay,
      if (campus != null) 'campus': campus,
      if (room != null) 'room': room,
      if (lecturer != null) 'lecturer': lecturer,
      if (period != null) 'period': period,
      if (color != null) 'color': color,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CourseCompanion copyWith(
      {Value<String>? unit,
      Value<String?>? user,
      Value<String>? section,
      Value<String>? weekDay,
      Value<String>? campus,
      Value<String>? room,
      Value<String>? lecturer,
      Value<String>? period,
      Value<int?>? color,
      Value<DateTime?>? createdAt,
      Value<int>? rowid}) {
    return CourseCompanion(
      unit: unit ?? this.unit,
      user: user ?? this.user,
      section: section ?? this.section,
      weekDay: weekDay ?? this.weekDay,
      campus: campus ?? this.campus,
      room: room ?? this.room,
      lecturer: lecturer ?? this.lecturer,
      period: period ?? this.period,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (user.present) {
      map['user'] = Variable<String>(user.value);
    }
    if (section.present) {
      map['section'] = Variable<String>(section.value);
    }
    if (weekDay.present) {
      map['week_day'] = Variable<String>(weekDay.value);
    }
    if (campus.present) {
      map['campus'] = Variable<String>(campus.value);
    }
    if (room.present) {
      map['room'] = Variable<String>(room.value);
    }
    if (lecturer.present) {
      map['lecturer'] = Variable<String>(lecturer.value);
    }
    if (period.present) {
      map['period'] = Variable<String>(period.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CourseCompanion(')
          ..write('unit: $unit, ')
          ..write('user: $user, ')
          ..write('section: $section, ')
          ..write('weekDay: $weekDay, ')
          ..write('campus: $campus, ')
          ..write('room: $room, ')
          ..write('lecturer: $lecturer, ')
          ..write('period: $period, ')
          ..write('color: $color, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TodoTable extends Todo with TableInfo<$TodoTable, TodoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TodoTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES user (id)'));
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
      'unit', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES course (unit)'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
      'body', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _subtasksMeta =
      const VerificationMeta('subtasks');
  @override
  late final GeneratedColumn<String> subtasks = GeneratedColumn<String>(
      'subtasks', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
      'color', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _notifyMeta = const VerificationMeta('notify');
  @override
  late final GeneratedColumn<bool> notify = GeneratedColumn<bool>(
      'notify', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("notify" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _completeMeta =
      const VerificationMeta('complete');
  @override
  late final GeneratedColumn<bool> complete = GeneratedColumn<bool>(
      'complete', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("complete" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _autocompleteMeta =
      const VerificationMeta('autocomplete');
  @override
  late final GeneratedColumn<bool> autocomplete = GeneratedColumn<bool>(
      'autocomplete', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("autocomplete" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _notifyAtMeta =
      const VerificationMeta('notifyAt');
  @override
  late final GeneratedColumn<DateTime> notifyAt = GeneratedColumn<DateTime>(
      'notify_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _duedateMeta =
      const VerificationMeta('duedate');
  @override
  late final GeneratedColumn<DateTime> duedate = GeneratedColumn<DateTime>(
      'duedate', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _dateCreatedMeta =
      const VerificationMeta('dateCreated');
  @override
  late final GeneratedColumn<DateTime> dateCreated = GeneratedColumn<DateTime>(
      'date_created', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  static const VerificationMeta _dateModifiedMeta =
      const VerificationMeta('dateModified');
  @override
  late final GeneratedColumn<DateTime> dateModified = GeneratedColumn<DateTime>(
      'date_modified', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  static const VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
      'completed_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        unit,
        title,
        body,
        subtasks,
        color,
        notify,
        complete,
        autocomplete,
        notifyAt,
        duedate,
        dateCreated,
        dateModified,
        completedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'todo';
  @override
  VerificationContext validateIntegrity(Insertable<TodoData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
          _unitMeta, unit.isAcceptableOrUnknown(data['unit']!, _unitMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
          _bodyMeta, body.isAcceptableOrUnknown(data['body']!, _bodyMeta));
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('subtasks')) {
      context.handle(_subtasksMeta,
          subtasks.isAcceptableOrUnknown(data['subtasks']!, _subtasksMeta));
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    }
    if (data.containsKey('notify')) {
      context.handle(_notifyMeta,
          notify.isAcceptableOrUnknown(data['notify']!, _notifyMeta));
    }
    if (data.containsKey('complete')) {
      context.handle(_completeMeta,
          complete.isAcceptableOrUnknown(data['complete']!, _completeMeta));
    }
    if (data.containsKey('autocomplete')) {
      context.handle(
          _autocompleteMeta,
          autocomplete.isAcceptableOrUnknown(
              data['autocomplete']!, _autocompleteMeta));
    }
    if (data.containsKey('notify_at')) {
      context.handle(_notifyAtMeta,
          notifyAt.isAcceptableOrUnknown(data['notify_at']!, _notifyAtMeta));
    }
    if (data.containsKey('duedate')) {
      context.handle(_duedateMeta,
          duedate.isAcceptableOrUnknown(data['duedate']!, _duedateMeta));
    }
    if (data.containsKey('date_created')) {
      context.handle(
          _dateCreatedMeta,
          dateCreated.isAcceptableOrUnknown(
              data['date_created']!, _dateCreatedMeta));
    }
    if (data.containsKey('date_modified')) {
      context.handle(
          _dateModifiedMeta,
          dateModified.isAcceptableOrUnknown(
              data['date_modified']!, _dateModifiedMeta));
    }
    if (data.containsKey('completed_at')) {
      context.handle(
          _completedAtMeta,
          completedAt.isAcceptableOrUnknown(
              data['completed_at']!, _completedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TodoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TodoData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      unit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit']),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      body: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}body'])!,
      subtasks: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}subtasks']),
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color']),
      notify: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}notify'])!,
      complete: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}complete'])!,
      autocomplete: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}autocomplete'])!,
      notifyAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}notify_at']),
      duedate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}duedate']),
      dateCreated: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date_created'])!,
      dateModified: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}date_modified'])!,
      completedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}completed_at'])!,
    );
  }

  @override
  $TodoTable createAlias(String alias) {
    return $TodoTable(attachedDatabase, alias);
  }
}

class TodoData extends DataClass implements Insertable<TodoData> {
  final int? id;
  final String userId;
  final String? unit;
  final String title;
  final String body;
  final String? subtasks;
  final int? color;
  final bool notify;
  final bool complete;
  final bool autocomplete;
  final DateTime? notifyAt;
  final DateTime? duedate;
  final DateTime dateCreated;
  final DateTime dateModified;
  final DateTime completedAt;
  const TodoData(
      {this.id,
      required this.userId,
      this.unit,
      required this.title,
      required this.body,
      this.subtasks,
      this.color,
      required this.notify,
      required this.complete,
      required this.autocomplete,
      this.notifyAt,
      this.duedate,
      required this.dateCreated,
      required this.dateModified,
      required this.completedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    map['user_id'] = Variable<String>(userId);
    if (!nullToAbsent || unit != null) {
      map['unit'] = Variable<String>(unit);
    }
    map['title'] = Variable<String>(title);
    map['body'] = Variable<String>(body);
    if (!nullToAbsent || subtasks != null) {
      map['subtasks'] = Variable<String>(subtasks);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<int>(color);
    }
    map['notify'] = Variable<bool>(notify);
    map['complete'] = Variable<bool>(complete);
    map['autocomplete'] = Variable<bool>(autocomplete);
    if (!nullToAbsent || notifyAt != null) {
      map['notify_at'] = Variable<DateTime>(notifyAt);
    }
    if (!nullToAbsent || duedate != null) {
      map['duedate'] = Variable<DateTime>(duedate);
    }
    map['date_created'] = Variable<DateTime>(dateCreated);
    map['date_modified'] = Variable<DateTime>(dateModified);
    map['completed_at'] = Variable<DateTime>(completedAt);
    return map;
  }

  TodoCompanion toCompanion(bool nullToAbsent) {
    return TodoCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      userId: Value(userId),
      unit: unit == null && nullToAbsent ? const Value.absent() : Value(unit),
      title: Value(title),
      body: Value(body),
      subtasks: subtasks == null && nullToAbsent
          ? const Value.absent()
          : Value(subtasks),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      notify: Value(notify),
      complete: Value(complete),
      autocomplete: Value(autocomplete),
      notifyAt: notifyAt == null && nullToAbsent
          ? const Value.absent()
          : Value(notifyAt),
      duedate: duedate == null && nullToAbsent
          ? const Value.absent()
          : Value(duedate),
      dateCreated: Value(dateCreated),
      dateModified: Value(dateModified),
      completedAt: Value(completedAt),
    );
  }

  factory TodoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TodoData(
      id: serializer.fromJson<int?>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      unit: serializer.fromJson<String?>(json['unit']),
      title: serializer.fromJson<String>(json['title']),
      body: serializer.fromJson<String>(json['body']),
      subtasks: serializer.fromJson<String?>(json['subtasks']),
      color: serializer.fromJson<int?>(json['color']),
      notify: serializer.fromJson<bool>(json['notify']),
      complete: serializer.fromJson<bool>(json['complete']),
      autocomplete: serializer.fromJson<bool>(json['autocomplete']),
      notifyAt: serializer.fromJson<DateTime?>(json['notifyAt']),
      duedate: serializer.fromJson<DateTime?>(json['duedate']),
      dateCreated: serializer.fromJson<DateTime>(json['dateCreated']),
      dateModified: serializer.fromJson<DateTime>(json['dateModified']),
      completedAt: serializer.fromJson<DateTime>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'userId': serializer.toJson<String>(userId),
      'unit': serializer.toJson<String?>(unit),
      'title': serializer.toJson<String>(title),
      'body': serializer.toJson<String>(body),
      'subtasks': serializer.toJson<String?>(subtasks),
      'color': serializer.toJson<int?>(color),
      'notify': serializer.toJson<bool>(notify),
      'complete': serializer.toJson<bool>(complete),
      'autocomplete': serializer.toJson<bool>(autocomplete),
      'notifyAt': serializer.toJson<DateTime?>(notifyAt),
      'duedate': serializer.toJson<DateTime?>(duedate),
      'dateCreated': serializer.toJson<DateTime>(dateCreated),
      'dateModified': serializer.toJson<DateTime>(dateModified),
      'completedAt': serializer.toJson<DateTime>(completedAt),
    };
  }

  TodoData copyWith(
          {Value<int?> id = const Value.absent(),
          String? userId,
          Value<String?> unit = const Value.absent(),
          String? title,
          String? body,
          Value<String?> subtasks = const Value.absent(),
          Value<int?> color = const Value.absent(),
          bool? notify,
          bool? complete,
          bool? autocomplete,
          Value<DateTime?> notifyAt = const Value.absent(),
          Value<DateTime?> duedate = const Value.absent(),
          DateTime? dateCreated,
          DateTime? dateModified,
          DateTime? completedAt}) =>
      TodoData(
        id: id.present ? id.value : this.id,
        userId: userId ?? this.userId,
        unit: unit.present ? unit.value : this.unit,
        title: title ?? this.title,
        body: body ?? this.body,
        subtasks: subtasks.present ? subtasks.value : this.subtasks,
        color: color.present ? color.value : this.color,
        notify: notify ?? this.notify,
        complete: complete ?? this.complete,
        autocomplete: autocomplete ?? this.autocomplete,
        notifyAt: notifyAt.present ? notifyAt.value : this.notifyAt,
        duedate: duedate.present ? duedate.value : this.duedate,
        dateCreated: dateCreated ?? this.dateCreated,
        dateModified: dateModified ?? this.dateModified,
        completedAt: completedAt ?? this.completedAt,
      );
  TodoData copyWithCompanion(TodoCompanion data) {
    return TodoData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      unit: data.unit.present ? data.unit.value : this.unit,
      title: data.title.present ? data.title.value : this.title,
      body: data.body.present ? data.body.value : this.body,
      subtasks: data.subtasks.present ? data.subtasks.value : this.subtasks,
      color: data.color.present ? data.color.value : this.color,
      notify: data.notify.present ? data.notify.value : this.notify,
      complete: data.complete.present ? data.complete.value : this.complete,
      autocomplete: data.autocomplete.present
          ? data.autocomplete.value
          : this.autocomplete,
      notifyAt: data.notifyAt.present ? data.notifyAt.value : this.notifyAt,
      duedate: data.duedate.present ? data.duedate.value : this.duedate,
      dateCreated:
          data.dateCreated.present ? data.dateCreated.value : this.dateCreated,
      dateModified: data.dateModified.present
          ? data.dateModified.value
          : this.dateModified,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TodoData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('unit: $unit, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('subtasks: $subtasks, ')
          ..write('color: $color, ')
          ..write('notify: $notify, ')
          ..write('complete: $complete, ')
          ..write('autocomplete: $autocomplete, ')
          ..write('notifyAt: $notifyAt, ')
          ..write('duedate: $duedate, ')
          ..write('dateCreated: $dateCreated, ')
          ..write('dateModified: $dateModified, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      userId,
      unit,
      title,
      body,
      subtasks,
      color,
      notify,
      complete,
      autocomplete,
      notifyAt,
      duedate,
      dateCreated,
      dateModified,
      completedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TodoData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.unit == this.unit &&
          other.title == this.title &&
          other.body == this.body &&
          other.subtasks == this.subtasks &&
          other.color == this.color &&
          other.notify == this.notify &&
          other.complete == this.complete &&
          other.autocomplete == this.autocomplete &&
          other.notifyAt == this.notifyAt &&
          other.duedate == this.duedate &&
          other.dateCreated == this.dateCreated &&
          other.dateModified == this.dateModified &&
          other.completedAt == this.completedAt);
}

class TodoCompanion extends UpdateCompanion<TodoData> {
  final Value<int?> id;
  final Value<String> userId;
  final Value<String?> unit;
  final Value<String> title;
  final Value<String> body;
  final Value<String?> subtasks;
  final Value<int?> color;
  final Value<bool> notify;
  final Value<bool> complete;
  final Value<bool> autocomplete;
  final Value<DateTime?> notifyAt;
  final Value<DateTime?> duedate;
  final Value<DateTime> dateCreated;
  final Value<DateTime> dateModified;
  final Value<DateTime> completedAt;
  const TodoCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.unit = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.subtasks = const Value.absent(),
    this.color = const Value.absent(),
    this.notify = const Value.absent(),
    this.complete = const Value.absent(),
    this.autocomplete = const Value.absent(),
    this.notifyAt = const Value.absent(),
    this.duedate = const Value.absent(),
    this.dateCreated = const Value.absent(),
    this.dateModified = const Value.absent(),
    this.completedAt = const Value.absent(),
  });
  TodoCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    this.unit = const Value.absent(),
    required String title,
    required String body,
    this.subtasks = const Value.absent(),
    this.color = const Value.absent(),
    this.notify = const Value.absent(),
    this.complete = const Value.absent(),
    this.autocomplete = const Value.absent(),
    this.notifyAt = const Value.absent(),
    this.duedate = const Value.absent(),
    this.dateCreated = const Value.absent(),
    this.dateModified = const Value.absent(),
    this.completedAt = const Value.absent(),
  })  : userId = Value(userId),
        title = Value(title),
        body = Value(body);
  static Insertable<TodoData> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? unit,
    Expression<String>? title,
    Expression<String>? body,
    Expression<String>? subtasks,
    Expression<int>? color,
    Expression<bool>? notify,
    Expression<bool>? complete,
    Expression<bool>? autocomplete,
    Expression<DateTime>? notifyAt,
    Expression<DateTime>? duedate,
    Expression<DateTime>? dateCreated,
    Expression<DateTime>? dateModified,
    Expression<DateTime>? completedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (unit != null) 'unit': unit,
      if (title != null) 'title': title,
      if (body != null) 'body': body,
      if (subtasks != null) 'subtasks': subtasks,
      if (color != null) 'color': color,
      if (notify != null) 'notify': notify,
      if (complete != null) 'complete': complete,
      if (autocomplete != null) 'autocomplete': autocomplete,
      if (notifyAt != null) 'notify_at': notifyAt,
      if (duedate != null) 'duedate': duedate,
      if (dateCreated != null) 'date_created': dateCreated,
      if (dateModified != null) 'date_modified': dateModified,
      if (completedAt != null) 'completed_at': completedAt,
    });
  }

  TodoCompanion copyWith(
      {Value<int?>? id,
      Value<String>? userId,
      Value<String?>? unit,
      Value<String>? title,
      Value<String>? body,
      Value<String?>? subtasks,
      Value<int?>? color,
      Value<bool>? notify,
      Value<bool>? complete,
      Value<bool>? autocomplete,
      Value<DateTime?>? notifyAt,
      Value<DateTime?>? duedate,
      Value<DateTime>? dateCreated,
      Value<DateTime>? dateModified,
      Value<DateTime>? completedAt}) {
    return TodoCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      unit: unit ?? this.unit,
      title: title ?? this.title,
      body: body ?? this.body,
      subtasks: subtasks ?? this.subtasks,
      color: color ?? this.color,
      notify: notify ?? this.notify,
      complete: complete ?? this.complete,
      autocomplete: autocomplete ?? this.autocomplete,
      notifyAt: notifyAt ?? this.notifyAt,
      duedate: duedate ?? this.duedate,
      dateCreated: dateCreated ?? this.dateCreated,
      dateModified: dateModified ?? this.dateModified,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (subtasks.present) {
      map['subtasks'] = Variable<String>(subtasks.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (notify.present) {
      map['notify'] = Variable<bool>(notify.value);
    }
    if (complete.present) {
      map['complete'] = Variable<bool>(complete.value);
    }
    if (autocomplete.present) {
      map['autocomplete'] = Variable<bool>(autocomplete.value);
    }
    if (notifyAt.present) {
      map['notify_at'] = Variable<DateTime>(notifyAt.value);
    }
    if (duedate.present) {
      map['duedate'] = Variable<DateTime>(duedate.value);
    }
    if (dateCreated.present) {
      map['date_created'] = Variable<DateTime>(dateCreated.value);
    }
    if (dateModified.present) {
      map['date_modified'] = Variable<DateTime>(dateModified.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodoCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('unit: $unit, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('subtasks: $subtasks, ')
          ..write('color: $color, ')
          ..write('notify: $notify, ')
          ..write('complete: $complete, ')
          ..write('autocomplete: $autocomplete, ')
          ..write('notifyAt: $notifyAt, ')
          ..write('duedate: $duedate, ')
          ..write('dateCreated: $dateCreated, ')
          ..write('dateModified: $dateModified, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }
}

class $ExamModelTable extends ExamModel
    with TableInfo<$ExamModelTable, ExamModelData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExamModelTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _courseCodeMeta =
      const VerificationMeta('courseCode');
  @override
  late final GeneratedColumn<String> courseCode = GeneratedColumn<String>(
      'course_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _examDateMeta =
      const VerificationMeta('examDate');
  @override
  late final GeneratedColumn<DateTime> examDate = GeneratedColumn<DateTime>(
      'exam_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _venueMeta = const VerificationMeta('venue');
  @override
  late final GeneratedColumn<String> venue = GeneratedColumn<String>(
      'venue', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _campusMeta = const VerificationMeta('campus');
  @override
  late final GeneratedColumn<String> campus = GeneratedColumn<String>(
      'campus', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _hoursMeta = const VerificationMeta('hours');
  @override
  late final GeneratedColumn<String> hours = GeneratedColumn<String>(
      'hours', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _invigilatorMeta =
      const VerificationMeta('invigilator');
  @override
  late final GeneratedColumn<String> invigilator = GeneratedColumn<String>(
      'invigilator', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [courseCode, examDate, venue, campus, hours, invigilator];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exam_model';
  @override
  VerificationContext validateIntegrity(Insertable<ExamModelData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('course_code')) {
      context.handle(
          _courseCodeMeta,
          courseCode.isAcceptableOrUnknown(
              data['course_code']!, _courseCodeMeta));
    } else if (isInserting) {
      context.missing(_courseCodeMeta);
    }
    if (data.containsKey('exam_date')) {
      context.handle(_examDateMeta,
          examDate.isAcceptableOrUnknown(data['exam_date']!, _examDateMeta));
    } else if (isInserting) {
      context.missing(_examDateMeta);
    }
    if (data.containsKey('venue')) {
      context.handle(
          _venueMeta, venue.isAcceptableOrUnknown(data['venue']!, _venueMeta));
    } else if (isInserting) {
      context.missing(_venueMeta);
    }
    if (data.containsKey('campus')) {
      context.handle(_campusMeta,
          campus.isAcceptableOrUnknown(data['campus']!, _campusMeta));
    } else if (isInserting) {
      context.missing(_campusMeta);
    }
    if (data.containsKey('hours')) {
      context.handle(
          _hoursMeta, hours.isAcceptableOrUnknown(data['hours']!, _hoursMeta));
    } else if (isInserting) {
      context.missing(_hoursMeta);
    }
    if (data.containsKey('invigilator')) {
      context.handle(
          _invigilatorMeta,
          invigilator.isAcceptableOrUnknown(
              data['invigilator']!, _invigilatorMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {courseCode};
  @override
  ExamModelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExamModelData(
      courseCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}course_code'])!,
      examDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}exam_date'])!,
      venue: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}venue'])!,
      campus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}campus'])!,
      hours: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}hours'])!,
      invigilator: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}invigilator']),
    );
  }

  @override
  $ExamModelTable createAlias(String alias) {
    return $ExamModelTable(attachedDatabase, alias);
  }
}

class ExamModelData extends DataClass implements Insertable<ExamModelData> {
  final String courseCode;
  final DateTime examDate;
  final String venue;
  final String campus;
  final String hours;
  final String? invigilator;
  const ExamModelData(
      {required this.courseCode,
      required this.examDate,
      required this.venue,
      required this.campus,
      required this.hours,
      this.invigilator});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['course_code'] = Variable<String>(courseCode);
    map['exam_date'] = Variable<DateTime>(examDate);
    map['venue'] = Variable<String>(venue);
    map['campus'] = Variable<String>(campus);
    map['hours'] = Variable<String>(hours);
    if (!nullToAbsent || invigilator != null) {
      map['invigilator'] = Variable<String>(invigilator);
    }
    return map;
  }

  ExamModelCompanion toCompanion(bool nullToAbsent) {
    return ExamModelCompanion(
      courseCode: Value(courseCode),
      examDate: Value(examDate),
      venue: Value(venue),
      campus: Value(campus),
      hours: Value(hours),
      invigilator: invigilator == null && nullToAbsent
          ? const Value.absent()
          : Value(invigilator),
    );
  }

  factory ExamModelData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExamModelData(
      courseCode: serializer.fromJson<String>(json['course_code']),
      examDate: serializer.fromJson<DateTime>(json['datetime_str']),
      venue: serializer.fromJson<String>(json['venue']),
      campus: serializer.fromJson<String>(json['campus']),
      hours: serializer.fromJson<String>(json['hrs']),
      invigilator: serializer.fromJson<String?>(json['invigilator']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'course_code': serializer.toJson<String>(courseCode),
      'datetime_str': serializer.toJson<DateTime>(examDate),
      'venue': serializer.toJson<String>(venue),
      'campus': serializer.toJson<String>(campus),
      'hrs': serializer.toJson<String>(hours),
      'invigilator': serializer.toJson<String?>(invigilator),
    };
  }

  ExamModelData copyWith(
          {String? courseCode,
          DateTime? examDate,
          String? venue,
          String? campus,
          String? hours,
          Value<String?> invigilator = const Value.absent()}) =>
      ExamModelData(
        courseCode: courseCode ?? this.courseCode,
        examDate: examDate ?? this.examDate,
        venue: venue ?? this.venue,
        campus: campus ?? this.campus,
        hours: hours ?? this.hours,
        invigilator: invigilator.present ? invigilator.value : this.invigilator,
      );
  ExamModelData copyWithCompanion(ExamModelCompanion data) {
    return ExamModelData(
      courseCode:
          data.courseCode.present ? data.courseCode.value : this.courseCode,
      examDate: data.examDate.present ? data.examDate.value : this.examDate,
      venue: data.venue.present ? data.venue.value : this.venue,
      campus: data.campus.present ? data.campus.value : this.campus,
      hours: data.hours.present ? data.hours.value : this.hours,
      invigilator:
          data.invigilator.present ? data.invigilator.value : this.invigilator,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExamModelData(')
          ..write('courseCode: $courseCode, ')
          ..write('examDate: $examDate, ')
          ..write('venue: $venue, ')
          ..write('campus: $campus, ')
          ..write('hours: $hours, ')
          ..write('invigilator: $invigilator')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(courseCode, examDate, venue, campus, hours, invigilator);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExamModelData &&
          other.courseCode == this.courseCode &&
          other.examDate == this.examDate &&
          other.venue == this.venue &&
          other.campus == this.campus &&
          other.hours == this.hours &&
          other.invigilator == this.invigilator);
}

class ExamModelCompanion extends UpdateCompanion<ExamModelData> {
  final Value<String> courseCode;
  final Value<DateTime> examDate;
  final Value<String> venue;
  final Value<String> campus;
  final Value<String> hours;
  final Value<String?> invigilator;
  final Value<int> rowid;
  const ExamModelCompanion({
    this.courseCode = const Value.absent(),
    this.examDate = const Value.absent(),
    this.venue = const Value.absent(),
    this.campus = const Value.absent(),
    this.hours = const Value.absent(),
    this.invigilator = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExamModelCompanion.insert({
    required String courseCode,
    required DateTime examDate,
    required String venue,
    required String campus,
    required String hours,
    this.invigilator = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : courseCode = Value(courseCode),
        examDate = Value(examDate),
        venue = Value(venue),
        campus = Value(campus),
        hours = Value(hours);
  static Insertable<ExamModelData> custom({
    Expression<String>? courseCode,
    Expression<DateTime>? examDate,
    Expression<String>? venue,
    Expression<String>? campus,
    Expression<String>? hours,
    Expression<String>? invigilator,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (courseCode != null) 'course_code': courseCode,
      if (examDate != null) 'exam_date': examDate,
      if (venue != null) 'venue': venue,
      if (campus != null) 'campus': campus,
      if (hours != null) 'hours': hours,
      if (invigilator != null) 'invigilator': invigilator,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExamModelCompanion copyWith(
      {Value<String>? courseCode,
      Value<DateTime>? examDate,
      Value<String>? venue,
      Value<String>? campus,
      Value<String>? hours,
      Value<String?>? invigilator,
      Value<int>? rowid}) {
    return ExamModelCompanion(
      courseCode: courseCode ?? this.courseCode,
      examDate: examDate ?? this.examDate,
      venue: venue ?? this.venue,
      campus: campus ?? this.campus,
      hours: hours ?? this.hours,
      invigilator: invigilator ?? this.invigilator,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (courseCode.present) {
      map['course_code'] = Variable<String>(courseCode.value);
    }
    if (examDate.present) {
      map['exam_date'] = Variable<DateTime>(examDate.value);
    }
    if (venue.present) {
      map['venue'] = Variable<String>(venue.value);
    }
    if (campus.present) {
      map['campus'] = Variable<String>(campus.value);
    }
    if (hours.present) {
      map['hours'] = Variable<String>(hours.value);
    }
    if (invigilator.present) {
      map['invigilator'] = Variable<String>(invigilator.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExamModelCompanion(')
          ..write('courseCode: $courseCode, ')
          ..write('examDate: $examDate, ')
          ..write('venue: $venue, ')
          ..write('campus: $campus, ')
          ..write('hours: $hours, ')
          ..write('invigilator: $invigilator, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AttendanceModelTable attendanceModel =
      $AttendanceModelTable(this);
  late final $UserTable user = $UserTable(this);
  late final $UserProfileTable userProfile = $UserProfileTable(this);
  late final $UserCredentialTable userCredential = $UserCredentialTable(this);
  late final $CourseTable course = $CourseTable(this);
  late final $TodoTable todo = $TodoTable(this);
  late final $ExamModelTable examModel = $ExamModelTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        attendanceModel,
        user,
        userProfile,
        userCredential,
        course,
        todo,
        examModel
      ];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$AttendanceModelTableCreateCompanionBuilder = AttendanceModelCompanion
    Function({
  required String studentID,
  Value<DateTime> date,
  Value<String> checkIn,
  Value<String> campus,
  Value<int> rowid,
});
typedef $$AttendanceModelTableUpdateCompanionBuilder = AttendanceModelCompanion
    Function({
  Value<String> studentID,
  Value<DateTime> date,
  Value<String> checkIn,
  Value<String> campus,
  Value<int> rowid,
});

class $$AttendanceModelTableFilterComposer
    extends Composer<_$AppDatabase, $AttendanceModelTable> {
  $$AttendanceModelTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get studentID => $composableBuilder(
      column: $table.studentID, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get checkIn => $composableBuilder(
      column: $table.checkIn, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get campus => $composableBuilder(
      column: $table.campus, builder: (column) => ColumnFilters(column));
}

class $$AttendanceModelTableOrderingComposer
    extends Composer<_$AppDatabase, $AttendanceModelTable> {
  $$AttendanceModelTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get studentID => $composableBuilder(
      column: $table.studentID, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get checkIn => $composableBuilder(
      column: $table.checkIn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get campus => $composableBuilder(
      column: $table.campus, builder: (column) => ColumnOrderings(column));
}

class $$AttendanceModelTableAnnotationComposer
    extends Composer<_$AppDatabase, $AttendanceModelTable> {
  $$AttendanceModelTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get studentID =>
      $composableBuilder(column: $table.studentID, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get checkIn =>
      $composableBuilder(column: $table.checkIn, builder: (column) => column);

  GeneratedColumn<String> get campus =>
      $composableBuilder(column: $table.campus, builder: (column) => column);
}

class $$AttendanceModelTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AttendanceModelTable,
    AttendanceModelData,
    $$AttendanceModelTableFilterComposer,
    $$AttendanceModelTableOrderingComposer,
    $$AttendanceModelTableAnnotationComposer,
    $$AttendanceModelTableCreateCompanionBuilder,
    $$AttendanceModelTableUpdateCompanionBuilder,
    (
      AttendanceModelData,
      BaseReferences<_$AppDatabase, $AttendanceModelTable, AttendanceModelData>
    ),
    AttendanceModelData,
    PrefetchHooks Function()> {
  $$AttendanceModelTableTableManager(
      _$AppDatabase db, $AttendanceModelTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttendanceModelTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AttendanceModelTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttendanceModelTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> studentID = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String> checkIn = const Value.absent(),
            Value<String> campus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AttendanceModelCompanion(
            studentID: studentID,
            date: date,
            checkIn: checkIn,
            campus: campus,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String studentID,
            Value<DateTime> date = const Value.absent(),
            Value<String> checkIn = const Value.absent(),
            Value<String> campus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AttendanceModelCompanion.insert(
            studentID: studentID,
            date: date,
            checkIn: checkIn,
            campus: campus,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AttendanceModelTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AttendanceModelTable,
    AttendanceModelData,
    $$AttendanceModelTableFilterComposer,
    $$AttendanceModelTableOrderingComposer,
    $$AttendanceModelTableAnnotationComposer,
    $$AttendanceModelTableCreateCompanionBuilder,
    $$AttendanceModelTableUpdateCompanionBuilder,
    (
      AttendanceModelData,
      BaseReferences<_$AppDatabase, $AttendanceModelTable, AttendanceModelData>
    ),
    AttendanceModelData,
    PrefetchHooks Function()>;
typedef $$UserTableCreateCompanionBuilder = UserCompanion Function({
  required String id,
  required String username,
  required String firstname,
  Value<String?> othernames,
  Value<String?> phone,
  Value<String?> email,
  required String gender,
  Value<bool> active,
  Value<Uint8List?> picture,
  required DateTime createdAt,
  required DateTime modifiedAt,
  required String nationalId,
  Value<int> rowid,
});
typedef $$UserTableUpdateCompanionBuilder = UserCompanion Function({
  Value<String> id,
  Value<String> username,
  Value<String> firstname,
  Value<String?> othernames,
  Value<String?> phone,
  Value<String?> email,
  Value<String> gender,
  Value<bool> active,
  Value<Uint8List?> picture,
  Value<DateTime> createdAt,
  Value<DateTime> modifiedAt,
  Value<String> nationalId,
  Value<int> rowid,
});

final class $$UserTableReferences
    extends BaseReferences<_$AppDatabase, $UserTable, UserData> {
  $$UserTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UserProfileTable, List<UserProfileData>>
      _userProfileRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.userProfile,
          aliasName: $_aliasNameGenerator(db.user.id, db.userProfile.userId));

  $$UserProfileTableProcessedTableManager get userProfileRefs {
    final manager = $$UserProfileTableTableManager($_db, $_db.userProfile)
        .filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_userProfileRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$CourseTable, List<CourseData>> _courseRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.course,
          aliasName: $_aliasNameGenerator(db.user.id, db.course.user));

  $$CourseTableProcessedTableManager get courseRefs {
    final manager = $$CourseTableTableManager($_db, $_db.course)
        .filter((f) => f.user.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_courseRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TodoTable, List<TodoData>> _todoRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.todo,
          aliasName: $_aliasNameGenerator(db.user.id, db.todo.userId));

  $$TodoTableProcessedTableManager get todoRefs {
    final manager = $$TodoTableTableManager($_db, $_db.todo)
        .filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_todoRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$UserTableFilterComposer extends Composer<_$AppDatabase, $UserTable> {
  $$UserTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get firstname => $composableBuilder(
      column: $table.firstname, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get othernames => $composableBuilder(
      column: $table.othernames, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnFilters(column));

  ColumnFilters<Uint8List> get picture => $composableBuilder(
      column: $table.picture, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get modifiedAt => $composableBuilder(
      column: $table.modifiedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nationalId => $composableBuilder(
      column: $table.nationalId, builder: (column) => ColumnFilters(column));

  Expression<bool> userProfileRefs(
      Expression<bool> Function($$UserProfileTableFilterComposer f) f) {
    final $$UserProfileTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.userProfile,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserProfileTableFilterComposer(
              $db: $db,
              $table: $db.userProfile,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> courseRefs(
      Expression<bool> Function($$CourseTableFilterComposer f) f) {
    final $$CourseTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.course,
        getReferencedColumn: (t) => t.user,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CourseTableFilterComposer(
              $db: $db,
              $table: $db.course,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> todoRefs(
      Expression<bool> Function($$TodoTableFilterComposer f) f) {
    final $$TodoTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.todo,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TodoTableFilterComposer(
              $db: $db,
              $table: $db.todo,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UserTableOrderingComposer extends Composer<_$AppDatabase, $UserTable> {
  $$UserTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get firstname => $composableBuilder(
      column: $table.firstname, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get othernames => $composableBuilder(
      column: $table.othernames, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<Uint8List> get picture => $composableBuilder(
      column: $table.picture, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get modifiedAt => $composableBuilder(
      column: $table.modifiedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nationalId => $composableBuilder(
      column: $table.nationalId, builder: (column) => ColumnOrderings(column));
}

class $$UserTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserTable> {
  $$UserTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get firstname =>
      $composableBuilder(column: $table.firstname, builder: (column) => column);

  GeneratedColumn<String> get othernames => $composableBuilder(
      column: $table.othernames, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<Uint8List> get picture =>
      $composableBuilder(column: $table.picture, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get modifiedAt => $composableBuilder(
      column: $table.modifiedAt, builder: (column) => column);

  GeneratedColumn<String> get nationalId => $composableBuilder(
      column: $table.nationalId, builder: (column) => column);

  Expression<T> userProfileRefs<T extends Object>(
      Expression<T> Function($$UserProfileTableAnnotationComposer a) f) {
    final $$UserProfileTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.userProfile,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserProfileTableAnnotationComposer(
              $db: $db,
              $table: $db.userProfile,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> courseRefs<T extends Object>(
      Expression<T> Function($$CourseTableAnnotationComposer a) f) {
    final $$CourseTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.course,
        getReferencedColumn: (t) => t.user,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CourseTableAnnotationComposer(
              $db: $db,
              $table: $db.course,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> todoRefs<T extends Object>(
      Expression<T> Function($$TodoTableAnnotationComposer a) f) {
    final $$TodoTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.todo,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TodoTableAnnotationComposer(
              $db: $db,
              $table: $db.todo,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UserTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserTable,
    UserData,
    $$UserTableFilterComposer,
    $$UserTableOrderingComposer,
    $$UserTableAnnotationComposer,
    $$UserTableCreateCompanionBuilder,
    $$UserTableUpdateCompanionBuilder,
    (UserData, $$UserTableReferences),
    UserData,
    PrefetchHooks Function(
        {bool userProfileRefs, bool courseRefs, bool todoRefs})> {
  $$UserTableTableManager(_$AppDatabase db, $UserTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> username = const Value.absent(),
            Value<String> firstname = const Value.absent(),
            Value<String?> othernames = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String> gender = const Value.absent(),
            Value<bool> active = const Value.absent(),
            Value<Uint8List?> picture = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> modifiedAt = const Value.absent(),
            Value<String> nationalId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UserCompanion(
            id: id,
            username: username,
            firstname: firstname,
            othernames: othernames,
            phone: phone,
            email: email,
            gender: gender,
            active: active,
            picture: picture,
            createdAt: createdAt,
            modifiedAt: modifiedAt,
            nationalId: nationalId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String username,
            required String firstname,
            Value<String?> othernames = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> email = const Value.absent(),
            required String gender,
            Value<bool> active = const Value.absent(),
            Value<Uint8List?> picture = const Value.absent(),
            required DateTime createdAt,
            required DateTime modifiedAt,
            required String nationalId,
            Value<int> rowid = const Value.absent(),
          }) =>
              UserCompanion.insert(
            id: id,
            username: username,
            firstname: firstname,
            othernames: othernames,
            phone: phone,
            email: email,
            gender: gender,
            active: active,
            picture: picture,
            createdAt: createdAt,
            modifiedAt: modifiedAt,
            nationalId: nationalId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$UserTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {userProfileRefs = false, courseRefs = false, todoRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (userProfileRefs) db.userProfile,
                if (courseRefs) db.course,
                if (todoRefs) db.todo
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (userProfileRefs)
                    await $_getPrefetchedData<UserData, $UserTable,
                            UserProfileData>(
                        currentTable: table,
                        referencedTable:
                            $$UserTableReferences._userProfileRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UserTableReferences(db, table, p0)
                                .userProfileRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
                        typedResults: items),
                  if (courseRefs)
                    await $_getPrefetchedData<UserData, $UserTable, CourseData>(
                        currentTable: table,
                        referencedTable:
                            $$UserTableReferences._courseRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UserTableReferences(db, table, p0).courseRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) =>
                                referencedItems.where((e) => e.user == item.id),
                        typedResults: items),
                  if (todoRefs)
                    await $_getPrefetchedData<UserData, $UserTable, TodoData>(
                        currentTable: table,
                        referencedTable:
                            $$UserTableReferences._todoRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UserTableReferences(db, table, p0).todoRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$UserTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserTable,
    UserData,
    $$UserTableFilterComposer,
    $$UserTableOrderingComposer,
    $$UserTableAnnotationComposer,
    $$UserTableCreateCompanionBuilder,
    $$UserTableUpdateCompanionBuilder,
    (UserData, $$UserTableReferences),
    UserData,
    PrefetchHooks Function(
        {bool userProfileRefs, bool courseRefs, bool todoRefs})>;
typedef $$UserProfileTableCreateCompanionBuilder = UserProfileCompanion
    Function({
  required String userId,
  Value<String?> bio,
  Value<int> vibePoints,
  Value<String?> profilePictureUrl,
  Value<DateTime> lastSeen,
  Value<DateTime> createdAt,
  Value<DateTime> modifiedAt,
  required String admissionNumber,
  Value<String?> campus,
  required DateTime dateOfBirth,
  Value<int> rowid,
});
typedef $$UserProfileTableUpdateCompanionBuilder = UserProfileCompanion
    Function({
  Value<String> userId,
  Value<String?> bio,
  Value<int> vibePoints,
  Value<String?> profilePictureUrl,
  Value<DateTime> lastSeen,
  Value<DateTime> createdAt,
  Value<DateTime> modifiedAt,
  Value<String> admissionNumber,
  Value<String?> campus,
  Value<DateTime> dateOfBirth,
  Value<int> rowid,
});

final class $$UserProfileTableReferences
    extends BaseReferences<_$AppDatabase, $UserProfileTable, UserProfileData> {
  $$UserProfileTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UserTable _userIdTable(_$AppDatabase db) => db.user
      .createAlias($_aliasNameGenerator(db.userProfile.userId, db.user.id));

  $$UserTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$UserTableTableManager($_db, $_db.user)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$UserProfileTableFilterComposer
    extends Composer<_$AppDatabase, $UserProfileTable> {
  $$UserProfileTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get bio => $composableBuilder(
      column: $table.bio, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get vibePoints => $composableBuilder(
      column: $table.vibePoints, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get profilePictureUrl => $composableBuilder(
      column: $table.profilePictureUrl,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastSeen => $composableBuilder(
      column: $table.lastSeen, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get modifiedAt => $composableBuilder(
      column: $table.modifiedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get admissionNumber => $composableBuilder(
      column: $table.admissionNumber,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get campus => $composableBuilder(
      column: $table.campus, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dateOfBirth => $composableBuilder(
      column: $table.dateOfBirth, builder: (column) => ColumnFilters(column));

  $$UserTableFilterComposer get userId {
    final $$UserTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.user,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableFilterComposer(
              $db: $db,
              $table: $db.user,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$UserProfileTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProfileTable> {
  $$UserProfileTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get bio => $composableBuilder(
      column: $table.bio, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get vibePoints => $composableBuilder(
      column: $table.vibePoints, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get profilePictureUrl => $composableBuilder(
      column: $table.profilePictureUrl,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastSeen => $composableBuilder(
      column: $table.lastSeen, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get modifiedAt => $composableBuilder(
      column: $table.modifiedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get admissionNumber => $composableBuilder(
      column: $table.admissionNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get campus => $composableBuilder(
      column: $table.campus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dateOfBirth => $composableBuilder(
      column: $table.dateOfBirth, builder: (column) => ColumnOrderings(column));

  $$UserTableOrderingComposer get userId {
    final $$UserTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.user,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableOrderingComposer(
              $db: $db,
              $table: $db.user,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$UserProfileTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProfileTable> {
  $$UserProfileTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get bio =>
      $composableBuilder(column: $table.bio, builder: (column) => column);

  GeneratedColumn<int> get vibePoints => $composableBuilder(
      column: $table.vibePoints, builder: (column) => column);

  GeneratedColumn<String> get profilePictureUrl => $composableBuilder(
      column: $table.profilePictureUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSeen =>
      $composableBuilder(column: $table.lastSeen, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get modifiedAt => $composableBuilder(
      column: $table.modifiedAt, builder: (column) => column);

  GeneratedColumn<String> get admissionNumber => $composableBuilder(
      column: $table.admissionNumber, builder: (column) => column);

  GeneratedColumn<String> get campus =>
      $composableBuilder(column: $table.campus, builder: (column) => column);

  GeneratedColumn<DateTime> get dateOfBirth => $composableBuilder(
      column: $table.dateOfBirth, builder: (column) => column);

  $$UserTableAnnotationComposer get userId {
    final $$UserTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.user,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableAnnotationComposer(
              $db: $db,
              $table: $db.user,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$UserProfileTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserProfileTable,
    UserProfileData,
    $$UserProfileTableFilterComposer,
    $$UserProfileTableOrderingComposer,
    $$UserProfileTableAnnotationComposer,
    $$UserProfileTableCreateCompanionBuilder,
    $$UserProfileTableUpdateCompanionBuilder,
    (UserProfileData, $$UserProfileTableReferences),
    UserProfileData,
    PrefetchHooks Function({bool userId})> {
  $$UserProfileTableTableManager(_$AppDatabase db, $UserProfileTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProfileTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProfileTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProfileTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> userId = const Value.absent(),
            Value<String?> bio = const Value.absent(),
            Value<int> vibePoints = const Value.absent(),
            Value<String?> profilePictureUrl = const Value.absent(),
            Value<DateTime> lastSeen = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> modifiedAt = const Value.absent(),
            Value<String> admissionNumber = const Value.absent(),
            Value<String?> campus = const Value.absent(),
            Value<DateTime> dateOfBirth = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UserProfileCompanion(
            userId: userId,
            bio: bio,
            vibePoints: vibePoints,
            profilePictureUrl: profilePictureUrl,
            lastSeen: lastSeen,
            createdAt: createdAt,
            modifiedAt: modifiedAt,
            admissionNumber: admissionNumber,
            campus: campus,
            dateOfBirth: dateOfBirth,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String userId,
            Value<String?> bio = const Value.absent(),
            Value<int> vibePoints = const Value.absent(),
            Value<String?> profilePictureUrl = const Value.absent(),
            Value<DateTime> lastSeen = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> modifiedAt = const Value.absent(),
            required String admissionNumber,
            Value<String?> campus = const Value.absent(),
            required DateTime dateOfBirth,
            Value<int> rowid = const Value.absent(),
          }) =>
              UserProfileCompanion.insert(
            userId: userId,
            bio: bio,
            vibePoints: vibePoints,
            profilePictureUrl: profilePictureUrl,
            lastSeen: lastSeen,
            createdAt: createdAt,
            modifiedAt: modifiedAt,
            admissionNumber: admissionNumber,
            campus: campus,
            dateOfBirth: dateOfBirth,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$UserProfileTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (userId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.userId,
                    referencedTable:
                        $$UserProfileTableReferences._userIdTable(db),
                    referencedColumn:
                        $$UserProfileTableReferences._userIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$UserProfileTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserProfileTable,
    UserProfileData,
    $$UserProfileTableFilterComposer,
    $$UserProfileTableOrderingComposer,
    $$UserProfileTableAnnotationComposer,
    $$UserProfileTableCreateCompanionBuilder,
    $$UserProfileTableUpdateCompanionBuilder,
    (UserProfileData, $$UserProfileTableReferences),
    UserProfileData,
    PrefetchHooks Function({bool userId})>;
typedef $$UserCredentialTableCreateCompanionBuilder = UserCredentialCompanion
    Function({
  Value<String?> userId,
  Value<String?> admno,
  Value<String?> accessToken,
  Value<String?> username,
  Value<String?> email,
  required String password,
  Value<DateTime?> lastLogin,
  Value<int> rowid,
});
typedef $$UserCredentialTableUpdateCompanionBuilder = UserCredentialCompanion
    Function({
  Value<String?> userId,
  Value<String?> admno,
  Value<String?> accessToken,
  Value<String?> username,
  Value<String?> email,
  Value<String> password,
  Value<DateTime?> lastLogin,
  Value<int> rowid,
});

final class $$UserCredentialTableReferences extends BaseReferences<
    _$AppDatabase, $UserCredentialTable, UserCredentialData> {
  $$UserCredentialTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $UserTable _userIdTable(_$AppDatabase db) => db.user
      .createAlias($_aliasNameGenerator(db.userCredential.userId, db.user.id));

  $$UserTableProcessedTableManager? get userId {
    final $_column = $_itemColumn<String>('user_id');
    if ($_column == null) return null;
    final manager = $$UserTableTableManager($_db, $_db.user)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $UserTable _usernameTable(_$AppDatabase db) => db.user.createAlias(
      $_aliasNameGenerator(db.userCredential.username, db.user.username));

  $$UserTableProcessedTableManager? get username {
    final $_column = $_itemColumn<String>('username');
    if ($_column == null) return null;
    final manager = $$UserTableTableManager($_db, $_db.user)
        .filter((f) => f.username.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_usernameTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $UserTable _emailTable(_$AppDatabase db) => db.user.createAlias(
      $_aliasNameGenerator(db.userCredential.email, db.user.email));

  $$UserTableProcessedTableManager? get email {
    final $_column = $_itemColumn<String>('email');
    if ($_column == null) return null;
    final manager = $$UserTableTableManager($_db, $_db.user)
        .filter((f) => f.email.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_emailTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$UserCredentialTableFilterComposer
    extends Composer<_$AppDatabase, $UserCredentialTable> {
  $$UserCredentialTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get admno => $composableBuilder(
      column: $table.admno, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get accessToken => $composableBuilder(
      column: $table.accessToken, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get password => $composableBuilder(
      column: $table.password, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastLogin => $composableBuilder(
      column: $table.lastLogin, builder: (column) => ColumnFilters(column));

  $$UserTableFilterComposer get userId {
    final $$UserTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.user,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableFilterComposer(
              $db: $db,
              $table: $db.user,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UserTableFilterComposer get username {
    final $$UserTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.username,
        referencedTable: $db.user,
        getReferencedColumn: (t) => t.username,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableFilterComposer(
              $db: $db,
              $table: $db.user,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UserTableFilterComposer get email {
    final $$UserTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.email,
        referencedTable: $db.user,
        getReferencedColumn: (t) => t.email,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableFilterComposer(
              $db: $db,
              $table: $db.user,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$UserCredentialTableOrderingComposer
    extends Composer<_$AppDatabase, $UserCredentialTable> {
  $$UserCredentialTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get admno => $composableBuilder(
      column: $table.admno, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get accessToken => $composableBuilder(
      column: $table.accessToken, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get password => $composableBuilder(
      column: $table.password, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastLogin => $composableBuilder(
      column: $table.lastLogin, builder: (column) => ColumnOrderings(column));

  $$UserTableOrderingComposer get userId {
    final $$UserTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.user,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableOrderingComposer(
              $db: $db,
              $table: $db.user,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UserTableOrderingComposer get username {
    final $$UserTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.username,
        referencedTable: $db.user,
        getReferencedColumn: (t) => t.username,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableOrderingComposer(
              $db: $db,
              $table: $db.user,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UserTableOrderingComposer get email {
    final $$UserTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.email,
        referencedTable: $db.user,
        getReferencedColumn: (t) => t.email,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableOrderingComposer(
              $db: $db,
              $table: $db.user,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$UserCredentialTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserCredentialTable> {
  $$UserCredentialTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get admno =>
      $composableBuilder(column: $table.admno, builder: (column) => column);

  GeneratedColumn<String> get accessToken => $composableBuilder(
      column: $table.accessToken, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  GeneratedColumn<DateTime> get lastLogin =>
      $composableBuilder(column: $table.lastLogin, builder: (column) => column);

  $$UserTableAnnotationComposer get userId {
    final $$UserTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.user,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableAnnotationComposer(
              $db: $db,
              $table: $db.user,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UserTableAnnotationComposer get username {
    final $$UserTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.username,
        referencedTable: $db.user,
        getReferencedColumn: (t) => t.username,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableAnnotationComposer(
              $db: $db,
              $table: $db.user,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UserTableAnnotationComposer get email {
    final $$UserTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.email,
        referencedTable: $db.user,
        getReferencedColumn: (t) => t.email,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableAnnotationComposer(
              $db: $db,
              $table: $db.user,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$UserCredentialTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserCredentialTable,
    UserCredentialData,
    $$UserCredentialTableFilterComposer,
    $$UserCredentialTableOrderingComposer,
    $$UserCredentialTableAnnotationComposer,
    $$UserCredentialTableCreateCompanionBuilder,
    $$UserCredentialTableUpdateCompanionBuilder,
    (UserCredentialData, $$UserCredentialTableReferences),
    UserCredentialData,
    PrefetchHooks Function({bool userId, bool username, bool email})> {
  $$UserCredentialTableTableManager(
      _$AppDatabase db, $UserCredentialTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserCredentialTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserCredentialTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserCredentialTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String?> userId = const Value.absent(),
            Value<String?> admno = const Value.absent(),
            Value<String?> accessToken = const Value.absent(),
            Value<String?> username = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String> password = const Value.absent(),
            Value<DateTime?> lastLogin = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UserCredentialCompanion(
            userId: userId,
            admno: admno,
            accessToken: accessToken,
            username: username,
            email: email,
            password: password,
            lastLogin: lastLogin,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String?> userId = const Value.absent(),
            Value<String?> admno = const Value.absent(),
            Value<String?> accessToken = const Value.absent(),
            Value<String?> username = const Value.absent(),
            Value<String?> email = const Value.absent(),
            required String password,
            Value<DateTime?> lastLogin = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UserCredentialCompanion.insert(
            userId: userId,
            admno: admno,
            accessToken: accessToken,
            username: username,
            email: email,
            password: password,
            lastLogin: lastLogin,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$UserCredentialTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {userId = false, username = false, email = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (userId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.userId,
                    referencedTable:
                        $$UserCredentialTableReferences._userIdTable(db),
                    referencedColumn:
                        $$UserCredentialTableReferences._userIdTable(db).id,
                  ) as T;
                }
                if (username) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.username,
                    referencedTable:
                        $$UserCredentialTableReferences._usernameTable(db),
                    referencedColumn: $$UserCredentialTableReferences
                        ._usernameTable(db)
                        .username,
                  ) as T;
                }
                if (email) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.email,
                    referencedTable:
                        $$UserCredentialTableReferences._emailTable(db),
                    referencedColumn:
                        $$UserCredentialTableReferences._emailTable(db).email,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$UserCredentialTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserCredentialTable,
    UserCredentialData,
    $$UserCredentialTableFilterComposer,
    $$UserCredentialTableOrderingComposer,
    $$UserCredentialTableAnnotationComposer,
    $$UserCredentialTableCreateCompanionBuilder,
    $$UserCredentialTableUpdateCompanionBuilder,
    (UserCredentialData, $$UserCredentialTableReferences),
    UserCredentialData,
    PrefetchHooks Function({bool userId, bool username, bool email})>;
typedef $$CourseTableCreateCompanionBuilder = CourseCompanion Function({
  required String unit,
  Value<String?> user,
  required String section,
  required String weekDay,
  required String campus,
  required String room,
  required String lecturer,
  required String period,
  Value<int?> color,
  Value<DateTime?> createdAt,
  Value<int> rowid,
});
typedef $$CourseTableUpdateCompanionBuilder = CourseCompanion Function({
  Value<String> unit,
  Value<String?> user,
  Value<String> section,
  Value<String> weekDay,
  Value<String> campus,
  Value<String> room,
  Value<String> lecturer,
  Value<String> period,
  Value<int?> color,
  Value<DateTime?> createdAt,
  Value<int> rowid,
});

final class $$CourseTableReferences
    extends BaseReferences<_$AppDatabase, $CourseTable, CourseData> {
  $$CourseTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UserTable _userTable(_$AppDatabase db) =>
      db.user.createAlias($_aliasNameGenerator(db.course.user, db.user.id));

  $$UserTableProcessedTableManager? get user {
    final $_column = $_itemColumn<String>('user');
    if ($_column == null) return null;
    final manager = $$UserTableTableManager($_db, $_db.user)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$TodoTable, List<TodoData>> _todoRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.todo,
          aliasName: $_aliasNameGenerator(db.course.unit, db.todo.unit));

  $$TodoTableProcessedTableManager get todoRefs {
    final manager = $$TodoTableTableManager($_db, $_db.todo)
        .filter((f) => f.unit.unit.sqlEquals($_itemColumn<String>('unit')!));

    final cache = $_typedResult.readTableOrNull(_todoRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CourseTableFilterComposer
    extends Composer<_$AppDatabase, $CourseTable> {
  $$CourseTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get section => $composableBuilder(
      column: $table.section, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get weekDay => $composableBuilder(
      column: $table.weekDay, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get campus => $composableBuilder(
      column: $table.campus, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get room => $composableBuilder(
      column: $table.room, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lecturer => $composableBuilder(
      column: $table.lecturer, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get period => $composableBuilder(
      column: $table.period, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$UserTableFilterComposer get user {
    final $$UserTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.user,
        referencedTable: $db.user,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableFilterComposer(
              $db: $db,
              $table: $db.user,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> todoRefs(
      Expression<bool> Function($$TodoTableFilterComposer f) f) {
    final $$TodoTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.unit,
        referencedTable: $db.todo,
        getReferencedColumn: (t) => t.unit,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TodoTableFilterComposer(
              $db: $db,
              $table: $db.todo,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CourseTableOrderingComposer
    extends Composer<_$AppDatabase, $CourseTable> {
  $$CourseTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get section => $composableBuilder(
      column: $table.section, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get weekDay => $composableBuilder(
      column: $table.weekDay, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get campus => $composableBuilder(
      column: $table.campus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get room => $composableBuilder(
      column: $table.room, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lecturer => $composableBuilder(
      column: $table.lecturer, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get period => $composableBuilder(
      column: $table.period, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$UserTableOrderingComposer get user {
    final $$UserTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.user,
        referencedTable: $db.user,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableOrderingComposer(
              $db: $db,
              $table: $db.user,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CourseTableAnnotationComposer
    extends Composer<_$AppDatabase, $CourseTable> {
  $$CourseTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<String> get section =>
      $composableBuilder(column: $table.section, builder: (column) => column);

  GeneratedColumn<String> get weekDay =>
      $composableBuilder(column: $table.weekDay, builder: (column) => column);

  GeneratedColumn<String> get campus =>
      $composableBuilder(column: $table.campus, builder: (column) => column);

  GeneratedColumn<String> get room =>
      $composableBuilder(column: $table.room, builder: (column) => column);

  GeneratedColumn<String> get lecturer =>
      $composableBuilder(column: $table.lecturer, builder: (column) => column);

  GeneratedColumn<String> get period =>
      $composableBuilder(column: $table.period, builder: (column) => column);

  GeneratedColumn<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$UserTableAnnotationComposer get user {
    final $$UserTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.user,
        referencedTable: $db.user,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableAnnotationComposer(
              $db: $db,
              $table: $db.user,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> todoRefs<T extends Object>(
      Expression<T> Function($$TodoTableAnnotationComposer a) f) {
    final $$TodoTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.unit,
        referencedTable: $db.todo,
        getReferencedColumn: (t) => t.unit,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TodoTableAnnotationComposer(
              $db: $db,
              $table: $db.todo,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CourseTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CourseTable,
    CourseData,
    $$CourseTableFilterComposer,
    $$CourseTableOrderingComposer,
    $$CourseTableAnnotationComposer,
    $$CourseTableCreateCompanionBuilder,
    $$CourseTableUpdateCompanionBuilder,
    (CourseData, $$CourseTableReferences),
    CourseData,
    PrefetchHooks Function({bool user, bool todoRefs})> {
  $$CourseTableTableManager(_$AppDatabase db, $CourseTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CourseTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CourseTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CourseTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> unit = const Value.absent(),
            Value<String?> user = const Value.absent(),
            Value<String> section = const Value.absent(),
            Value<String> weekDay = const Value.absent(),
            Value<String> campus = const Value.absent(),
            Value<String> room = const Value.absent(),
            Value<String> lecturer = const Value.absent(),
            Value<String> period = const Value.absent(),
            Value<int?> color = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CourseCompanion(
            unit: unit,
            user: user,
            section: section,
            weekDay: weekDay,
            campus: campus,
            room: room,
            lecturer: lecturer,
            period: period,
            color: color,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String unit,
            Value<String?> user = const Value.absent(),
            required String section,
            required String weekDay,
            required String campus,
            required String room,
            required String lecturer,
            required String period,
            Value<int?> color = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CourseCompanion.insert(
            unit: unit,
            user: user,
            section: section,
            weekDay: weekDay,
            campus: campus,
            room: room,
            lecturer: lecturer,
            period: period,
            color: color,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$CourseTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({user = false, todoRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (todoRefs) db.todo],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (user) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.user,
                    referencedTable: $$CourseTableReferences._userTable(db),
                    referencedColumn: $$CourseTableReferences._userTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (todoRefs)
                    await $_getPrefetchedData<CourseData, $CourseTable,
                            TodoData>(
                        currentTable: table,
                        referencedTable:
                            $$CourseTableReferences._todoRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CourseTableReferences(db, table, p0).todoRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.unit == item.unit),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CourseTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CourseTable,
    CourseData,
    $$CourseTableFilterComposer,
    $$CourseTableOrderingComposer,
    $$CourseTableAnnotationComposer,
    $$CourseTableCreateCompanionBuilder,
    $$CourseTableUpdateCompanionBuilder,
    (CourseData, $$CourseTableReferences),
    CourseData,
    PrefetchHooks Function({bool user, bool todoRefs})>;
typedef $$TodoTableCreateCompanionBuilder = TodoCompanion Function({
  Value<int?> id,
  required String userId,
  Value<String?> unit,
  required String title,
  required String body,
  Value<String?> subtasks,
  Value<int?> color,
  Value<bool> notify,
  Value<bool> complete,
  Value<bool> autocomplete,
  Value<DateTime?> notifyAt,
  Value<DateTime?> duedate,
  Value<DateTime> dateCreated,
  Value<DateTime> dateModified,
  Value<DateTime> completedAt,
});
typedef $$TodoTableUpdateCompanionBuilder = TodoCompanion Function({
  Value<int?> id,
  Value<String> userId,
  Value<String?> unit,
  Value<String> title,
  Value<String> body,
  Value<String?> subtasks,
  Value<int?> color,
  Value<bool> notify,
  Value<bool> complete,
  Value<bool> autocomplete,
  Value<DateTime?> notifyAt,
  Value<DateTime?> duedate,
  Value<DateTime> dateCreated,
  Value<DateTime> dateModified,
  Value<DateTime> completedAt,
});

final class $$TodoTableReferences
    extends BaseReferences<_$AppDatabase, $TodoTable, TodoData> {
  $$TodoTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UserTable _userIdTable(_$AppDatabase db) =>
      db.user.createAlias($_aliasNameGenerator(db.todo.userId, db.user.id));

  $$UserTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$UserTableTableManager($_db, $_db.user)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $CourseTable _unitTable(_$AppDatabase db) =>
      db.course.createAlias($_aliasNameGenerator(db.todo.unit, db.course.unit));

  $$CourseTableProcessedTableManager? get unit {
    final $_column = $_itemColumn<String>('unit');
    if ($_column == null) return null;
    final manager = $$CourseTableTableManager($_db, $_db.course)
        .filter((f) => f.unit.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_unitTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TodoTableFilterComposer extends Composer<_$AppDatabase, $TodoTable> {
  $$TodoTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get body => $composableBuilder(
      column: $table.body, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get subtasks => $composableBuilder(
      column: $table.subtasks, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get notify => $composableBuilder(
      column: $table.notify, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get complete => $composableBuilder(
      column: $table.complete, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get autocomplete => $composableBuilder(
      column: $table.autocomplete, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get notifyAt => $composableBuilder(
      column: $table.notifyAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get duedate => $composableBuilder(
      column: $table.duedate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dateCreated => $composableBuilder(
      column: $table.dateCreated, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dateModified => $composableBuilder(
      column: $table.dateModified, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnFilters(column));

  $$UserTableFilterComposer get userId {
    final $$UserTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.user,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableFilterComposer(
              $db: $db,
              $table: $db.user,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CourseTableFilterComposer get unit {
    final $$CourseTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.unit,
        referencedTable: $db.course,
        getReferencedColumn: (t) => t.unit,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CourseTableFilterComposer(
              $db: $db,
              $table: $db.course,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TodoTableOrderingComposer extends Composer<_$AppDatabase, $TodoTable> {
  $$TodoTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get body => $composableBuilder(
      column: $table.body, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get subtasks => $composableBuilder(
      column: $table.subtasks, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get notify => $composableBuilder(
      column: $table.notify, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get complete => $composableBuilder(
      column: $table.complete, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get autocomplete => $composableBuilder(
      column: $table.autocomplete,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get notifyAt => $composableBuilder(
      column: $table.notifyAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get duedate => $composableBuilder(
      column: $table.duedate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dateCreated => $composableBuilder(
      column: $table.dateCreated, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dateModified => $composableBuilder(
      column: $table.dateModified,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnOrderings(column));

  $$UserTableOrderingComposer get userId {
    final $$UserTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.user,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableOrderingComposer(
              $db: $db,
              $table: $db.user,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CourseTableOrderingComposer get unit {
    final $$CourseTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.unit,
        referencedTable: $db.course,
        getReferencedColumn: (t) => t.unit,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CourseTableOrderingComposer(
              $db: $db,
              $table: $db.course,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TodoTableAnnotationComposer
    extends Composer<_$AppDatabase, $TodoTable> {
  $$TodoTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<String> get subtasks =>
      $composableBuilder(column: $table.subtasks, builder: (column) => column);

  GeneratedColumn<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<bool> get notify =>
      $composableBuilder(column: $table.notify, builder: (column) => column);

  GeneratedColumn<bool> get complete =>
      $composableBuilder(column: $table.complete, builder: (column) => column);

  GeneratedColumn<bool> get autocomplete => $composableBuilder(
      column: $table.autocomplete, builder: (column) => column);

  GeneratedColumn<DateTime> get notifyAt =>
      $composableBuilder(column: $table.notifyAt, builder: (column) => column);

  GeneratedColumn<DateTime> get duedate =>
      $composableBuilder(column: $table.duedate, builder: (column) => column);

  GeneratedColumn<DateTime> get dateCreated => $composableBuilder(
      column: $table.dateCreated, builder: (column) => column);

  GeneratedColumn<DateTime> get dateModified => $composableBuilder(
      column: $table.dateModified, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => column);

  $$UserTableAnnotationComposer get userId {
    final $$UserTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.user,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableAnnotationComposer(
              $db: $db,
              $table: $db.user,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CourseTableAnnotationComposer get unit {
    final $$CourseTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.unit,
        referencedTable: $db.course,
        getReferencedColumn: (t) => t.unit,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CourseTableAnnotationComposer(
              $db: $db,
              $table: $db.course,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TodoTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TodoTable,
    TodoData,
    $$TodoTableFilterComposer,
    $$TodoTableOrderingComposer,
    $$TodoTableAnnotationComposer,
    $$TodoTableCreateCompanionBuilder,
    $$TodoTableUpdateCompanionBuilder,
    (TodoData, $$TodoTableReferences),
    TodoData,
    PrefetchHooks Function({bool userId, bool unit})> {
  $$TodoTableTableManager(_$AppDatabase db, $TodoTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TodoTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TodoTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TodoTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String?> unit = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> body = const Value.absent(),
            Value<String?> subtasks = const Value.absent(),
            Value<int?> color = const Value.absent(),
            Value<bool> notify = const Value.absent(),
            Value<bool> complete = const Value.absent(),
            Value<bool> autocomplete = const Value.absent(),
            Value<DateTime?> notifyAt = const Value.absent(),
            Value<DateTime?> duedate = const Value.absent(),
            Value<DateTime> dateCreated = const Value.absent(),
            Value<DateTime> dateModified = const Value.absent(),
            Value<DateTime> completedAt = const Value.absent(),
          }) =>
              TodoCompanion(
            id: id,
            userId: userId,
            unit: unit,
            title: title,
            body: body,
            subtasks: subtasks,
            color: color,
            notify: notify,
            complete: complete,
            autocomplete: autocomplete,
            notifyAt: notifyAt,
            duedate: duedate,
            dateCreated: dateCreated,
            dateModified: dateModified,
            completedAt: completedAt,
          ),
          createCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            required String userId,
            Value<String?> unit = const Value.absent(),
            required String title,
            required String body,
            Value<String?> subtasks = const Value.absent(),
            Value<int?> color = const Value.absent(),
            Value<bool> notify = const Value.absent(),
            Value<bool> complete = const Value.absent(),
            Value<bool> autocomplete = const Value.absent(),
            Value<DateTime?> notifyAt = const Value.absent(),
            Value<DateTime?> duedate = const Value.absent(),
            Value<DateTime> dateCreated = const Value.absent(),
            Value<DateTime> dateModified = const Value.absent(),
            Value<DateTime> completedAt = const Value.absent(),
          }) =>
              TodoCompanion.insert(
            id: id,
            userId: userId,
            unit: unit,
            title: title,
            body: body,
            subtasks: subtasks,
            color: color,
            notify: notify,
            complete: complete,
            autocomplete: autocomplete,
            notifyAt: notifyAt,
            duedate: duedate,
            dateCreated: dateCreated,
            dateModified: dateModified,
            completedAt: completedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$TodoTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({userId = false, unit = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (userId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.userId,
                    referencedTable: $$TodoTableReferences._userIdTable(db),
                    referencedColumn: $$TodoTableReferences._userIdTable(db).id,
                  ) as T;
                }
                if (unit) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.unit,
                    referencedTable: $$TodoTableReferences._unitTable(db),
                    referencedColumn: $$TodoTableReferences._unitTable(db).unit,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$TodoTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TodoTable,
    TodoData,
    $$TodoTableFilterComposer,
    $$TodoTableOrderingComposer,
    $$TodoTableAnnotationComposer,
    $$TodoTableCreateCompanionBuilder,
    $$TodoTableUpdateCompanionBuilder,
    (TodoData, $$TodoTableReferences),
    TodoData,
    PrefetchHooks Function({bool userId, bool unit})>;
typedef $$ExamModelTableCreateCompanionBuilder = ExamModelCompanion Function({
  required String courseCode,
  required DateTime examDate,
  required String venue,
  required String campus,
  required String hours,
  Value<String?> invigilator,
  Value<int> rowid,
});
typedef $$ExamModelTableUpdateCompanionBuilder = ExamModelCompanion Function({
  Value<String> courseCode,
  Value<DateTime> examDate,
  Value<String> venue,
  Value<String> campus,
  Value<String> hours,
  Value<String?> invigilator,
  Value<int> rowid,
});

class $$ExamModelTableFilterComposer
    extends Composer<_$AppDatabase, $ExamModelTable> {
  $$ExamModelTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get courseCode => $composableBuilder(
      column: $table.courseCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get examDate => $composableBuilder(
      column: $table.examDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get venue => $composableBuilder(
      column: $table.venue, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get campus => $composableBuilder(
      column: $table.campus, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get hours => $composableBuilder(
      column: $table.hours, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get invigilator => $composableBuilder(
      column: $table.invigilator, builder: (column) => ColumnFilters(column));
}

class $$ExamModelTableOrderingComposer
    extends Composer<_$AppDatabase, $ExamModelTable> {
  $$ExamModelTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get courseCode => $composableBuilder(
      column: $table.courseCode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get examDate => $composableBuilder(
      column: $table.examDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get venue => $composableBuilder(
      column: $table.venue, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get campus => $composableBuilder(
      column: $table.campus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get hours => $composableBuilder(
      column: $table.hours, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get invigilator => $composableBuilder(
      column: $table.invigilator, builder: (column) => ColumnOrderings(column));
}

class $$ExamModelTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExamModelTable> {
  $$ExamModelTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get courseCode => $composableBuilder(
      column: $table.courseCode, builder: (column) => column);

  GeneratedColumn<DateTime> get examDate =>
      $composableBuilder(column: $table.examDate, builder: (column) => column);

  GeneratedColumn<String> get venue =>
      $composableBuilder(column: $table.venue, builder: (column) => column);

  GeneratedColumn<String> get campus =>
      $composableBuilder(column: $table.campus, builder: (column) => column);

  GeneratedColumn<String> get hours =>
      $composableBuilder(column: $table.hours, builder: (column) => column);

  GeneratedColumn<String> get invigilator => $composableBuilder(
      column: $table.invigilator, builder: (column) => column);
}

class $$ExamModelTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExamModelTable,
    ExamModelData,
    $$ExamModelTableFilterComposer,
    $$ExamModelTableOrderingComposer,
    $$ExamModelTableAnnotationComposer,
    $$ExamModelTableCreateCompanionBuilder,
    $$ExamModelTableUpdateCompanionBuilder,
    (
      ExamModelData,
      BaseReferences<_$AppDatabase, $ExamModelTable, ExamModelData>
    ),
    ExamModelData,
    PrefetchHooks Function()> {
  $$ExamModelTableTableManager(_$AppDatabase db, $ExamModelTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExamModelTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExamModelTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExamModelTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> courseCode = const Value.absent(),
            Value<DateTime> examDate = const Value.absent(),
            Value<String> venue = const Value.absent(),
            Value<String> campus = const Value.absent(),
            Value<String> hours = const Value.absent(),
            Value<String?> invigilator = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ExamModelCompanion(
            courseCode: courseCode,
            examDate: examDate,
            venue: venue,
            campus: campus,
            hours: hours,
            invigilator: invigilator,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String courseCode,
            required DateTime examDate,
            required String venue,
            required String campus,
            required String hours,
            Value<String?> invigilator = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ExamModelCompanion.insert(
            courseCode: courseCode,
            examDate: examDate,
            venue: venue,
            campus: campus,
            hours: hours,
            invigilator: invigilator,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ExamModelTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExamModelTable,
    ExamModelData,
    $$ExamModelTableFilterComposer,
    $$ExamModelTableOrderingComposer,
    $$ExamModelTableAnnotationComposer,
    $$ExamModelTableCreateCompanionBuilder,
    $$ExamModelTableUpdateCompanionBuilder,
    (
      ExamModelData,
      BaseReferences<_$AppDatabase, $ExamModelTable, ExamModelData>
    ),
    ExamModelData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AttendanceModelTableTableManager get attendanceModel =>
      $$AttendanceModelTableTableManager(_db, _db.attendanceModel);
  $$UserTableTableManager get user => $$UserTableTableManager(_db, _db.user);
  $$UserProfileTableTableManager get userProfile =>
      $$UserProfileTableTableManager(_db, _db.userProfile);
  $$UserCredentialTableTableManager get userCredential =>
      $$UserCredentialTableTableManager(_db, _db.userCredential);
  $$CourseTableTableManager get course =>
      $$CourseTableTableManager(_db, _db.course);
  $$TodoTableTableManager get todo => $$TodoTableTableManager(_db, _db.todo);
  $$ExamModelTableTableManager get examModel =>
      $$ExamModelTableTableManager(_db, _db.examModel);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 1;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User()
      ..name = fields[0] as String?
      ..gpa = fields[1] == null ? 0.0 : fields[1] as double?
      ..admno = fields[2] as String?
      ..password = fields[3] as String?
      ..idno = fields[4] as String?
      ..gender = fields[5] as String?
      ..address = fields[6] as String?
      ..email = fields[7] as String?
      ..dateOfBirth = fields[8] as String?
      ..campus = fields[9] as String?
      ..programme = fields[10] as String?
      ..completedUnits = fields[11] as String?
      ..status = fields[12] as String?
      ..amountBilled = fields[13] as String?
      ..amountPaid = fields[14] as String?
      ..balance = fields[15] as String?
      ..cookie = fields[16] as String?
      ..profile = fields[17] as String?;
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.gpa)
      ..writeByte(2)
      ..write(obj.admno)
      ..writeByte(3)
      ..write(obj.password)
      ..writeByte(4)
      ..write(obj.idno)
      ..writeByte(5)
      ..write(obj.gender)
      ..writeByte(6)
      ..write(obj.address)
      ..writeByte(7)
      ..write(obj.email)
      ..writeByte(8)
      ..write(obj.dateOfBirth)
      ..writeByte(9)
      ..write(obj.campus)
      ..writeByte(10)
      ..write(obj.programme)
      ..writeByte(11)
      ..write(obj.completedUnits)
      ..writeByte(12)
      ..write(obj.status)
      ..writeByte(13)
      ..write(obj.amountBilled)
      ..writeByte(14)
      ..write(obj.amountPaid)
      ..writeByte(15)
      ..write(obj.balance)
      ..writeByte(16)
      ..write(obj.cookie)
      ..writeByte(17)
      ..write(obj.profile);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

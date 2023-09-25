// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'courses.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CoursesAdapter extends TypeAdapter<Courses> {
  @override
  final int typeId = 2;

  @override
  Courses read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Courses(
      name: fields[0] as String?,
      venue: fields[1] as String?,
      section: fields[2] as String?,
      time: fields[3] as String?,
      dayOfTheWeek: fields[4] as String?,
      period: fields[5] as String?,
      room: fields[6] as String?,
      lecturer: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Courses obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.venue)
      ..writeByte(2)
      ..write(obj.section)
      ..writeByte(3)
      ..write(obj.time)
      ..writeByte(4)
      ..write(obj.dayOfTheWeek)
      ..writeByte(5)
      ..write(obj.period)
      ..writeByte(6)
      ..write(obj.room)
      ..writeByte(7)
      ..write(obj.lecturer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoursesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

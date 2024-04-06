// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExamAdapter extends TypeAdapter<Exam> {
  @override
  final int typeId = 4;

  @override
  Exam read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Exam(
      courseCode: fields[0] as String,
      day: fields[1] as String,
      time: fields[2] as String,
      venue: fields[3] as String,
      hrs: fields[4] as String,
      invigilator: fields[5] as String?,
      coordinator: fields[6] as String?,
      campus: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Exam obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.courseCode)
      ..writeByte(1)
      ..write(obj.day)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.venue)
      ..writeByte(4)
      ..write(obj.hrs)
      ..writeByte(5)
      ..write(obj.invigilator)
      ..writeByte(6)
      ..write(obj.coordinator)
      ..writeByte(7)
      ..write(obj.campus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExamAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

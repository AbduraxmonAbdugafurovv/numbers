// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NumberFactModelAdapter extends TypeAdapter<NumberFactModel> {
  @override
  final int typeId = 0;

  @override
  NumberFactModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NumberFactModel(
      number: fields[0] as String,
      category: fields[1] as String,
      fact: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NumberFactModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.number)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.fact);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NumberFactModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

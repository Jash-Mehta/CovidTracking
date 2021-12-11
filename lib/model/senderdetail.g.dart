// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'senderdetail.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SenderDetailAdapter extends TypeAdapter<SenderDetail> {
  @override
  final int typeId = 0;

  @override
  SenderDetail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SenderDetail(
      name: fields[0] as String,
      address: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SenderDetail obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.address);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SenderDetailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

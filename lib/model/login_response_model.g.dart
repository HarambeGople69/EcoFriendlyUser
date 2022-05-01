// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class loginResponseAdapter extends TypeAdapter<loginResponse> {
  @override
  final int typeId = 0;

  @override
  loginResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return loginResponse(
      status: fields[0] as dynamic,
      token: fields[1] as String?,
      success: fields[2] as int?,
      userName: fields[3] as String?,
      userId: fields[4] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, loginResponse obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.token)
      ..writeByte(2)
      ..write(obj.success)
      ..writeByte(3)
      ..write(obj.userName)
      ..writeByte(4)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is loginResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

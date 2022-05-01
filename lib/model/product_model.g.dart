// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModalClassAdapter extends TypeAdapter<ProductModalClass> {
  @override
  final int typeId = 1;

  @override
  ProductModalClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModalClass(
      categoryname: fields[0] as String?,
      productname: fields[1] as String?,
      listprice: fields[2] as String?,
      description: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductModalClass obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.categoryname)
      ..writeByte(1)
      ..write(obj.productname)
      ..writeByte(2)
      ..write(obj.listprice)
      ..writeByte(3)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModalClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

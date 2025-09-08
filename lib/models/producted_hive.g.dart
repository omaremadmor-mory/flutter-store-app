// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'producted_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductedHiveAdapter extends TypeAdapter<ProductedHive> {
  @override
  final int typeId = 1;

  @override
  ProductedHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductedHive(
      name: fields[0] as String,
      description: fields[1] as String,
      imagePath: fields[2] as String,
      price: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, ProductedHive obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.imagePath)
      ..writeByte(3)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductedHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

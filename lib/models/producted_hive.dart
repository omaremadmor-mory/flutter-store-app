import 'package:hive/hive.dart';

part 'producted_hive.g.dart';

@HiveType(typeId: 1)
class ProductedHive extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final String imagePath;

  @HiveField(3)
  final double price;

  ProductedHive({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
  });
}

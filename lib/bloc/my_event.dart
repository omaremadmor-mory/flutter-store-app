part of 'my_bloc.dart';

@immutable
sealed class MyEvent {}

class LoadProducts extends MyEvent {}

class Addproduct extends MyEvent {
  final ProductedHive product;
  Addproduct({required this.product});
}

class Removeproduct extends MyEvent {
  final ProductedHive product;
  Removeproduct({required this.product});
}

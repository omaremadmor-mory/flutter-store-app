part of 'my_bloc.dart';

@immutable
sealed class MyState {}

final class MyInitial extends MyState {}

class Productloaded extends MyState {
  final List<ProductedHive> product;
  Productloaded(this.product);
}

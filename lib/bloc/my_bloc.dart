import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:viro_store2/models/producted_hive.dart';

part 'my_event.dart';
part 'my_state.dart';

class MyBloc extends Bloc<MyEvent, MyState> {
  final Box<ProductedHive> box;
  MyBloc(this.box) : super(MyInitial()) {
    on<LoadProducts>((event, emit) {
      final products = box.values.toList();
      emit(Productloaded(products));
    });
    on<Addproduct>((event, emit) {
      box.add(event.product);
      emit(Productloaded(box.values.toList()));
    });
    on<Removeproduct>((event, emit) {
      box.delete(event.product.key);
      emit(Productloaded(box.values.toList()));
    });
  }
}

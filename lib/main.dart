import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:viro_store2/bloc/my_bloc.dart';
import 'package:viro_store2/models/producted_hive.dart';
import 'package:viro_store2/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductedHiveAdapter());
  final productBox = await Hive.openBox<ProductedHive>('data');
  runApp(
    BlocProvider(
      create: (context) => MyBloc(productBox)..add(LoadProducts()),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      home: HomeScreen(),
    );
  }
}

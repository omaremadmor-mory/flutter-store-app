import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:viro_store2/bloc/my_bloc.dart';
import 'package:viro_store2/models/data.dart';
import 'package:viro_store2/models/producted_hive.dart';
import 'package:viro_store2/screens/screen_deatlies.dart';
import 'package:viro_store2/screens/shopping_cart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  List<ProductedHive> products = categorydata;
  List<ProductedHive> fitheredata = [];

  bool isSearching = false;
  PreferredSizeWidget appBarIteam() {
    return AppBar(
      backgroundColor: Colors.blueAccent,
      title: Text("Products"),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: GestureDetector(
            onTap: () {
              setState(() {
                isSearching = true;
              });
            },

            child: Icon(Icons.search),
          ),
        ),
        BlocBuilder<MyBloc, MyState>(
          builder: (context, state) {
            if (state is Productloaded) {
              final count = state.product.length;
              return Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Stack(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShoppingCart(),
                          ),
                        );
                      },
                      icon: Icon(Icons.shopping_cart),
                    ),
                    Positioned(
                      right: 5,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '$count',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ],
    );
  }

  PreferredSizeWidget searchbariteam() {
    return AppBar(
      backgroundColor: Colors.blueAccent,
      title: TextFormField(
        onChanged: (input) {
          addDatatoFilterdata(input: input);
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "search for product...",
          hintStyle: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: GestureDetector(
            onTap: () {
              setState(() {
                isSearching = false;
                searchController.text = "";
                fitheredata.cast();
              });
            },
            child: Icon(Icons.clear),
          ),
        ),
      ],
    );
  }

  void addDatatoFilterdata({required String input}) {
    setState(() {
      fitheredata = products
          .where(
            (element) =>
                element.name.toLowerCase().contains(input.toLowerCase()),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isSearching ? searchbariteam() : appBarIteam(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueAccent),
              child: Text(
                "Menu",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text("Search"),
              onTap: () {
                setState(() {
                  isSearching = true;
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text("Cart"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: (SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.65,
          )),
          itemCount: fitheredata.isNotEmpty
              ? fitheredata.length
              : categorydata.length,
          itemBuilder: (context, index) {
            final date = fitheredata.isNotEmpty
                ? fitheredata[index]
                : categorydata[index];
            return ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(15),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScreenDeatlies(product: date),
                    ),
                  );
                },
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image.asset("assets/images/${date.imagePath}"),
                        ),
                        Text(
                          date.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${date.price} EGP",
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                var box = Hive.box<ProductedHive>("data");
                                context.read<MyBloc>().add(
                                  Addproduct(
                                    product: ProductedHive(
                                      name: date.name,
                                      description: date.description,
                                      price: date.price.toDouble(),
                                      imagePath:
                                          "assets/images/${date.imagePath}",
                                    ),
                                  ),
                                );

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("${date.name} اتضاف للسلة ✅"),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text("اضف للسلة"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

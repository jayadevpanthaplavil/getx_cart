import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'Carts.dart';
import 'Products.dart';
void main() {
  runApp(MyApp());
}

class ApiController extends GetxController {
  RxList<Carts> _carts = <Carts>[].obs;

  Future<void> fetchCart() async {
    final response =
    await http.get(Uri.parse("https://dummyjson.com/carts"));
    if (response.statusCode == 200) {
      var getCartsData = json.decode(response.body.toString());
      final cartsData = getCartsData['carts'] as List<dynamic>;

      final cartList = cartsData
          .map((CartJson) => Carts.fromJson(CartJson))
          .toList();

      _carts.assignAll(cartList);
    } else {
      throw Exception('Failed to load quotes');
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiController apiController = Get.put(ApiController());

  @override
  Widget build(BuildContext context) {
    apiController.fetchCart();
    return Scaffold(
      appBar:AppBar(
        title: Text('GetX cart'),
      ),
      body: Obx(()=>ListView.builder(
          itemCount: apiController._carts.length,
          itemBuilder: (BuildContext context, int index) {
            Carts cart1 = apiController._carts[index];
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text("Cart ID - ${cart1.id}"),
                    Text("User ID - ${cart1.userId}"),

                    Container(
                      height: 60,
                      child: ListView.builder(itemCount: cart1.products?.length,itemBuilder: (BuildContext context,int index){
                        Products products=cart1.products![index] as Products;
                        return Column(
                          children: [
                            Text("${products.title}")
                          ],
                        );
                      }),
                    ),

                    // Row(
                    //   children: [
                    //     Text("Status  - "),
                    //     Container(child: us.completed==true ? Icon(Icons.done): Icon(Icons.error)),
                    //   ],
                    // ),
                  ],
                ),
              ),
            );
          })),
    );
  }
}


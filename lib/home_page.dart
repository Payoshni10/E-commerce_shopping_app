import 'package:flutter/material.dart';
import 'package:shop_app_flutter/product_list.dart';
import 'package:shop_app_flutter/cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentPage =0;

  List<Widget> pages=const [
    ProductList(),
    CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:IndexedStack(//this is be used to maintain the original position of last scrolled at in your page 
        index:currentPage,
        children: pages,
      ),
      /*method 2.. currentPage == 0
      ?ProductList()
      :CartPage(),*/
      /*method 3..pages[currentPage]*/
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 35,
        selectedFontSize: 0,//so that label doesnt occupy space
        unselectedFontSize: 0,//so that label doesnt occupy space
        onTap: (value) {
          setState(() {
            currentPage = value;
          });
        },
        currentIndex: currentPage,
        items:const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label:'',
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label:'',
            ),  
        ]
      ),
    );
  }
}

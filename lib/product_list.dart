import 'package:flutter/material.dart';
import 'package:shop_app_flutter/global_variables.dart';
import 'package:shop_app_flutter/product_card.dart';
import 'package:shop_app_flutter/product_details_page.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  
  final List<String> filters =const [
    'All',
    'Adidas',
    'Nike',
    'Puma',
    'Converse',
  ];

  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';


  List<Map<String, dynamic>> get filteredProducts {//checks which tab is been clicked on
  if (selectedFilter == 'All') return products;
  return products.where((product) =>
    (product['company'] as String).toLowerCase().contains(selectedFilter.toLowerCase())
  ).toList();
}


  late String selectedFilter;

   @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(225, 225, 225, 1) 
                    ),
                    borderRadius: BorderRadius.horizontal(left:Radius.circular(50))//we need a circular edge only on the left side.we can use only too
                  );

    // Filter logic
    final filteredProducts = products.where((product) {
      final title = (product['company'] as String).toLowerCase();
      final matchesSearch = title.contains(searchQuery.toLowerCase());
      final matchesFilter = selectedFilter == 'All' ||
          title.contains(selectedFilter.toLowerCase());
      return matchesSearch && matchesFilter;
    }).toList();

    
    return SafeArea(
        child: Column(
          children: [
            Row( //shoes collection text + the search bar
              children: [
               Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('Shoes\nCollection' , 
                  style:Theme.of(context).textTheme.titleLarge,
                ),
              ),
            Expanded(//takes as much space/width possibly available [works on all screen sizes]
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase();
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: border,
                  enabledBorder: border,
                  focusedBorder: border,
                ),
              ),
            ),
          ],
          ), 
          SizedBox(//chips showing all the categories
            height:120,
            child: ListView.builder(//we can use row , use list when there are more categories to be added
              scrollDirection: Axis.horizontal,
              itemCount: filters.length ,
              itemBuilder: (context, index) {
                final filter = filters[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),//we can use only too
                  child: GestureDetector(//we will not wrap padding with gesture detector(it will start operating even if we click outside the chips hence why)
                    onTap:(){
                      setState(() {
                        selectedFilter = filter;
                      }); 
                    } ,
                    child: Chip(
                      backgroundColor: selectedFilter == filter 
                      ? Theme.of(context).colorScheme.primary 
                      : Color.fromRGBO(245, 247, 249, 1),
                      side:BorderSide(color: Color.fromRGBO(245, 247, 249, 1)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      label: Text(filter),
                      labelStyle: TextStyle(fontSize: 16),
                      padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 15),
                      ),
                  ),
                );
                },
            ),
          ),
          Expanded(
            child: AnimatedSwitcher(
            duration: Duration(milliseconds: 400),
            child: ListView.builder(
              key: ValueKey<String>(selectedFilter + searchQuery), // So AnimatedSwitcher knows when to rebuild
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return GestureDetector(//transition from one page to another
                  onTap: () {
                    Navigator.of(context).push(//these are platform adaptive
                      MaterialPageRoute(
                        builder: (context){
                          return ProductDetailsPage(product: product);
                        }
                      )
                    );
                  },
                  child: ProductCard(
                    title:product['title'] as String,
                    price:product['price'] as double,
                    image:product['imageUrl'] as String,//we need to pass it as string as its assumed to be an object
                    backgroundColor: index.isEven 
                    ?const Color.fromRGBO(216, 240, 253, 1) 
                    :const Color.fromRGBO(245, 247, 249, 1),
                    ),
                );
              },
            ),
          ),
          ),
          ],
        ),
      );
  }
}
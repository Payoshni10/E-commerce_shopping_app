import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final double price;
  final String image;
  final Color backgroundColor;
  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.image,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(//we can use card too , card will provide elevation
    margin: EdgeInsets.all(20),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color:backgroundColor,
      ),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(//it will use the text theme defined in main.dart
            title ,
            style :Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height:5),
          Text(
            '₹$price',//if $is used write \$$price
            style :Theme.of(context).textTheme.bodySmall,
          ), 
          const SizedBox(height:5),
          Center(child: Image.asset(image , height:175)),
        ],
        )
    );
  }
}
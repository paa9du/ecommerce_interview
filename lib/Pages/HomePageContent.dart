import 'package:ecommerce_interview/Pages/CartPage.dart';
import 'package:ecommerce_interview/Pages/ItemDetailsPage.dart';
import 'package:ecommerce_interview/Pages/PaymentPage.dart';
import 'package:ecommerce_interview/Pages/Profilepage.dart';
import 'package:ecommerce_interview/Pages/WishListPage.dart';
import 'package:ecommerce_interview/Sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math';

import '../DataModel.dart';

class CategoryItem extends StatelessWidget {
  final String text;

  const CategoryItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.screenWidth(context) * 0.28,
      //   height: Dimensions.height45(context),
      margin: EdgeInsets.only(right: Dimensions.width10(context)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.star, color: Colors.yellow),
          SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  // Fetching data
  final List<Product> products;

  HomePageContent({required this.products});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: Dimensions.height10(context),
        ),
        // ... Your existing content goes here

        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (products.length > 1)
              Row(
                children: [
                  BoxWidget(product: products[0]),
                  BoxWidget(product: products[1]),
                ],
              ),
            if (products.length > 3)
              Row(
                children: [
                  BoxWidget(product: products[2]),
                  BoxWidget(product: products[3]),
                ],
              ),
            if (products.length > 5)
              Row(
                children: [
                  BoxWidget(product: products[4]),
                  BoxWidget(product: products[5]),
                ],
              ),
            if (products.length > 7)
              Row(
                children: [
                  BoxWidget(product: products[6]),
                  BoxWidget(product: products[7]),
                ],
              ),
            if (products.length > 9)
              Row(
                children: [
                  BoxWidget(product: products[8]),
                  BoxWidget(product: products[9]),
                ],
              ),
          ],
        ),
      ],
    );
  }
}

class BoxWidget extends StatefulWidget {
  final Product product;

  BoxWidget({required this.product});

  @override
  State<BoxWidget> createState() => _BoxWidgetState();
}

class _BoxWidgetState extends State<BoxWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to another page here
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemDetailPage(product: widget.product),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(
          left: Dimensions.width20(context),
          right: Dimensions.width10(context),
        ),
        child: Container(
          width: Dimensions.width30(context) * 5.5,
          height: Dimensions.height45(context) * 6.5,
          margin: EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color.fromARGB(255, 163, 161, 161),
                      ),
                      color: Color.fromARGB(255, 116, 191, 235),
                    ),
                    child: Center(
                      child: Text("${Random().nextInt(100)}%"),
                    ),
                  ),
                  SizedBox(
                    width: Dimensions.width30(context) * 2.3,
                  ),
                  Container(
                    child: Padding(
                      padding:
                          EdgeInsets.all(Dimensions.width10(context) * 0.8),
                      child: MyIconWidget(),
                    ),
                  ),
                ],
              ),
              Container(
                width: Dimensions.width30(context) * 4.5,
                height: Dimensions.height45(context) * 2.5,
                child: Image.network(
                  widget.product.image,
                  fit: BoxFit.cover,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                margin: EdgeInsets.all(8.0),
                child: Text(
                  widget.product.title,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  maxLines: 2, // Set the maximum number of lines
                  overflow:
                      TextOverflow.ellipsis, // Handle overflow with ellipsis
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Container(
                child: Text(
                  '₹${widget.product.price}',
                  style: TextStyle(fontSize: 15, color: Colors.blue),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.width15(context)),
                child: Container(
                  child: Row(
                    children: [
                      StarRating(rating: widget.product.rating.rate),
                      SizedBox(width: 5),
                      Text(
                        '(${widget.product.rating.count})', // You can show count if needed
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyIconWidget extends StatefulWidget {
  @override
  _MyIconWidgetState createState() => _MyIconWidgetState();
}

class _MyIconWidgetState extends State<MyIconWidget> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isFavorite = !isFavorite;
        });
      },
      child: Container(
        width: 40,
        height: 30,
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 182, 180, 180)),
          borderRadius: BorderRadius.circular(20),
          color: isFavorite ? Colors.red : Colors.transparent,
        ),
        child: Center(
          child: Icon(
            Icons.favorite,
            color: isFavorite ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final double rating;
  final int starCount;

  StarRating({required this.rating, this.starCount = 5});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        starCount,
        (index) {
          double difference = rating - index;
          double starValue = difference.clamp(0.0, 1.0);

          return Icon(
            starValue >= 0.5 ? Icons.star : Icons.star_border,
            size: 20,
            color: Colors.amber,
          );
        },
      ),
    );
  }
}

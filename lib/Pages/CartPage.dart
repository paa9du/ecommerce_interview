import 'dart:math';

import 'package:ecommerce_interview/DataModel.dart';
import 'package:ecommerce_interview/DataModelController.dart';
import 'package:ecommerce_interview/Pages/PaymentPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Sizes.dart';
import 'HomePage.dart';
import 'ItemDetailsPage.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Center(
          child: Text(
            'Cart History',
            style: TextStyle(color: Colors.blue, fontSize: 22),
          ),
        ),
      ),
      body: ChangeNotifierProvider(
        create: (context) => QuantityProvider(),
        child: Consumer<QuantityProvider>(
          builder: (context, quantityProvider, _) => Container(
            height: MediaQuery.of(context).size.height / 3.9,
            child: Row(
              children: [
                // First part with pic
                Container(
                  height: 150,
                  decoration: BoxDecoration(),
                  child: Center(
                    child: Image.network(
                      widget.product.image,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                // Second part with details
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.title,
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Quantity : ${Random().nextInt(10)}',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Total : ₹ ${Random().nextInt(500)}',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(color: Colors.black),
                                ),
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ItemDetailPage(
                                            product: widget.product,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Icon(Icons.edit)),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(color: Colors.black),
                                ),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Icon(Icons.delete),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
            left: Dimensions.width30(context),
            right: Dimensions.width30(context),
            bottom: Dimensions.height20(context)),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: Dimensions.height20(context),
                bottom: Dimensions.height20(context),
                left: Dimensions.width20(context),
                right: Dimensions.width20(context),
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius:
                    BorderRadius.circular(Dimensions.radius20(context)),
                color: Colors.green,
              ),
              child: GestureDetector(
                onTap: () {},
                child: Text(
                  'Total:  ₹ ${Random(1000).nextInt(10000)}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              width: 70,
            ),
            GestureDetector(
              onTap: () {
                // Your logic for checking out
                // You can navigate to the checkout page or perform other actions
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentPage(),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.only(
                  top: Dimensions.height20(context),
                  bottom: Dimensions.height10(context),
                  left: Dimensions.width20(context),
                  right: Dimensions.width20(context),
                ),
                child: Text(
                  'Check Out',
                  style: TextStyle(color: Colors.white),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    Dimensions.radius20(context),
                  ),
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

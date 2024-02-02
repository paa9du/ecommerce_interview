import 'package:ecommerce_interview/DataModelController.dart';

import 'package:ecommerce_interview/Pages/HomePage.dart';

import 'package:ecommerce_interview/Sizes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../DataModel.dart';

import 'CartPage.dart';

class ItemDetailPage extends StatefulWidget {
  final Product product;
  const ItemDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  bool isFavorite = false;
  late double totalPrice;
  String totalCostText = '';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QuantityProvider(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
            ),
            title: const Center(
              child: Text(
                'Xpress Shopping',
                style: TextStyle(
                  fontSize: 22.0,
                  color: Color.fromARGB(255, 112, 51, 233),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(
                  right: Dimensions.width30(context),
                ),
                child: Consumer<QuantityProvider>(
                  builder: (context, quantityProvider, child) {
                    return Opacity(
                      opacity: quantityProvider.quantity > 0 ? 1.0 : 0.5,
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (quantityProvider.quantity > 0) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CartPage(
                                      product: widget.product,
                                    ),
                                  ),
                                );
                              } else {
                                // Show a Snackbar if the quantity is zero
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Quantity should be greater than zero.",
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                            child: Icon(Icons.shopping_cart),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Consumer<QuantityProvider>(
                              builder: (context, quantityProvider, _) {
                                final int itemCount = quantityProvider.quantity;

                                return itemCount > 0
                                    ? Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red,
                                        ),
                                        child: Text(
                                          itemCount.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      )
                                    : SizedBox.shrink();
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: SizedBox.shrink(),
                ),
              ),
            ],
          ),
        ),
        // Rest of your Scaffold body...

        body: Stack(
          children: [
            // Background image
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.foodImageSize(context),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.product.image),
                  ),
                ),
              ),
            ),
            // Icons widgets
            Positioned(
              top: Dimensions.height45(context),
              left: Dimensions.width20(context),
              right: Dimensions.width20(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // You can add your cart icon and badge here
                ],
              ),
            ),
            // Introduction of food
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.foodImageSize(context) - 40,
              child: Container(
                padding: EdgeInsets.only(
                  left: Dimensions.width20(context),
                  right: Dimensions.width20(context),
                  top: Dimensions.height20(context),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20(context)),
                    topLeft: Radius.circular(Dimensions.radius20(context)),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Dimensions.height20(context),
                    ),
                    BigText(text: "Introduction"),
                    SizedBox(
                      height: Dimensions.height20(context),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ExpandableText(text: widget.product.description),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Quantity adjustment buttons
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.width20(context) * 2.5,
                      vertical: Dimensions.height10(context),
                    ),
                    child: Consumer<QuantityProvider>(
                      builder: (context, QuantityProvider, _) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Handle the minus button tap
                              QuantityProvider.decrement();
                              if (QuantityProvider.quantity == 0) {
                                // Show Snackbar when the quantity becomes zero
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text(' "You can not reduce more!",'),
                                    duration: Duration(seconds: 2),
                                    behavior: SnackBarBehavior.floating,
                                    margin: EdgeInsets.all(10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                );
                              }
                            },
                            child: AppIcon(
                              iconSize: Dimensions.iconSize24(context),
                              iconColor: Colors.white,
                              backgroundColor: Colors.greenAccent,
                              icon: Icons.remove,
                            ),
                          ),
                          BigText(
                            text:
                                '\$ ${widget.product.price!} *${QuantityProvider.quantity} ',
                            color: Color.fromARGB(255, 0, 0, 0),
                            Size: Dimensions.font26(context),
                          ),
                          // You can add your quantity display and other widgets here
                          GestureDetector(
                            onTap: () {
                              // Handle the plus button tap
                              QuantityProvider.increment();
                              if (QuantityProvider.quantity == 20) {
                                // Show Snackbar when the quantity becomes zero
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text(' "You can not increase more!",'),
                                    duration: Duration(seconds: 2),
                                    behavior: SnackBarBehavior.floating,
                                    closeIconColor: Colors.red,
                                    margin: EdgeInsets.all(10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                            child: AppIcon(
                              iconSize: Dimensions.iconSize24(context),
                              iconColor: Colors.white,
                              backgroundColor: Colors.greenAccent,
                              icon: Icons.add,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: Dimensions.bottomheightbar(context),
                    padding: EdgeInsets.only(
                      top: Dimensions.height30(context),
                      bottom: Dimensions.height30(context),
                      left: Dimensions.width20(context),
                      right: Dimensions.width20(context),
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 246, 244, 246),
                      borderRadius: BorderRadius.only(
                        topLeft:
                            Radius.circular(Dimensions.radius20(context) * 2),
                        topRight:
                            Radius.circular(Dimensions.radius20(context) * 2),
                      ),
                    ),
                    child: Consumer<QuantityProvider>(
                      builder: (context, QuantityProvider, child) {
                        // Calculate the total cost
                        double totalCost =
                            widget.product.price! * QuantityProvider.quantity;

                        // Update the total cost text
                        totalCostText =
                            '\$${totalCost.toStringAsFixed(2)} | Add To Cart';
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  top: Dimensions.height20(context),
                                  bottom: Dimensions.height20(context),
                                  left: Dimensions.width20(context),
                                  right: Dimensions.width20(context)),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(
                                    Dimensions.radius20(context)),
                                color: isFavorite
                                    ? Colors.red
                                    : Colors.transparent,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isFavorite = !isFavorite;
                                  });
                                },
                                child: Icon(
                                  Icons.favorite,
                                  color:
                                      isFavorite ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (QuantityProvider.quantity > 0) {
                                  // Perform the action when the onTap is enabled
                                  // For example, you can add the item to the cart

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CartPage(product: widget.product),
                                    ),
                                  );
                                } else {
                                  // Show a Snackbar if the quantity is zero
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "Quantity should be greater than zero."),
                                      backgroundColor: Colors
                                          .red, // Customize the background color
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                  top: Dimensions.height20(context),
                                  bottom: Dimensions.height10(context),
                                  left: Dimensions.width20(context),
                                  right: Dimensions.width20(context),
                                ),
                                child: BigText(
                                  text: '${totalCostText}',
                                  // '\$ ${(widget.product.price! * QuantityProvider.quantity).toStringAsFixed(2)} | Add To Cart',
                                  color: Colors.white,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius20(context)),
                                  color: QuantityProvider.quantity > 0
                                      ? Colors
                                          .greenAccent // Enable the background color if quantity > 0
                                      : Colors
                                          .grey, // Disable the background color if quantity is 0
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  double Size;
  TextOverflow overFlow;
  BigText(
      {super.key,
      this.color = const Color(0xFF332d2b),
      required this.text,
      this.Size = 0,
      this.overFlow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overFlow,
      style: TextStyle(
        color: color,
        fontSize: Size == 0 ? Dimensions.font20(context) : Size,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final double iconSize;

  AppIcon({
    super.key,
    required this.icon,
    this.backgroundColor = const Color(0xFFfcf4e4),
    this.iconColor = const Color(0xFF456d54),
    this.size = 40,
    this.iconSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size / 2),
          color: backgroundColor),
      child: Icon(icon, color: iconColor, size: iconSize),
    );
  }
}

class ExpandableText extends StatefulWidget {
  final String text;

  const ExpandableText({super.key, required this.text});

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;
  late BuildContext _context;
  bool hiddenText = true;
  double get textHeight => Dimensions.screenHeight(_context) / 5.63;
// Declare a field to store the BuildContext

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _context = context;
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SmallText(
              color: Colors.black,
              Size: Dimensions.font16(context),
              text: firstHalf)
          : Column(
              children: [
                SmallText(
                  height: 1.5,
                  color: Colors.black,
                  Size: Dimensions.font16(context),
                  text: hiddenText
                      ? (firstHalf + "...")
                      : (firstHalf + secondHalf),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    children: [
                      SmallText(
                        text: hiddenText ? ('Show More') : ('Show Less'),
                        color: Colors.greenAccent,
                      ),
                      Icon(
                        hiddenText
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up,
                        color: Colors.greenAccent,
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}

// ignore: must_be_immutable
class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  double Size;
  double height;
  SmallText({
    super.key,
    this.color = const Color(0xFFccc7c5),
    required this.text,
    this.Size = 12,
    this.height = 1.2,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: Size,
        height: height,
      ),
    );
  }
}

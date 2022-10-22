import 'package:agency31_app/controller/cart.dart';
import 'package:agency31_app/controller/location.dart';
import 'package:agency31_app/model/product.dart';
import 'package:agency31_app/utils/base/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('View Cart'),
          elevation: 0.5,
          centerTitle: true,
        ),
        body: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 18, left: 18, bottom: 10),
                child: RichText(
                  text: TextSpan(
                    text: 'Items count: ',
                    style: const TextStyle(
                      fontSize: 16,
                      color: MyColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: CardController.to.itemsCount.toString(),
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18, left: 18, bottom: 10),
                child: RichText(
                  text: TextSpan(
                    text: 'Total: ',
                    style: const TextStyle(
                      fontSize: 16,
                      color: MyColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: CardController.to.cartTotal.value
                            .toStringAsFixed(2),
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18, left: 18, bottom: 10),
                child: RichText(
                  text: TextSpan(
                    text: "Your location: ",
                    style: const TextStyle(
                      fontSize: 16,
                      color: MyColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: LocationController.to.currentAddress.value ??
                            'not found',
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(18),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      secondaryBackground: Container(
                        color: Colors.red,
                        child: const Center(
                          child: Text(
                            'Delete',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      background: Container(),
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        CardController.to.removeProductAll(
                            CardController.to.getProduct.keys.toList()[index]);
                      },
                      child: CartItem(
                        product:
                            CardController.to.getProduct.keys.toList()[index],
                        controller: CardController.to,
                        index: index,
                        quantity:
                            CardController.to.getProduct.values.toList()[index],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(thickness: 2);
                  },
                  itemCount: CardController.to.getProduct.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
    required this.product,
    required this.index,
    required this.quantity,
    required this.controller,
  }) : super(key: key);

  final Product product;
  final int index;
  final int quantity;
  final CardController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.network(
          product.imageUrl,
          width: 0.2.sw,
          height: 0.2.sw,
          fit: BoxFit.cover,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 16,
                    color: MyColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  (product.price * quantity).toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    color: MyColors.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: MyColors.primary,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 25,
                child: IconButton(
                  padding: const EdgeInsets.all(1),
                  onPressed: () {
                    controller.removeProduct(product);
                  },
                  icon: const Icon(Icons.remove),
                  iconSize: 15,
                ),
              ),
              Text('$quantity'),
              SizedBox(
                width: 25,
                child: IconButton(
                  padding: const EdgeInsets.all(1),
                  onPressed: () {
                    controller.addProduct(product);
                  },
                  icon: const Icon(Icons.add),
                  iconSize: 15,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

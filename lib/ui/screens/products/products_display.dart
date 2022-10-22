import 'package:agency31_app/controller/cart.dart';
import 'package:agency31_app/model/product.dart';
import 'package:agency31_app/ui/screens/cart/cart.dart';
import 'package:agency31_app/utils/base/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductsDisplay extends StatelessWidget {
  ProductsDisplay({super.key});
  final cartController = Get.put(CardController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Products'),
          centerTitle: true,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                fixedSize: const Size(300, 66),
              ),
              onPressed: () {
                Get.to(const CardScreen());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: MyColors.tertiary,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Obx(
                      () => Center(
                        child: Text(
                          cartController.itemsCount.value.toString(),
                          style: TextStyle(fontSize: 22.sp),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Text(
                    'View Cart'.tr,
                    style: TextStyle(fontSize: 18.sp),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: ListView.builder(
            itemCount: Product.products.length,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return ProductCard(
                index: index,
              );
            },
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  ProductCard({super.key, required this.index});

  final cartController = Get.put(CardController());

  final int index;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 28,
        backgroundImage: NetworkImage(Product.products[index].imageUrl),
      ),
      title: Text(Product.products[index].name),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(Product.products[index].type)),
          Text('${Product.products[index].price.toString()} jd'),
        ],
      ),
      trailing: ElevatedButton(
        onPressed: () {
          cartController.addProduct(Product.products[index]);
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(MyColors.tertiary),
        ),
        child: Text(
          'Add',
          style: TextStyle(
            color: MyColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }
}

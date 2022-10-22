import 'package:agency31_app/controller/public_api.dart';
import 'package:agency31_app/model/public_api.dart';
import 'package:agency31_app/ui/screens/makeup/widgets/makeup_card.dart';
import 'package:agency31_app/ui/screens/makeup/widgets/makeup_card_shimmer.dart';
import 'package:agency31_app/utils/base/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class MakeupScreen extends StatelessWidget {
  const MakeupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: MyColors.primary,
          title: const Text(
            'makeup product',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: FutureBuilder<List<PublicApiModel>?>(
          future: PublicApiController.fetchSuppliersData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const MakeupCardLoading();
              case ConnectionState.done:
              default:
                if (snapshot.hasData) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 0.05.sw,
                      vertical: 0.05.sh,
                    ),
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 0.05.sw,
                        mainAxisSpacing: 0.05.sh,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return MakeupCard(
                          name: snapshot.data![index].name ?? '',
                          category: snapshot.data![index].category ?? '',
                          image: snapshot.data![index].imageLink ??
                              'https://developers.google.com/static/maps/documentation/streetview/images/error-image-generic.png',
                          price: snapshot.data![index].price ?? '',
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('ailedMessage 1'),
                  );
                } else {
                  return const Center(
                    child: Text('failedMessage 2'),
                  );
                }
            }
          },
        ),
      ),
    );
  }
}

class CategoriesLoading extends StatelessWidget {
  const CategoriesLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(width: 10),
          itemCount: 4,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Expanded(
                  child: Shimmer.fromColors(
                    baseColor: MyColors.tertiary,
                    highlightColor: MyColors.primary,
                    child: Container(
                      // height: 300,
                      width: 106,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: MyColors.secondary,
                  highlightColor: MyColors.primary,
                  child: Container(
                    margin: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    height: 15,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}

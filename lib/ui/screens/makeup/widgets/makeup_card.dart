import 'package:agency31_app/utils/base/colors.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MakeupCard extends StatelessWidget {
  const MakeupCard({
    Key? key,
    required this.name,
    required this.category,
    required this.image,
    required this.price,
  }) : super(key: key);

  final String name;
  final String category;
  final String image;
  final String price;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: CachedNetworkImage(
        imageUrl: image,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: MyColors.primary,
                  ),
                  child: FittedBox(
                    child: Text(
                      category,
                      style: TextStyle(
                        color: MyColors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: 0.02.sw, right: 0.02.sw, bottom: 0.005.sh),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  color: MyColors.tertiary,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12.sp),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: FittedBox(
                            child: Text(
                              category,
                              style: TextStyle(
                                color: MyColors.primary,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(4),
                          margin: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: MyColors.white,
                          ),
                          child: FittedBox(
                            child: Text(
                              price,
                              style: TextStyle(
                                color: MyColors.primary,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        placeholder: (context, url) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: MyColors.tertiary,
          ),
          child: const Center(
            child: CircularProgressIndicator(
              backgroundColor: MyColors.primary,
              color: MyColors.secondary,
            ),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: MyColors.secondary,
          ),
          child: const Center(
            child: Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}

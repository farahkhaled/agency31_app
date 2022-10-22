import 'package:agency31_app/utils/base/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class MakeupCardLoading extends StatelessWidget {
  const MakeupCardLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: 0.05.sw,
        vertical: 0.05.sh,
      ),
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 0.05.sw,
        mainAxisSpacing: 0.05.sh,
      ),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: MyColors.secondary,
          highlightColor: MyColors.tertiary,
          child: Container(
            margin: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            height: 15,
            width: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        );
      },
    );
  }
}

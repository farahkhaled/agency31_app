import 'dart:developer';

import 'package:agency31_app/utils/base/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonCard extends StatelessWidget {
  const ButtonCard({
    Key? key,
    required this.title,
    required this.location,
    required this.logo,
  }) : super(key: key);

  final String title;
  final String location;
  final String logo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        log("clicked!!", name: "home buttons");
      },
      child: SizedBox(
        height: 0.2.sh,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(29),
                  color: MyColors.secondary,
                ),
                height: 0.17.sh,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 0.035.sh),
                    FittedBox(
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: MyColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    FittedBox(
                      child: Text(
                        location,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: MyColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 80,
              width: 80,
              child: CircleAvatar(
                backgroundImage: AssetImage(logo),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

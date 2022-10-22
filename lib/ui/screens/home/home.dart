import 'package:agency31_app/ui/screens/home/widgets/image_slider.dart';
import 'package:agency31_app/ui/screens/home/widgets/product_card.dart';
import 'package:agency31_app/ui/screens/home/widgets/recommended_card.dart';
import 'package:agency31_app/ui/widgets/custom_drawer.dart';
import 'package:agency31_app/utils/base/colors.dart';
import 'package:agency31_app/utils/base/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: MyColors.primary,
          title: const Text(
            'Home',
            style: TextStyle(color: MyColors.white),
          ),
        ),
        drawer: const CustomDrawer(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 0.05.sh),
                height: 1.sh / 4,
                child: const ImagesSlider(),
              ),
              SizedBox(height: 0.05.sh),
              Padding(
                padding:
                    EdgeInsetsDirectional.only(bottom: 0.02.sh, start: 0.05.sw),
                child: Text(
                  "Our Products",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: MyColors.primary,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.05.sw),
                child: SizedBox(
                  height: 0.3.sh,
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 10),
                    itemCount: 8,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return const ProductCard(
                        image: MyImages.accessories,
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsetsDirectional.only(bottom: 0.02.sh, start: 0.05.sw),
                child: Text(
                  "Our special brands",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: MyColors.primary,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 0.05.sw, vertical: 0.02.sh),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 20.0,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return ButtonCard(
                      logo: index.isEven ? MyImages.bags : MyImages.shoes,
                      title: index.isEven ? 'bages' : 'shoes',
                      location: 'Amman , Alwaha Circle',
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

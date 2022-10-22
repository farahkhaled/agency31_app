import 'package:agency31_app/binding/binding.dart';
import 'package:agency31_app/controller/authentication.dart';
import 'package:agency31_app/ui/screens/chat/chat.dart';
import 'package:agency31_app/ui/screens/makeup/makeup.dart';
import 'package:agency31_app/ui/screens/products/products_display.dart';
import 'package:agency31_app/utils/base/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: MyColors.tertiary,
            ),
            child: Column(
              children: [
                Image.network(
                  AuthController.to.user.value?.photoURL ??
                      "https://www.pngkey.com/png/detail/115-1150152_default-profile-picture-avatar-png-green.png",
                ),
                const SizedBox(height: 10),
                Text(
                  AuthController.to.user.value?.displayName ?? "user name",
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.production_quantity_limits_outlined),
            title: const Text('makeup'),
            onTap: () {
              Navigator.pop(context);
              Get.to(() => const MakeupScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: const Text('products'),
            onTap: () {
              Navigator.pop(context);
              Get.to(() => ProductsDisplay(), binding: ShopBinding());
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text('chat'),
            onTap: () {
              Navigator.pop(context);
              Get.to(() => const ChatScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('sign out'),
            onTap: () {
              Navigator.pop(context);
              // Authentication.signOut(context: context);
              AuthController.to.signOut();
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hommie/controllers/home_controller.dart';
import 'package:hommie/utils/app_colors.dart';
import 'package:hommie/view/apartments_screen.dart';
import 'package:hommie/view/chat_screen.dart';
import 'package:hommie/view/custom_navbar.dart';
import 'package:hommie/view/favorites_screen.dart';
import 'package:hommie/view/filter_screen.dart';
import 'package:hommie/view/profile_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    final List<Widget> pages = [
      const ApartmentsScreen(),
      const FilterScreen(),
      const FavoritesScreen(),
      const ChatScreen(),
      const ProfileScreen(),   
    ];

    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.primary,title:Text("Hommie",style: TextStyle(color: AppColors.textPrimaryDark,fontSize: 32)) ,centerTitle: true,),
      backgroundColor: AppColors.backgroundLight,

      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(), 
        children: pages,
      ),
      
      bottomNavigationBar: Obx(() => CustomNavBar(
        currentIndex: controller.currentIndex.value,
        onTap: controller.changeTabIndex,
      )),
    );
  }
}
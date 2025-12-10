import 'package:get/get.dart';
import 'package:hommie/models/apartment_model.dart';
import 'package:hommie/services/apartments_service.dart';
import 'package:flutter/material.dart';
import 'package:hommie/view/apartment_details_screen.dart';

class HomeController extends GetxController {
  var apartments = <ApartmentModel>[].obs;
  var isLoading = false.obs;
  var currentIndex = 0.obs;
  PageController pageController = PageController();

  @override
  void onInit() {
    super.onInit();
    fetchApartments();
  }

  void changeTabIndex(int index) {
    currentIndex.value = index;
    pageController.jumpToPage(index);
  }

  void fetchApartments() async {
    try {
      isLoading.value = true;
      final fetchedApartments = await ApartmentsService.fetchApartments();
      apartments.assignAll(fetchedApartments);
    } catch (e) {
      Get.snackbar("Error", "Unable to fetch apartments. $e",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  void goToApartmentDetails(ApartmentModel apartment) {
    Get.to(()=>ApartmentDetailsScreen(), arguments: apartment);
  }
}
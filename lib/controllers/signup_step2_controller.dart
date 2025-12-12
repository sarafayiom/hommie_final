import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hommie/models/signup_step2_model.dart';
import 'package:hommie/services/signup_step2_service.dart';
import 'package:hommie/view/signup_step3.dart';

class SignupStep2Controller extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final RxBool isPasswordVisible = false.obs;
  final Rx<UserRole> selectedRole = UserRole.renter.obs;
  final RxBool isLoading = false.obs;

  late final int pendingUserId;

  final SignupStep2Service service = Get.put(SignupStep2Service());

  @override
  void onInit() {
    super.onInit();
    pendingUserId = Get.arguments['pendingUserId'];
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void selectRole(UserRole role) {
    selectedRole.value = role;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Email cannot be empty";
    if (!GetUtils.isEmail(value)) return "Please enter a valid email";
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return "Password cannot be empty";
    if (value.length < 8) return "Password must be at least 8 characters long";
    return null;
  }

  void goToNextStep() async {
    if (!formKey.currentState!.validate()) return;

    final signupData = SignupStep2Model(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      role: selectedRole.value,
    );

    isLoading.value = true;

    final response = await service.registerStep2(
      pendingUserId: pendingUserId,
      signupStep2Data: signupData,
    );

    isLoading.value = false;

    if (response.containsKey('error')) {
      Get.snackbar(
        'Error',
        response['error'],
        duration: const Duration(seconds: 3),
      );

      if (response['details'] != null) {
        print("Validation details: ${response['details']}");
      }

      return;
    }

    Get.snackbar('Success', 'Step 2 completed');

    Get.to(
      () => SignupStep3Screen(),
      arguments: {"pendingUserId": pendingUserId},
    );
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

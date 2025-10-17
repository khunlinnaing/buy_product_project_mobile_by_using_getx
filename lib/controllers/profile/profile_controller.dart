import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shan_tea_mobile_2/repository/profile/profile_repository.dart';
import '../../utils/utils.dart';

class ProfileController extends GetxController {
  final _repository = ProfileRepository();

  var profileData = {}.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var isEditing = false.obs;

  // Text controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final usernameController = TextEditingController();

  /// Fetch user profile from API
  Future<void> profile() async {
    try {
      isLoading.value = true;
      final response = await _repository.profile();
      profileData.value = response;
      firstNameController.text = response['first_name'] ?? '';
      lastNameController.text = response['last_name'] ?? '';
      emailController.text = response['email'] ?? '';
      phoneController.text = response['profile']['phone'] ?? '';
      usernameController.text = response['username'] ?? '';
    } catch (error) {
      errorMessage.value = error.toString();
    } finally {
      isLoading.value = false;
    }
  }

  /// Toggle edit mode
  void toggleEdit() => isEditing.value = !isEditing.value;

  /// Update user profile
  Future<void> updateProfile() async {
    final updatedData = {
      "username": usernameController.text.trim(),
      "first_name": firstNameController.text.trim(),
      "last_name": lastNameController.text.trim(),
      "email": emailController.text.trim(),
      "profile": {"phone": phoneController.text.trim()},
    };

    try {
      isLoading.value = true;
      await _repository.updateProfile(updatedData);

      Utils.SnackBar("Success", "Profile updated successfully!");
      await profile();
      isEditing.value = false;
    } catch (error) {
      Utils.SnackBar("Error", "Failed to update profile: $error");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onReady() {
    super.onReady();
    profile();
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    usernameController.dispose();
    super.onClose();
  }
}

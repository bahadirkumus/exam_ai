import 'package:exam_ai/controllers/authentication/login_controller.dart';
import 'package:exam_ai/utils/constants/colors.dart';
import 'package:exam_ai/utils/constants/sizes.dart';
import 'package:exam_ai/utils/constants/text_string.dart';
import 'package:exam_ai/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: AppSizes.spaceBtwSections),
        child: Column(
          children: [
            TextFormField(
              controller: controller.email,
              validator: (value) => AppValidator.validateEmail(value),
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Iconsax.personalcard,
                ),
                labelText: AppTexts.email,
              ),
            ),
            const SizedBox(
              height: AppSizes.spaceBtwInputFields,
            ),
            Obx(
              () => TextFormField(
                controller: controller.password,
                validator: (value) =>
                    AppValidator.validateEmptyText("Password", value),
                expands: false,
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.password_check),
                  labelText: AppTexts.password,
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value =
                        !controller.hidePassword.value,
                    icon: Icon(controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields),
            AppElevatedButton(controller: controller),
            const SizedBox(
              height: AppSizes.spaceBtwItems,
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(() {}),
                style: OutlinedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.borderRadius),
                  ),
                ),
                child: Text(
                    AppTexts.createAccount,
                  style: Theme.of(context).textTheme.titleSmall?.apply(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: AppSizes.spaceBtwSections,
            ),
          ],
        ),
      ),
    );
  }
}

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    super.key,
    required this.controller,
  });

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => controller.loginWithEmailAndPassword(),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: EdgeInsets.symmetric(vertical: 12.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.borderRadius),
          ),
        ),
        child: Text(
          AppTexts.signIn,
          style: Theme.of(context).textTheme.titleSmall?.apply(
                color: AppColors.textLight,
              ),
        ),
      ),
    );
  }
}

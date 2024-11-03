import 'package:exam_ai/controllers/authentication/signup_controller.dart';
import 'package:exam_ai/screens/authentication/signup/widgets/data_list.dart';
import 'package:exam_ai/screens/authentication/signup/widgets/terms_and_conditions.dart';
import 'package:exam_ai/utils/constants/sizes.dart';
import 'package:exam_ai/utils/constants/text_string.dart';
import 'package:exam_ai/utils/helpers/helpers.dart';
import 'package:exam_ai/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    final dark = AppHelpers.isDarkMode(context);
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) =>
                      AppValidator.validateEmptyText("First name", value),
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () => FocusScope.of(context).nextFocus(),
                  expands: false,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.user),
                    labelText: AppTexts.firstName,
                  ),
                ),
              ),
              const SizedBox(
                width: AppSizes.spaceBtwItems,
              ),
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) =>
                      AppValidator.validateEmptyText("Last name", value),
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () => FocusScope.of(context).nextFocus(),
                  expands: false,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.user),
                    labelText: AppTexts.lastName,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: AppSizes.spaceBtwInputFields,
          ),
          TextFormField(
            controller: controller.email,
            validator: (value) => AppValidator.validateEmail(value),
            textInputAction: TextInputAction.next,
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
            expands: false,
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.direct),
              labelText: AppTexts.email,
            ),
          ),
          const SizedBox(
            height: AppSizes.spaceBtwInputFields,
          ),
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => AppValidator.validatePhoneNumber(value),
            textInputAction: TextInputAction.next,
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
            expands: false,
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.call),
              labelText: AppTexts.phoneNo,
            ),
          ),
          const SizedBox(
            height: AppSizes.spaceBtwInputFields,
          ),
          Obx(() => DropdownButton<String>(
            value: controller.department.value.isEmpty ? null : controller.department.value,
            hint: Text('Select your department', style: Theme.of(context).textTheme.bodyLarge,),
            isExpanded: true,
            items: departments.map((String department) {
              return DropdownMenuItem<String>(
                value: department,
                child: Text(
                  department,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              controller.department.value = newValue ?? '';
            },
          )),
          const SizedBox(
            height: AppSizes.spaceBtwInputFields,
          ),
          Obx(() => DropdownButton<String>(
            value: controller.grade.value.isEmpty ? null : controller.grade.value,
            hint: Text('Select your class', style: Theme.of(context).textTheme.bodyLarge,),
            isExpanded: true,
            items: grades.map((String className) {
              return DropdownMenuItem<String>(
                value: className,
                child: Text(
                  className,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              controller.grade.value = newValue ?? '';
            },
          )),
          const SizedBox(
            height: AppSizes.spaceBtwInputFields,
          ),
          Obx(
            () => TextFormField(
              controller: controller.password,
              textInputAction: TextInputAction.done,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
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
          const SizedBox(height: AppSizes.spaceBtwSections),
          TermsAndConditionCheckbox(dark: dark),
          const SizedBox(
            height: AppSizes.spaceBtwSections,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signup(),
              child: const Text(AppTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}

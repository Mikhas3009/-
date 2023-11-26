import 'package:eco_city/data/repositories/profileApiClient.dart';
import 'package:eco_city/domain/validation/registration/registrationValidate.dart';
import 'package:eco_city/presentation/widgets/buttons/generalButton.dart';
import 'package:eco_city/presentation/widgets/inputs/passwordField.dart';
import 'package:eco_city/presentation/widgets/inputs/textField.dart';
import 'package:eco_city/presentation/widgets/navigation/navigation.dart';
import 'package:eco_city/utils/constants/colors.dart';
import 'package:eco_city/utils/constants/textStyles.dart';
import 'package:eco_city/utils/helpers/parsePhoneNumber.dart';
import 'package:eco_city/utils/helpers/showSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:eco_city/domain/models/user/userModel.dart' as userData;

class RegistrationOrganizationsScreen extends StatefulWidget {
  const RegistrationOrganizationsScreen({super.key});

  @override
  State<RegistrationOrganizationsScreen> createState() =>
      RegistrationOrganizationsScreenState();
}

class RegistrationOrganizationsScreenState
    extends State<RegistrationOrganizationsScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  bool registrationButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Регистрация организаций',
          style: TextStyles.greyCaptionTextStyle.copyWith(
              color: AppColors.darkColor, fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppColors.whiteColor,
        surfaceTintColor: AppColors.whiteColor,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Color.fromRGBO(232, 232, 232, 0.64),
            height: 2,
          ),
        ),
      ),
      drawer: NavigationWidget(
        role: userData.userRole,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 40),
                        alignment: Alignment.center,
                        child: const Text(
                          'Регистрация',
                          style: TextStyles.bigHeadlineTextStyle,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        alignment: Alignment.center,
                        child: Text(
                          'Введите данные организации/муниципальной службы',
                          style: TextStyles.greyCaptionTextStyle
                              .copyWith(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 12),
                        alignment: Alignment.center,
                        child: GeneralTextField(
                          controller: phoneController,
                          label: 'Phone',
                          keyboardType: TextInputType.phone,
                          validator: (value) =>
                              RegistrationValidate.validatePhone(
                                  value, registrationButtonPressed),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        alignment: Alignment.center,
                        child: GeneralTextField(
                          controller: nameController,
                          label: 'Название',
                          keyboardType: TextInputType.text,
                          validator: (value) =>
                              RegistrationValidate.validateName(
                                  value, registrationButtonPressed),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        alignment: Alignment.center,
                        child: GeneralTextField(
                          controller: emailController,
                          label: 'Email',
                          keyboardType: TextInputType.text,
                          validator: (value) =>
                              RegistrationValidate.validateEmail(
                                  value, registrationButtonPressed),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        alignment: Alignment.center,
                        child: GeneralTextField(
                          controller: addressController,
                          label: 'Адрес',
                          keyboardType: TextInputType.text,
                          validator: (value) =>
                              RegistrationValidate.validateAddress(
                                  value, registrationButtonPressed),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        alignment: Alignment.center,
                        child: GeneralPasswordField(
                          controller: passwordController,
                          label: 'Пароль',
                          validator: (value) =>
                              RegistrationValidate.validatePassword(
                                  value, registrationButtonPressed),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        alignment: Alignment.center,
                        child: GeneralPasswordField(
                          controller: passwordConfirmController,
                          label: 'Подтвердите пароль',
                          validator: (value) =>
                              RegistrationValidate.validatePassword(
                                  value, registrationButtonPressed),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        alignment: Alignment.center,
                        child: GeneralButton(
                          title: 'Зарегистрировать',
                          isDisabled: false,
                          onPressed: () async {
                            setState(() {
                              registrationButtonPressed = true;
                            });

                            final nameValidationResult =
                                RegistrationValidate.validateName(
                                    nameController.text, true);
                            final emailValidationResult =
                                RegistrationValidate.validateEmail(
                                    emailController.text, true);
                            final addressValidationResult =
                                RegistrationValidate.validateAddress(
                                    addressController.text, true);
                            final passwordValidationResult =
                                RegistrationValidate.validatePassword(
                                    passwordController.text, true);
                            final passwordConfirmValidationResult =
                                RegistrationValidate.validatePassword(
                                    passwordConfirmController.text, true);

                            if (nameValidationResult == null &&
                                emailValidationResult == null &&
                                addressValidationResult == null &&
                                passwordValidationResult == null &&
                                passwordConfirmValidationResult == null) {
                              if (passwordController.text ==
                                  passwordConfirmController.text) {
                                try {
                                  profileApiClient().registerOrganizations(
                                      context,
                                      phoneController.text,
                                      nameController.text,
                                      passwordController.text,
                                      emailController.text,
                                      addressController.text);
                                } catch (error) {
                                  // ignore: avoid_print
                                  print(error);
                                }
                              } else {
                                showSnackBar(context, 'Пароли не совпадают');
                              }
                            } else {
                              print('=====VALIDATION ERROR=====');
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:eco_city/data/repositories/profileApiClient.dart';
import 'package:eco_city/presentation/widgets/buttons/cancelButton.dart';
import 'package:eco_city/presentation/widgets/inputs/textField.dart';
import 'package:eco_city/presentation/widgets/navigation/navigation.dart';
import 'package:eco_city/utils/constants/colors.dart';
import 'package:eco_city/utils/constants/textStyles.dart';
import 'package:eco_city/utils/helpers/phoneFormatter.dart';
import 'package:flutter/material.dart';
import 'package:eco_city/domain/models/user/userModel.dart' as userData;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => afterBindWidget(context));
  }

  afterBindWidget(context) {
    nameController.text = userData.userName;
    emailController.text = userData.userEmail;
    addressController.text = userData.userAddress;
    passwordController.text = userData.userPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Профиль',
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
                        height: 200,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.greenColor,
                              AppColors.lightGreenColor
                            ],
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/icon_user.png',
                              height: 80,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              userData.userName,
                              style: TextStyles.generalCaptionTextStyle
                                  .copyWith(
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Свердловская область',
                              style: TextStyles.generalCaptionTextStyle
                                  .copyWith(
                                      color: AppColors.whiteColor,
                                      fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              parsePhone(userData.userPhone),
                              style: TextStyles.generalCaptionTextStyle
                                  .copyWith(
                                      color: AppColors.whiteColor,
                                      fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 40),
                        child: GeneralTextField(
                          controller: nameController,
                          label: 'Name',
                          keyboardType: TextInputType.text,
                          enabled: false,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: GeneralTextField(
                          controller: emailController,
                          label: 'Email',
                          keyboardType: TextInputType.text,
                          enabled: false,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: GeneralTextField(
                          controller: addressController,
                          label: 'Address',
                          keyboardType: TextInputType.text,
                          enabled: false,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: GeneralTextField(
                          controller: passwordController,
                          label: 'Password',
                          keyboardType: TextInputType.text,
                          enabled: false,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 40),
                        child: CancelButton(
                          title: 'Выход',
                          isDisabled: false,
                          onPressed: () {
                            profileApiClient().userLogout(context);
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

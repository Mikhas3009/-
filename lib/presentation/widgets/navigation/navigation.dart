import 'package:eco_city/domain/models/user/userModel.dart' as userData;
import 'package:eco_city/utils/constants/colors.dart';
import 'package:eco_city/utils/constants/textStyles.dart';
import 'package:eco_city/utils/helpers/phoneFormatter.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class NavigationWidget extends StatelessWidget {
  final String role;

  const NavigationWidget({super.key, required this.role});

  String getRole() {
    if (role == '1') {
      return 'Администратор';
    } else if (role == '2') {
      return 'Организация/Муниципальная служба';
    } else {
      return 'Городской житель';
    }
  }

  Widget getMenuList() {
    if (role == '1') {
      return Column(
        children: [
          ListTile(
            title: const Text(
              "Профиль",
              style: TextStyles.generalCaptionTextStyle,
            ),
            onTap: () {
              Get.offAndToNamed('/profile');
            },
          ),
          ListTile(
            title: const Text(
              "Модерация новостей",
              style: TextStyles.generalCaptionTextStyle,
            ),
            onTap: () {
              Get.offAndToNamed('/moderationNews');
            },
          ),
          ListTile(
            title: const Text(
              "Модерация обращений",
              style: TextStyles.generalCaptionTextStyle,
            ),
            onTap: () {},
          ),
          ListTile(
            title: const Text(
              "Регистрация организаций",
              style: TextStyles.generalCaptionTextStyle,
            ),
            onTap: () {
              Get.toNamed('/registrationOrganizations');
            },
          ),
        ],
      );
    } else if (role == '2') {
      return Column(
        children: [],
      );
    } else {
      return Column(
        children: [],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 200,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.greenColor, AppColors.lightGreenColor],
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
                  style: TextStyles.generalCaptionTextStyle.copyWith(
                      color: AppColors.whiteColor, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  getRole(),
                  style: TextStyles.generalCaptionTextStyle
                      .copyWith(color: AppColors.whiteColor, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Expanded(child: getMenuList())
        ],
      ),
    );
  }
}

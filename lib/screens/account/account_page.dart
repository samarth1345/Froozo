import 'package:flutter/material.dart';
import 'package:froozo/utils/colors.dart';
import 'package:froozo/utils/dimensions.dart';
import 'package:froozo/widgets/account_widget.dart';
import 'package:froozo/widgets/app_icon.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "Profile",
          style: TextStyle(color: Colors.white, fontSize: Dimensions.font26),
        )),
        backgroundColor: AppColors.mainColor,
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: Dimensions.heigt20),
        child: Column(
          children: [
            Center(
              child: AppIcon(
                icon: Icons.person,
                size: Dimensions.icon24 * 10,
                iconSize: Dimensions.icon24 * 9,
                backgroundColor: AppColors.mainColor,
                iconColor: Colors.white,
              ),
            ),
            SizedBox(
              height: Dimensions.heigt20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(children: [
                  AccountWidget(
                      icon: Icons.person,
                      text: "Samarth",
                      iconBackgroundColor: AppColors.mainColor),
                  SizedBox(
                    height: Dimensions.heigt10,
                  ),
                  AccountWidget(
                      icon: Icons.phone,
                      text: "7508524105",
                      iconBackgroundColor: AppColors.yellowColor),
                  SizedBox(
                    height: Dimensions.heigt10,
                  ),
                  AccountWidget(
                      icon: Icons.email,
                      text: "bsamarth56@gmail.com",
                      iconBackgroundColor: AppColors.yellowColor),
                  SizedBox(
                    height: Dimensions.heigt10,
                  ),
                  AccountWidget(
                      icon: Icons.location_on,
                      text: "Add your address",
                      iconBackgroundColor: AppColors.yellowColor),
                  SizedBox(
                    height: Dimensions.heigt10,
                  ),
                  AccountWidget(
                      icon: Icons.message_outlined,
                      text: "Samarth",
                      iconBackgroundColor: Colors.red),
                  SizedBox(
                    height: Dimensions.heigt10,
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}

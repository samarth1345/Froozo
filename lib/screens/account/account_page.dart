import 'package:flutter/material.dart';
import 'package:froozo/controllers/location_controller.dart';
import 'package:froozo/screens/address/add_address_page.dart';
import 'package:froozo/utils/colors.dart';
import 'package:froozo/utils/dimensions.dart';
import 'package:froozo/widgets/account_widget.dart';
import 'package:froozo/widgets/app_icon.dart';
import 'package:froozo/widgets/big_text.dart';
import 'package:get/get.dart';

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
      body: GetBuilder<LocationController>(builder: (locationController) {
        return Container(
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
                    GestureDetector(
                      onTap: () {
                        Get.to(AddAddressPage());
                      },
                      child: AccountWidget(
                          icon: Icons.person,
                          text: locationController.hasAddress()
                              ? locationController.getCurrName()
                              : "Add your Name",
                          iconBackgroundColor: AppColors.mainColor),
                    ),
                    SizedBox(
                      height: Dimensions.heigt10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(AddAddressPage());
                      },
                      child: AccountWidget(
                          icon: Icons.phone,
                          text: locationController.hasAddress()
                              ? locationController.getCurrNumber()
                              : "Add your Number",
                          iconBackgroundColor: AppColors.yellowColor),
                    ),
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
                    Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.only(left: Dimensions.width10),
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 5),
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 1),
                      ]),
                      child: Row(
                        children: [
                          AppIcon(
                            icon: Icons.location_on,
                            iconSize: Dimensions.icon18 * 2.5,
                            iconColor: Colors.white,
                            backgroundColor: AppColors.yellowColor,
                            size: Dimensions.icon24 * 2,
                          ),
                          SizedBox(
                            width: Dimensions.width20,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: BigText(
                                text: locationController.hasAddress()
                                    ? locationController.getCurrAddress()
                                    : "Add your address"),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.heigt10,
                    ),
                    AccountWidget(
                        icon: Icons.message_outlined,
                        text: "Messages",
                        iconBackgroundColor: Colors.red),
                    SizedBox(
                      height: Dimensions.heigt10,
                    ),
                  ]),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}

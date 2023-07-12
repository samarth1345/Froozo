import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:froozo/controllers/popular_product_controller.dart';
import 'package:froozo/controllers/recommended_product_controller.dart';
import 'package:froozo/models/popular_product.dart';
import 'package:froozo/screens/food/popular_food_detail.dart';
import 'package:froozo/screens/food/recommended_food_detail.dart';
import 'package:froozo/utils/app_constants.dart';
import 'package:froozo/utils/colors.dart';
import 'package:froozo/utils/dimensions.dart';
import 'package:froozo/widgets/big_text.dart';
import 'package:froozo/widgets/food_app_column.dart';
import 'package:froozo/widgets/icon_and_text_widget.dart';
import 'package:froozo/widgets/small_text.dart';
import 'package:get/get.dart';

//Every builder in flutter takes functions as input
class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  //we need page value to get the effect of current widget
  //coming out of screen -> Scaling
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isLoaded
              ? Container(
                  height: Dimensions.pageView,
                  // color: Colors.red,
                  child: PageView.builder(
                      controller: pageController,
                      itemCount: popularProducts.popularProductList.length,
                      itemBuilder: (context, position) {
                        return _buildPageItem(position,
                            popularProducts.popularProductList[position]);
                      }))
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }),
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return new DotsIndicator(
              dotsCount: popularProducts.popularProductList.length <= 0
                  ? 1
                  : popularProducts.popularProductList.length,
              position: _currPageValue,
              decorator: DotsDecorator(
                  size: const Size.square(9.0),
                  activeColor: AppColors.mainColor,
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(Dimensions.radius5))));
        }),
        SizedBox(
          height: Dimensions.heigt30,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimensions.heigt30),
          child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            BigText(text: "Recommended"),
            SizedBox(width: Dimensions.heigt10),
            Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(text: ".", color: Colors.black26)),
            SizedBox(width: Dimensions.heigt10),
            Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(text: "Food pairing"))
          ]),
        ),
        //list of Popular food items
        GetBuilder<RecommendedProductController>(
            builder: (recommendedProducts) {
          return recommendedProducts.isLoaded
              ? ListView.builder(
                  itemCount: recommendedProducts.recommendedProductList.isEmpty
                      ? 1
                      : recommendedProducts.recommendedProductList.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      //on tap move to Recommended Food page
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RecommendedFoodDetail()));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                            bottom: Dimensions.heigt10),
                        child: Row(
                          children: [
                            Container(
                              height: Dimensions.listViewImg,
                              width: Dimensions.listViewImg,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                                color: Colors.white30,
                                image: DecorationImage(
                                    image: NetworkImage(AppConstants.BASE_URL+"/uploads/"+recommendedProducts.recommendedProductList[index].img!),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: Dimensions.listViewTextContSize,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight:
                                          Radius.circular(Dimensions.radius20),
                                      bottomRight:
                                          Radius.circular(Dimensions.radius20),
                                    ),
                                    color: Colors.white30),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: Dimensions.width10,
                                      right: Dimensions.width10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      BigText(
                                          text:
                                              recommendedProducts
                                              .recommendedProductList[index].name!),
                                      SizedBox(
                                        height: Dimensions.heigt10,
                                      ),
                                      SmallText(text: recommendedProducts
                                              .recommendedProductList[index].description),
                                      SizedBox(
                                        height: Dimensions.heigt10,
                                      ),
                                      Row(
                                        // mainAxisAlignment:
                                        //     MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconAndTextWidget(
                                              icon: Icons.circle,
                                              text: "Normal",
                                              IconSize: Dimensions.icon18,
                                              TextSize: Dimensions.font12,
                                              iconColor: AppColors.iconColor1),
                                          IconAndTextWidget(
                                              icon: Icons.location_pin,
                                              text: "1.7km",
                                              IconSize: Dimensions.icon18,
                                              TextSize: Dimensions.font12,
                                              iconColor: AppColors.mainColor),
                                          IconAndTextWidget(
                                              icon: Icons.timer,
                                              text: "32min",
                                              IconSize: Dimensions.icon18,
                                              TextSize: Dimensions.font12,
                                              iconColor: AppColors.iconColor2),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  })
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        })
      ],
    );
  }

  Widget _buildPageItem(int index, PopularProducts popularProductItem) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }
    return Transform(
      transform: matrix,
      child: Stack(children: [
        Container(
          height: Dimensions.pageViewContainer,
          margin: EdgeInsets.only(
              left: Dimensions.heigt10, right: Dimensions.heigt10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(AppConstants.BASE_URL +
                      "/uploads/" +
                      popularProductItem.img!))),
        ),
        InkWell(
          //moving to new page on tap
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => PopularFoodPage()));
          },
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.heigt30,
                  right: Dimensions.heigt30,
                  bottom: Dimensions.heigt30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: Dimensions.radius5,
                        offset: Offset(0, Dimensions.radius5)),
                    BoxShadow(
                        color: Colors.white,
                        offset: Offset(-1 * Dimensions.radius5, 0)),
                    BoxShadow(
                        color: Colors.white,
                        offset: Offset(Dimensions.radius5, 0)),
                  ]),
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.heigt10,
                    left: Dimensions.heigt15,
                    right: Dimensions.heigt15),
                child: FoodAppColumn(Maintext: popularProductItem.name!),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

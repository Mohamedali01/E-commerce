import 'package:e_commerce/constants.dart';
import 'package:e_commerce/core/viewmodel/cart_view_model.dart';
import 'package:e_commerce/core/viewmodel/favourites_view_model.dart';
import 'package:e_commerce/view/checkout/check_out_view.dart';
import 'package:e_commerce/view/widgets/custom_button.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'circular_progress_indicator_view.dart';

class FavouriteView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FavouritesViewModel>(
      builder: (_, controller, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Image.asset(
                  'assets/images/Icon_Arrow-Left.png',
                  width: 30,
                  height: 30,
                )),
            title: Text(
              'Favourites',
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
          ),
          body: controller.isLoading
              ? CircularProgressIndicatorView()
              : controller.favourites.length == 0
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/empty_cart.svg',
                          width: 200,
                          height: 150,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomText(
                          text: 'Empty Favourite List',
                          fontSize: 32,
                          alignment: Alignment.topCenter,
                        )
                      ],
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            child: ListView.separated(
                              itemCount: controller.favourites.length,
                              itemBuilder: (_, index) {
                                return Dismissible(
                                  direction: DismissDirection.endToStart,
                                  background: Container(
                                    padding: EdgeInsets.only(left: 25),
                                    color: Color(
                                      0xffFFC107,
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Image.asset(
                                        'assets/images/Icon_Wishlist.png',
                                        width: 25,
                                        height: 27,
                                      ),
                                    ),
                                  ),
                                  secondaryBackground: Container(
                                    padding: EdgeInsets.only(right: 25),
                                    color: Color(
                                      0xffFF3D00,
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Image.asset(
                                        'assets/images/Icon_Delete.png',
                                        width: 25,
                                        height: 27,
                                      ),
                                    ),
                                  ),
                                  onDismissed: (dismissDirection) {
                                    controller.removeFavourite(
                                        controller.favourites[index].cartId);
                                  },
                                  key: ValueKey(DateTime.now().toString()),
                                  child: InkWell(
                                    onTap: () {
                                      controller.pressItem(
                                          controller.favourites[index].cartId);
                                    },
                                    child: Container(
                                      height: 120,
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 120,
                                            height: 120,
                                            child: Image.network(
                                              controller
                                                  .favourites[index].image,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(left: 20),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width:MediaQuery.of(context).size.width *0.5,
                                                  child: Text(
                                                    controller
                                                        .favourites[index].name,
                                                    style:
                                                        TextStyle(fontSize: 22),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                CustomText(
                                                  text:
                                                      '\$ ${controller.favourites[index].price}',
                                                  fontSize: 24,
                                                  color: kPrimaryColor,
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  height: 20,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
        );
      },
    );
  }
}

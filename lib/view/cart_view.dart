import 'package:e_commerce/constants.dart';
import 'package:e_commerce/core/viewmodel/cart_view_model.dart';
import 'package:e_commerce/view/checkout/check_out_view.dart';
import 'package:e_commerce/view/widgets/custom_button.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'circular_progress_indicator_view.dart';

class CartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartViewModel>(
      builder: (_, controller, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Image.asset('assets/images/Icon_Arrow-Left.png',width: 20,height: 20,),
            title: Text('Cart',style: TextStyle(color: Colors.black),),
          ),
          body: controller.isLoading
              ? CircularProgressIndicatorView()
              : controller.cartProducts.length == 0
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
                          text: 'Empty Cart',
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
                              itemCount: controller.cartProducts.length,
                              itemBuilder: (_, index) {
                                return Dismissible(
                                  direction: DismissDirection.horizontal,
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
                                    if (dismissDirection ==
                                        DismissDirection.endToStart)
                                      controller.removeCartItem(controller
                                          .cartProducts[index].cartId);
                                    if(dismissDirection == DismissDirection.startToEnd)
                                      controller.addFavourite(controller.cartProducts[index]);
                                  },
                                  key: ValueKey(DateTime.now().toString()),
                                  child: Container(
                                    height: 120,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 120,
                                          height: 120,
                                          child: Image.network(
                                            controller
                                                .cartProducts[index].image,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                text: controller
                                                    .cartProducts[index].name,
                                                fontSize: 16,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              CustomText(
                                                text:
                                                    '\$ ${controller.cartProducts[index].price}',
                                                fontSize: 16,
                                                color: kPrimaryColor,
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Container(
                                                height: 50,
                                                width: 150,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.shade300,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    IconButton(
                                                      icon: Icon(Icons.add),
                                                      onPressed: () async {
                                                        controller
                                                            .incrementQuantity(
                                                                index);
                                                      },
                                                      color: Colors.black,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    CustomText(
                                                      text: controller
                                                          .cartProducts[index]
                                                          .quantity
                                                          .toString(),
                                                      alignment:
                                                          Alignment.center,
                                                      fontSize: 16,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 10),
                                                      child: IconButton(
                                                        icon: Icon(
                                                            Icons.minimize),
                                                        onPressed: () async {
                                                          controller
                                                              .decrementQuantity(
                                                                  index);
                                                        },
                                                        color: Colors.black,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
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
                        Container(
                          height: 100,
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  CustomText(
                                    text: 'TOTAL',
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  CustomText(
                                      text: '\$${controller.totalPrice}',
                                      color: kPrimaryColor,
                                      fontSize: 22)
                                ],
                              ),
                              Container(
                                width: 146,
                                height: 50,
                                child: CustomButton(
                                  text: 'CHECKOUT',
                                  onPressed: () {
                                    Get.to(CheckOutView());
                                  },
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
        );
      },
    );
  }
}

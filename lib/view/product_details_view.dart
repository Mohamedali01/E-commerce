import 'package:e_commerce/constants.dart';
import 'package:e_commerce/core/viewmodel/cart_view_model.dart';
import 'package:e_commerce/core/viewmodel/favourites_view_model.dart';
import 'package:e_commerce/model/cart_model.dart';
import 'package:e_commerce/model/product_model.dart';
import 'package:e_commerce/view/widgets/custom_button.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ProductDetailsView extends StatelessWidget {
  final ProductModel model;

  ProductDetailsView({this.model});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<FavouritesViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.network(
                    model.image,
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                  ),
                  Positioned(
                    child: InkWell(
                      onTap: () {
                        controller.handleFavouriteButton(model);
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Icon(
                          controller.isFavourite
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                    right: 20,
                    top: 40,
                  ),
                  Positioned(
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Image.asset(
                        'assets/images/Icon_Arrow-Left.png',
                        height: 50,
                        width: 50,
                      ),
                    ),
                    left: 10,
                    top: 40,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      CustomText(
                        text: 'Nike Dri-FIT Long Sleeve',
                        fontSize: 30,
                        bold: true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: 'Size',
                                ),
                                CustomText(
                                  text: model.sized,
                                  bold: true,
                                ),
                              ],
                            ),
                            width: MediaQuery.of(context).size.width * 0.4,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: 'Colour',
                                ),
                                Container(
                                  width: 22,
                                  height: 22,
                                  decoration: BoxDecoration(
                                    color: model.color,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                )
                              ],
                            ),
                            width: MediaQuery.of(context).size.width * 0.4,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      CustomText(
                        text: 'Details',
                        fontSize: 18,
                        bold: true,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            model.description,
                            style: TextStyle(height: 2.5, fontSize: 16),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).canvasColor,
                            spreadRadius: 30,
                            blurRadius: 10,
                            offset: Offset(0, 2), // changes position of shadow
                          )
                        ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                CustomText(
                                  text: "PRICE",
                                  fontSize: 12,
                                ),
                                CustomText(
                                  text: '\$' + model.price,
                                  color: kPrimaryColor,
                                  fontSize: 18,
                                  bold: true,
                                ),
                              ],
                            ),
                            Container(
                              width: 170,
                              height: 55,
                              child: Consumer<CartViewModel>(
                                  builder: (_, controller, child) {
                                return CustomButton(
                                  text: "ADD",
                                  fontSize: 20,
                                  onPressed: () async {
                                    print('Mohamed Ali: ADD id = ' +
                                        model.productId);
                                    await controller.insertCartItem(
                                      CartModel(
                                          cartId: model.productId,
                                          name: model.name,
                                          image: model.image,
                                          price: model.price,
                                          quantity: 1),
                                    );
                                  },
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

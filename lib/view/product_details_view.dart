import 'package:e_commerce/constants.dart';
import 'package:e_commerce/core/viewmodel/cart_view_model.dart';
import 'package:e_commerce/model/cart_model.dart';
import 'package:e_commerce/model/product_model.dart';
import 'package:e_commerce/view/widgets/custom_button.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsView extends StatelessWidget {
  final ProductModel model;

  ProductDetailsView({this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.network(
            model.image,
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.25,
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
                    fontSize: 26,
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
                    child: Text(
                      model.description,
                      style: TextStyle(height: 2.5),
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
                                print('Mohamed Ali: ADD id = '+model.productId);
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
    );
  }
}

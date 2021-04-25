import 'package:e_commerce/constants.dart';
import 'package:e_commerce/core/viewmodel/add_address_view_model.dart';
import 'package:e_commerce/core/viewmodel/cart_view_model.dart';
import 'package:e_commerce/core/viewmodel/check_out_view_model.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SummaryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<CartViewModel>(context);
    final addAddressController = Provider.of<AddAddressViewModel>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.68,
      child: Column(
        children: [
          Container(
            height: 220,
            width: MediaQuery.of(context).size.width,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) => Column(
                      children: [
                        Image.network(
                          cartController.cartProducts[index].image,
                          fit: BoxFit.fill,
                          height: 150,
                          width: 150,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 170,
                          padding: EdgeInsets.only(left: 15),
                          child: RichText(
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            text: TextSpan(
                              text: cartController.cartProducts[index].name,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: 170,
                          padding: EdgeInsets.only(left: 15),
                          child: RichText(
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            text: TextSpan(
                              text:
                                  '\$${cartController.cartProducts[index].price}',
                              style:
                                  TextStyle(fontSize: 18, color: kPrimaryColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                separatorBuilder: (_, index) => SizedBox(
                      width: 5,
                    ),
                itemCount: cartController.cartProducts.length),
          ),
          SizedBox(
            height: 50,
          ),
          CustomText(
            text: 'Shipping Address',
            fontSize: 24,
            bold: true,
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              '${addAddressController.street1 == null ? '' : addAddressController.street1 + ','} ${addAddressController.street2 == null ? '' : addAddressController.street2 + ','} ${addAddressController.state == null ? '' : addAddressController.state+','} ${addAddressController.city == null ? '' : addAddressController.city+','} ${addAddressController.country == null ? '' : addAddressController.country+','}',
              style: TextStyle(height: 2, fontSize: 20),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}

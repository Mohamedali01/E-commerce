import 'package:e_commerce/core/viewmodel/add_address_view_model.dart';
import 'package:e_commerce/core/viewmodel/check_out_view_model.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:e_commerce/view/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AddAddressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final addAddressController = Provider.of<AddAddressViewModel>(context);
    final checkOutViewModel = Provider.of<CheckOutViewModel>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.68,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: checkOutViewModel.globalKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                CustomText(
                  text: 'Billing address is the same as delivery address',
                  fontSize: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomText(
                  text: 'Street 1',
                  color: Colors.grey.shade500,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  initialValue: addAddressController.street1,
                  hintText: '21, Alex Davidson Avenue',
                  onSaved: (String value) {
                    addAddressController.street1 = value;
                  },
                  validator: (String value) {
                    if (value.isEmpty) return 'Street 1 is required!';
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CustomText(
                  text: 'Street 2',
                  color: Colors.grey.shade500,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  initialValue: addAddressController.street2,
                  hintText: 'Opposite Omegatron, Vicent Quarters',
                  onSaved: (String value) {
                    addAddressController.street2 = value;
                  },
                  validator: (String value) {
                    if (value.isEmpty) return 'Street 2 is required!';
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CustomText(
                  text: 'City',
                  color: Colors.grey.shade500,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  initialValue: addAddressController.city,
                  hintText: 'Victoria Island',
                  onSaved: (String value) {
                    addAddressController.city = value;
                  },
                  validator: (String value) {
                    if (value.isEmpty) return 'City is required!';
                    return null;
                  },
                ),
                Container(
                  width: Get.width,
                  height: 120,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                child: CustomText(
                                  text: 'State',
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomTextFormField(
                                initialValue: addAddressController.state,
                                hintText: 'Victoria Island',
                                onSaved: (String value) {
                                  addAddressController.state = value;
                                },
                                validator: (String value) {
                                  if (value.isEmpty)
                                    return 'State is required!';
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                child: CustomText(
                                  text: 'Country',
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomTextFormField(
                                initialValue: addAddressController.country,
                                hintText: 'Nigeria',
                                onSaved: (String value) {
                                  addAddressController.country = value;
                                },
                                validator: (String value) {
                                  if (value.isEmpty)
                                    return 'Country is required!';
                                  return null;
                                },
                              ),
                            ],
                          ),
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

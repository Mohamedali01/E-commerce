import 'package:e_commerce/constants.dart';
import 'package:e_commerce/core/viewmodel/check_out_view_model.dart';
import 'package:e_commerce/view/checkout/add_address_view.dart';
import 'package:e_commerce/view/checkout/delivery_time_view.dart';
import 'package:e_commerce/view/checkout/summary_view.dart';
import 'package:e_commerce/view/widgets/custom_button.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckOutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CheckOutViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Expanded(
                child: Theme(
                  data: ThemeData(
                      primaryColor: kPrimaryColor, accentColor: kPrimaryColor),
                  child: Stepper(
                    controlsBuilder: (BuildContext context,
                            {VoidCallback onStepContinue,
                            VoidCallback onStepCancel}) =>
                        Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: controller.currentStep == 0
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if (controller.currentStep != 0)
                                Expanded(
                                  child: InkWell(
                                    onTap: controller.cancel,
                                    child: Container(
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: kPrimaryColor),
                                        ),
                                        margin: EdgeInsets.only(right: 20),
                                        height: 60,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: CustomText(
                                            text: 'BACK',
                                            alignment: Alignment.center,
                                            fontSize: 18,
                                          ),
                                        )),
                                  ),
                                ),
                              controller.currentStep == 0
                                  ? Container(
                                      width: 150,
                                      height: 60,
                                      child: CustomButton(
                                        text: 'NEXT',
                                        onPressed: () {
                                          controller.continueSteps();
                                        },
                                      ),
                                    )
                                  : Expanded(
                                      child: Container(
                                        width: 150,
                                        height: 60,
                                        child: CustomButton(
                                          text: controller.currentStep != 2
                                              ? 'NEXT'
                                              : 'Deliver',
                                          onPressed: () {
                                            controller.continueSteps();
                                          },
                                        ),
                                      ),
                                    )
                            ],
                          ),
                        ],
                      ),
                    ),
                    steps: [
                      Step(
                        title: Text('Delivery'),
                        content: DeliveryTimeView(),
                        isActive: controller.list[0],
                      ),
                      Step(
                          title: Text('Address'),
                          content: AddAddressView(),
                          state: StepState.indexed,
                          isActive: controller.list[1]),
                      Step(
                          title: Text('Summery'),
                          content: SummaryView(),
                          isActive: controller.list[2])
                    ],
                    onStepCancel: controller.cancel,
                    onStepContinue: controller.continueSteps,
                    onStepTapped: (index) {
                      print('Mohamed Ali : $index');
                      controller.goTo(index);
                    },
                    currentStep: controller.currentStep,
                    type: StepperType.horizontal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

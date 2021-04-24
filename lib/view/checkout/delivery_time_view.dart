import 'package:e_commerce/constants.dart';
import 'package:e_commerce/core/viewmodel/delivery_time_view_model.dart';
import 'package:e_commerce/enums.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeliveryTimeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<DeliveryTimeViewModel>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.68,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
          ),
          _buildRadioListTileWidget(
            value: Delivery.Standard,
            groupValue: controller.delivery,
            text: 'Standard Delivery',
            subText: '\nOrder will be delivered between 3 - 5 business days ',
            onChanged: (value) {
              controller.changeDelivery(value);
            },
          ),
          SizedBox(height: 50),
          _buildRadioListTileWidget(
            value: Delivery.NextDay,
            groupValue: controller.delivery,
            text: 'Next Day Delivery',
            subText:
                '\nPlace your order before 6pm and your items will be delivered the next day ',
            onChanged: (value) {
              controller.changeDelivery(value);
            },
          ),
          SizedBox(height: 50),
          _buildRadioListTileWidget(
            value: Delivery.Nominated,
            groupValue: controller.delivery,
            text: 'Nominated Delivery',
            subText:
                '\Pick a particular date from the calendar and order will be delivered on selected date ',
            onChanged: (value) {
              controller.changeDelivery(value);
            },

          ),
          Expanded(child: Container())
        ],
      ),
    );
  }

  Widget _buildRadioListTileWidget(
      {Delivery value,
      Delivery groupValue,
      Function onChanged,
      String text,
      String subText}) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          RadioListTile(
            value: value,
            groupValue: groupValue,
            activeColor: kPrimaryColor,
            subtitle: Directionality(
              textDirection: TextDirection.ltr,
              child: CustomText(
                text: '\nOrder will be delivered between 3 - 5 business days ',
              ),
            ),
            title: Directionality(
              textDirection: TextDirection.ltr,
              child: CustomText(
                text: text,
                bold: true,
                fontSize: 18,
              ),
            ),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

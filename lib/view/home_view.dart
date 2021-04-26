import 'package:e_commerce/constants.dart';
import 'package:e_commerce/core/viewmodel/home_view_model.dart';
import 'package:e_commerce/view/circular_progress_indicator_view.dart';
import 'package:e_commerce/view/favourite_view.dart';
import 'package:e_commerce/view/product_details_view.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeViewModel>(context);
    return Scaffold(
      body: controller.isLoading.value
          ? CircularProgressIndicatorView()
          : Padding(
              padding: EdgeInsets.only(left: 15, right: 20, top: 50),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _searchWidget(),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "Categories",
                          fontSize: 20,
                          bold: true,
                        ),
                        IconButton(
                            icon: Icon(Icons.favorite,color: Colors.red,),
                            onPressed: () {
                              Get.to(FavouriteView());
                            })
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _categoriesListView(context),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Best Selling',
                          fontSize: 18,
                          bold: true,
                        ),
                        CustomText(
                          text: 'See all',
                          fontSize: 16,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    _bestSellingListView(context)
                  ],
                ),
              ),
            ),
    );
  }
}

Widget _bestSellingListView(BuildContext context) {
  final controller = Provider.of<HomeViewModel>(context);

  return Container(
    height: 300,
    child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          return GestureDetector(
            onTap: () {
              print('Mohamed ali: id = ' +
                  controller.productModels[index].productId);
              Get.to(
                ProductDetailsView(model: controller.productModels[index]),
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.45,
              child: Column(
                children: [
                  ClipRRect(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 220,
                      child: Image.network(
                        controller.productModels[index].image,
                        fit: BoxFit.fill,
                      ),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    text: controller.productModels[index].name,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CustomText(
                    text: controller.productModels[index].description,
                    fontSize: 12,
                    color: Colors.grey,
                    textOverFlow: true,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CustomText(
                    text:
                        '\$${controller.productModels[index].price.toString()}',
                    color: kPrimaryColor,
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (ctx, index) => SizedBox(
              width: 30,
            ),
        itemCount: controller.productModels.length),
  );
}

Widget _searchWidget() {
  return Container(
    padding: EdgeInsets.all(2),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40), color: Colors.grey.shade200),
    child: TextFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
        prefixIcon: Image.asset('assets/images/Icon_Search.png'),
      ),
    ),
  );
}

Widget _categoriesListView(BuildContext context) {
  return Consumer<HomeViewModel>(
    builder: (context, controller, _) {
      return Container(
        height: 100,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, index) {
              return Column(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          )
                        ],
                        borderRadius: BorderRadius.circular(60),
                        color: Colors.white),
                    child:
                        Image.network(controller.categoryModels[index].image),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FittedBox(
                    child: CustomText(
                      text: controller.categoryModels[index].name,
                      fontSize: 14,
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (ctx, index) {
              return SizedBox(
                width: 40,
              );
            },
            itemCount: controller.categoryModels.length),
      );
    },
  );
}

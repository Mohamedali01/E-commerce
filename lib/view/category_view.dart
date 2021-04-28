import 'package:e_commerce/constants.dart';
import 'package:e_commerce/core/viewmodel/category_view_model.dart';
import 'package:e_commerce/view/product_details_view.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CategoryView extends StatelessWidget {
  final String name;

  CategoryView({this.name});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CategoryViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(name, style: TextStyle(color: Colors.black, fontSize: 24)),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Image.asset('assets/images/Icon_Arrow-Left.png'),
        ),
      ),
      body: controller.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Container(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: 0.5),
                    itemBuilder: (_, index) => GestureDetector(
                      onTap: () {
                        Get.to(ProductDetailsView(
                          model: controller.listHandler(name)[index],
                        ));
                      },
                      child: Column(
                        children: [
                          Image.network(
                            controller.listHandler(name)[index].image,
                            fit: BoxFit.fill,
                            height: 250,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          CustomText(
                            text: controller.listHandler(name)[index].name,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          Container(
                            width: 200,
                            child: CustomText(
                              textOverFlow: true,
                              text: controller
                                  .listHandler(name)[index]
                                  .description,
                              fontSize: 16,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          CustomText(
                            text:
                                '\$${controller.listHandler(name)[index].price}',
                            color: kPrimaryColor,
                            fontSize: 22,
                          )
                        ],
                      ),
                    ),
                    itemCount: controller.listHandler(name).length,
                  ),
                ),
              ),
            ),
    );
  }
}
//controller.itemCount(name)

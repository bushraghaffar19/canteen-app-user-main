import 'package:canteen_ordering_user/Constant/constant.dart';
import 'package:canteen_ordering_user/view/dashboard/cart/cart_screen.dart';
import 'package:canteen_ordering_user/view/dashboard/home/search_product_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../model/canteen_model.dart';
import '../../../model/category_model.dart';
import '../../../model/product_model.dart';
import 'favourite_product.dart';
import 'widgets/canteen_products_widget.dart';

class CanteenProducts extends StatefulWidget {
  final CanteenModel canteenModel;
  const CanteenProducts({Key? key, required this.canteenModel}) : super(key: key);

  @override
  State<CanteenProducts> createState() => _CanteenProductsState();
}

class _CanteenProductsState extends State<CanteenProducts> {
  int initIndex = 0;
  List<ProductModel> canteenProduct = [];
  List<CategoryModel> canteenCategory = [];
  @override
  void initState() {
    super.initState();
    orderController.canteenId = widget.canteenModel.uid ??'';
  canteenProduct =  productController.getCanteenProduct(widget.canteenModel.uid ??'');
   canteenCategory = categoryController.getCanteenCategory(widget.canteenModel.uid ??'');
   if(canteenCategory.isNotEmpty){
     productController.getCategoryWiseProduct(canteenCategory[initIndex].categoryId ??'', canteenProduct);
   }
  }
  @override
  Widget build(BuildContext context) {
    if (canteenCategory.isEmpty) {

      return const Scaffold(
        body: Center(child: Text("no data found for this specific canteen"))
      );
    }
    return DefaultTabController(
      length: canteenCategory.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.canteenModel.name ??'',style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black
          ),),
          actions: [
            IconButton(
                onPressed: (){
                  Get.to( FavouriteProduct(
                    canteenProduct: canteenProduct,
                    categoryId: canteenCategory[initIndex].categoryId ??'',
                    canteenId: widget.canteenModel.uid ??'',),
                      duration: const Duration(seconds: 2), //duration of transitions, default 1 sec
                      transition: Transition.cupertinoDialog
                  );
                },
                icon:const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(CupertinoIcons.heart_fill),

                )
            ),
            IconButton(
                onPressed: (){
                  Get.to(() =>  SearchProductScreen(products: canteenProduct,),
                      duration: const Duration(seconds: 2), //duration of transitions, default 1 sec
                      transition: Transition.cupertinoDialog
                  );
                }, icon: const Icon(CupertinoIcons.search))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Get.to(const CartScreen(),
                duration: const Duration(seconds: 2), //duration of transitions, default 1 sec
                transition: Transition.cupertinoDialog
            );
          },
          child: const Icon(CupertinoIcons.cart_fill),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            const SizedBox(height: 10,),
            TabBar(
                isScrollable:true,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: kButtonColor,
                indicatorWeight: 3,
                onTap: (index){
                  productController.getCategoryWiseProduct(canteenCategory[index].categoryId ??'', canteenProduct);
                },
                labelColor: kButtonColor,
                labelStyle: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: kButtonColor),
                unselectedLabelStyle: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).iconTheme.color),
                unselectedLabelColor: kLightGreyColor,
                tabs:  [
                  for(int i=0; i<canteenCategory.length;i++)
                  Tab(
                    child: Text(canteenCategory[i].categoryName ?? ''),
                  ),
                ]
            ),
            const SizedBox(
              height: 10,
            ),
              Expanded(
              child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    for(int i=0; i<canteenCategory.length;i++)
                     const CanteenProductWidget(
                    ),
              ]),
            )

          ],
        ),
      ),
    );
  }
}

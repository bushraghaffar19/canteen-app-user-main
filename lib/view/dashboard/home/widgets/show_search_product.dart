import 'package:canteen_ordering_user/model/category_model.dart';
import 'package:canteen_ordering_user/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Constant/constant.dart';

class ShowSearchProduct extends StatelessWidget {
  final bool isFav;
  final VoidCallback? onTap;
  final ProductModel productModel;
  const ShowSearchProduct({Key? key, required this.productModel, this.onTap,required this.isFav}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String categoryName = categoryController.category.where((element) => element.categoryId == productModel.categoryId).first.categoryName ??'';
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          10.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.07),
            spreadRadius: 3,
            blurStyle: BlurStyle.normal,
            blurRadius: 20,
            offset: const Offset(1, 1), // changes position of shadow
          ),
        ],
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                child: Image(
                  image: NetworkImage(productModel.image ??''),
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(productModel.name ??'',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                          color: Colors.black
                      ),),
                    const SizedBox(height: 5,),
                    Text(categoryName,style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: kLightGreyColor
                    ),),
                    const SizedBox(height: 10,),
                    Text(productModel.price.toString() ??'',style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: kButtonColor
                    ),),
                  ],
                ),
              ),
              GestureDetector(
                onTap:(){
                  if(productModel.isProductAvailable == false){
                    Get.snackbar("Out of stock",
                        "This product is not available in stock",
                        colorText: Colors.black
                    );
                  }
                  else{
                    cartController.addProductToCart(productModel);
                  }
                },
                child: Card(
                  elevation: 10,
                  color: kLightTextColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child:  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon( CupertinoIcons.cart_fill,color: Colors.white,),
                  ),
                ),
              ),
              const SizedBox(width: 10,),

            ],
          ),
         isFav ? Positioned(
            top: 5,
            right: 10,
            child: InkWell(
                onTap:onTap,
                child: const Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.close))),
          ):const SizedBox(),
        ],
      )
    );
  }
}

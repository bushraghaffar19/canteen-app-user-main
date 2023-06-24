import 'package:canteen_ordering_user/Constant/constant.dart';
import 'package:canteen_ordering_user/model/product_model.dart';
import 'package:canteen_ordering_user/view/dashboard/cart/cart_screen.dart';
import 'package:canteen_ordering_user/view/dashboard/home/rating_and_review/show_product_rating.dart';
import 'package:canteen_ordering_user/widgets/custom_button.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CanteenDetailScreen extends StatefulWidget {
  final ProductModel productModel;
  const CanteenDetailScreen({Key? key, required this.productModel}) : super(key: key);

  @override
  State<CanteenDetailScreen> createState() => _CanteenDetailScreenState();
}

class _CanteenDetailScreenState extends State<CanteenDetailScreen> {
  bool isFavourite = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final h = size.height;
    final w = size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productModel.name ??'',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black
        ),),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: NetworkImage(widget.productModel.image ??''),
            height: h*.3,
            width: w,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 15,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Rs.${widget.productModel.price}",style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: kButtonColor
                      ),),
                      const Spacer(),
                      GestureDetector(
                        onTap:(){
                          setState(() {
                            widget.productModel.isFav = !(widget.productModel.isFav ??false);
                          });
                          productController.updateProductFav(widget.productModel.id ??'', widget.productModel.isFav ??false);
                        },
                        child: Card(
                          elevation: 10,
                          color: kLightTextColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child:  Padding(
                            padding: const EdgeInsets.all(10),
                            child: Icon(widget.productModel.isFav ==false ? CupertinoIcons.heart:CupertinoIcons.heart_fill,color: Colors.white,),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      GestureDetector(
                        onTap:(){
                          Get.to(const CartScreen(),
                              duration: const Duration(seconds: 2), //duration of transitions, default 1 sec
                              transition: Transition.cupertinoDialog
                          );
                        },
                        child: Card(
                          elevation: 10,
                          color: kLightTextColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child:  const Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(CupertinoIcons.cart_fill,color: Colors.white,),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      GestureDetector(
                        onTap:(){
                          reviewController.getProductReview(context,widget.productModel);
                        },
                        child: Card(
                          elevation: 10,
                          color: kLightTextColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child:  const Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(CupertinoIcons.star,color: Colors.white,),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15,),
                  Text("Description",style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black
                  ),),
                  const SizedBox(height: 5,),
                  Text(widget.productModel.description ??'',
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                      color: kLightGreyColor
                  ),),
                  const Spacer(),
                  GestureDetector(
                    onTap: (){
                      if(widget.productModel.isProductAvailable == false){
                        Get.snackbar("Out of stock",
                            "This product is not available in stock",
                            colorText: Colors.black
                        );
                      }
                      else{
                        //cartController.addProductToCart(widget.productModel);
                        if (cartController != null && widget.productModel != null) {
                          cartController.addProductToCart(widget.productModel);
                        }
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 5),
                      height: 60,
                      decoration: BoxDecoration(
                          color: kButtonColor,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Add to cart",style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white
                          ),),
                          Card(
                            elevation: 10,
                            color: kLightTextColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(CupertinoIcons.bag_fill,color: Colors.white,),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 50,),
                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}

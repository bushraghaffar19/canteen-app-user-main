import 'package:canteen_ordering_user/Constant/constant.dart';
import 'package:canteen_ordering_user/model/cart_model.dart';
import 'package:canteen_ordering_user/model/category_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowCartWidget extends StatelessWidget {
  final CartItemModel cartItemModel;
  const ShowCartWidget({
    Key? key, required this.cartItemModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CategoryModel categoryModel = categoryController.category.where((value) => value.categoryId == cartItemModel.product?.categoryId).first;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  image: NetworkImage(cartItemModel.product?.image ??''),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: SizedBox(
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(cartItemModel.product?.name ??'',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.inter(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black
                                ),),
                            ),
                            GestureDetector(
                              onTap: (){
                                cartController.removeCartItem(cartItemModel);
                              },
                                child: const Icon(Icons.clear))
                          ],
                        ),
                        const SizedBox(height: 5,),
                        Text(categoryModel.categoryName ??'',style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: kLightGreyColor
                        ),),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Rs.${cartItemModel.product?.price ??''}",style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: kButtonColor
                            ),),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                              decoration: BoxDecoration(
                                  color: kButtonColor,
                                  borderRadius: BorderRadius.circular(7)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap:(){
                                      cartController.decreaseQuantity(cartItemModel);
                                    },
                                    child: Card(
                                      color: kLightTextColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5)
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(4),
                                        child: Icon(CupertinoIcons.minus,color: Colors.white,size: 15,),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5,),
                                  Text(cartItemModel.quantity.toString(),style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white
                                  ),),
                                  const SizedBox(width: 5,),
                                  GestureDetector(
                                    onTap:(){
                                      cartController.increaseQuantity(cartItemModel);
                                    },
                                    child: Card(
                                      color: kLightTextColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5)
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(4),
                                        child: Icon(CupertinoIcons.plus,color: Colors.white,size: 15,),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

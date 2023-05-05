import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Constant/constant.dart';
import '../product_details_canteen.dart';

class CanteenProductWidget extends StatefulWidget {
  const CanteenProductWidget({Key? key}) : super(key: key);

  @override
  State<CanteenProductWidget> createState() => _CanteenProductWidgetState();
}

class _CanteenProductWidgetState extends State<CanteenProductWidget> {
  @override
  Widget build(BuildContext context) {
    return productController.categoryWiseProductProduct.isNotEmpty ? Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: AnimationLimiter(
        child: GridView.count(
          crossAxisSpacing: 10,
          shrinkWrap: true,
          childAspectRatio: (1 / 1.5),
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: [
            for (int i = 0; i < productController.categoryWiseProductProduct.length; i++)
              AnimationConfiguration.staggeredList(
                position: i,
                duration: const Duration(seconds: 2),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                            ),
                            child: Image(
                              image: NetworkImage(productController.categoryWiseProductProduct[i].image ??''),
                              height: 80,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(productController.categoryWiseProductProduct[i].name ??'',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black
                              ),),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(productController.categoryWiseProductProduct[i].description ??'',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: kLightGreyColor
                              ),),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text("Rs.${productController.categoryWiseProductProduct[i].price}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: kButtonColor
                              ),),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(productController.categoryWiseProductProduct[i].isProductAvailable == true ? "in stock":"out of stock",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: productController.categoryWiseProductProduct[i].isProductAvailable == true ? Colors.green:Colors.red,
                              ),),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(() => CanteenDetailScreen(productModel: productController.categoryWiseProductProduct[i],),
                                        duration: const Duration(seconds: 2), //duration of transitions, default 1 sec
                                        transition: Transition.cupertinoDialog
                                    );
                                  },
                                  child: Container(
                                    height: 35,
                                    decoration: BoxDecoration(
                                        color:
                                        Theme.of(context).colorScheme.primary,
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(5))),
                                    child: Center(
                                      child: Text("BUY NOW",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white
                                        ),),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                  onTap: (){
                                    if(productController.categoryWiseProductProduct[i].isProductAvailable == false){
                                      Get.snackbar("Out of stock",
                                          "This product is not available in stock",
                                          colorText: Colors.black
                                      );
                                    }
                                    else{
                                      cartController.addProductToCart(productController.categoryWiseProductProduct[i]);
                                    }
                                  },
                                  child: const Icon(CupertinoIcons.add)),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    ):
        const Center(
          child: Text("product not found in this category"),
        )
    ;
  }
}

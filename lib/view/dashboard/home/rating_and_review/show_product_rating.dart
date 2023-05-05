import 'package:canteen_ordering_user/Constant/constant.dart';
import 'package:canteen_ordering_user/model/product_model.dart';
import 'package:canteen_ordering_user/view/dashboard/home/rating_and_review/rating_component/rating_product_top_widget.dart';
import 'package:canteen_ordering_user/view/dashboard/home/rating_and_review/rating_component/show_rating_box.dart';
import 'package:canteen_ordering_user/view/dashboard/home/rating_and_review/write_a_review.dart';
import 'package:canteen_ordering_user/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowProductRating extends StatefulWidget {
  final ProductModel itemModel;
  const ShowProductRating({Key? key, required this.itemModel})
      : super(key: key);
  @override
  State<ShowProductRating> createState() => _ShowProductRatingState();
}

class _ShowProductRatingState extends State<ShowProductRating> {
  isAlreadyReviewed() =>
      reviewController.ratingListData.where((item) => item.userId == userController.userData.value.uid)
          .isNotEmpty;
  @override
  Widget build(BuildContext context) {
    print(isAlreadyReviewed());
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Rating & Review",
          style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: theme.primaryColor,
            size: 18,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() => Stack(
        children: [
          reviewController.ratingListData.isNotEmpty ? SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    RatingProductTopWidget(itemModel: widget.itemModel),
                    const SizedBox(
                      height: 15,
                    ),
                    Divider(
                      thickness: 1,
                      color: theme.cardColor,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: reviewController.ratingListData.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: ShowRatingBox(ratingModel: reviewController.ratingListData[index]),
                          );
                        }),
                    const SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ),
            ),
          ):
          Center(
            child: Text(
              "Product review not found",
              style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black
              ),
            ),
          ),
          isAlreadyReviewed() ? const SizedBox() : Positioned(
            left: 20,
            right: 20,
            bottom: 35,
            child: CustomButton(
              title: 'Write a review',
              textColor: Colors.white,
              function: () {
                Get.to(WriteReview(productModel: widget.itemModel,),
                    duration: const Duration(seconds: 2), //duration of transitions, default 1 sec
                    transition: Transition.cupertinoDialog
                );
              },
              buttonColor: kButtonColor,
            ),
          )
        ],
      ))
    );
  }
}

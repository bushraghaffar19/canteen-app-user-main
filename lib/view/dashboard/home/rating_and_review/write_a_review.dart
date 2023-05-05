import 'package:canteen_ordering_user/Constant/constant.dart';
import 'package:canteen_ordering_user/model/product_model.dart';
import 'package:canteen_ordering_user/widgets/custom_button.dart';
import 'package:canteen_ordering_user/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WriteReview extends StatefulWidget {
  final ProductModel productModel;
  const WriteReview({required this.productModel,Key? key}) : super(key: key);

  @override
  State<WriteReview> createState() => _WriteReviewState();
}

class _WriteReviewState extends State<WriteReview> {
  final TextEditingController _reviewTextEditController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  double productRating = 1.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Write a Review",
          style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: kButtonColor,
            size: 18,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
            width: double.infinity,
          ),
        Align(
          alignment: Alignment.center,
          child: RatingBar.builder(
            initialRating: productRating,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: kYellowColor,
            ),
            onRatingUpdate: (rating) {
              productRating = rating;
              setState(() {
              });
            },
          ),
        ),
          const SizedBox(
            height: 30,
            width: double.infinity,
          ),
          Text(
            "Write your Review",
            style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black
            ),
          ),
          const SizedBox(
            height: 20,
            width: double.infinity,
          ),
          Form(
            key: _formKey,
            child: CustomTextField(
                controller: _reviewTextEditController,
                maxLine: 6,
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return 'Please enter your review';
                  }
                  return null;
                },
                hintText: "share your though about this product"
            ),
          ),
          const Spacer(),
          CustomButton(
              textColor: Colors.white,
              buttonColor: kButtonColor,
              title: "Submit Review",
              function: (){
                if(_formKey.currentState!.validate()){
                  reviewController.addProductReview(productRating, _reviewTextEditController.text, context,widget.productModel);
                }
              }),
          const SizedBox(
            height: 40,
            width: double.infinity,
          ),
        ],
      ),
      ),
    );
  }
}

import 'package:canteen_ordering_user/Constant/constant.dart';
import 'package:canteen_ordering_user/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RatingProductTopWidget extends StatelessWidget {
  final ProductModel itemModel;
  const RatingProductTopWidget({Key? key, required this.itemModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage(itemModel.image ??''),
                  fit: BoxFit.cover)),
        ),
        const SizedBox(
          width: 20,
        ),
         SizedBox(
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                itemModel.name ?? '',
                style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: kYellowColor,
                    size: 25,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Obx(() => Text(reviewController.ratingAverage.value.toStringAsFixed(1),
                  style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black
                  ),),),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
              Obx(() => Text("${reviewController.ratingListData.length} reviews",
                style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black
                ),),),
            ],
          ),
        )
      ],
    );
  }
}

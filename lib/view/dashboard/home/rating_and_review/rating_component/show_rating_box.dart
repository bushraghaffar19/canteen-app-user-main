import 'package:canteen_ordering_user/model/rating_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../Constant/constant.dart';

class ShowRatingBox extends StatelessWidget {
  final RatingModel ratingModel;
  const ShowRatingBox({Key? key, required this.ratingModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).hintColor.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 30,
                offset: const Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ratingModel.reviewerName ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: theme.primaryColor),
                  ),
                  Text(
                    DateFormat('dd-MM-yyyy').format(ratingModel.date ?? DateTime.now()),
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              RatingBarIndicator(
                rating: ratingModel.rating ?? 5,
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: kYellowColor,
                ),
                itemCount: 5,
                itemSize: 20,
                //direction: Axis.vertical,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                ratingModel.description ?? '',
                style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  height: 1.5
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
        Positioned(
            left: 0,
            right: 0,
            top: -20,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(ratingModel.reviewerImage ?? ''),
                  )),
            ))
      ],
    );
  }
}

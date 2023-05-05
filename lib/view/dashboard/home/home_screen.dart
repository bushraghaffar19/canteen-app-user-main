import 'package:canteen_ordering_user/Constant/constant.dart';
import 'package:canteen_ordering_user/view/dashboard/cart/cart_screen.dart';
import 'package:canteen_ordering_user/view/dashboard/home/canteen_products.dart';
import 'package:canteen_ordering_user/view/dashboard/home/widgets/home_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart' as badges;
import 'favourite_product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _restaurantName = [
    "GCR Canteen",
    "SFC Canteen",
    "Nedia Canteen",
    "Enviro Canteen",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
          title: Text("Cafeteria App",style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black
          ),),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: (){
                  Get.to(const CartScreen(),
                      duration: const Duration(seconds: 2), //duration of transitions, default 1 sec
                      transition: Transition.cupertinoDialog
                  );
                },
                icon:Obx(() => badges.Badge(
                    position: badges.BadgePosition.custom(top: -3, end: -6),
                    badgeAnimation: const badges.BadgeAnimation.slide(
                      disappearanceFadeAnimationDuration: Duration(milliseconds: 200),
                      curve: Curves.easeInCubic,
                    ),
                    showBadge: userController.userData.value.cart?.length !=0 ?true:false,
                    badgeStyle: const badges.BadgeStyle(
                      badgeColor: Colors.red,
                    ),
                    badgeContent:  Text("${userController.userData.value.cart?.length}", style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                    ),),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(CupertinoIcons.cart_fill),
                    )
                ))
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child:Column(
          children: [
            const HomeSlider(),
            const SizedBox(
              height: 15,
            ),
            Text("Cafeterias",style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black
            ),),
            const SizedBox(
              height: 20,
            ),
            Obx(() =>
                AnimationLimiter(
                  child: GridView.count(
              crossAxisSpacing: 10,
              shrinkWrap: true,
              childAspectRatio: (1 / 1.2),
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: [
                  for (int i = 0; i < canteenController.canteens.length; i++)
                    AnimationConfiguration.staggeredGrid(
                      position: i,
                      duration: const Duration(seconds: 2),
                      columnCount: canteenController.canteens.length,
                      child: SlideAnimation(
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
                                    image: NetworkImage(canteenController.canteens[i].image ??''),
                                    height: 120,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(canteenController.canteens[i].name ??'',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.inter(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black
                                    ),),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() =>  CanteenProducts(canteenModel: canteenController.canteens[i],),
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
                                          bottomLeft: Radius.circular(5),
                                          bottomRight: Radius.circular(5),
                                        )),
                                    child:  Center(
                                      child: Text("VISIT NOW",
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
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
              ],
            ),
                ),),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:canteen_ordering_user/model/product_model.dart';
import 'package:canteen_ordering_user/view/dashboard/cart/cart_screen.dart';
import 'package:canteen_ordering_user/view/dashboard/home/widgets/show_search_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Constant/constant.dart';

class SearchProductScreen extends StatefulWidget {
  final List<ProductModel> products ;
  const SearchProductScreen({Key? key, required this.products}) : super(key: key);

  @override
  State<SearchProductScreen> createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  final TextEditingController _searchTextController = TextEditingController();
  RangeValues _currentRangeValues = const RangeValues(0, 1000);



  String firstPrice = '';
  String endPrice = '';
  double average = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstPrice = _currentRangeValues.start.round().toString();
    searchList.addAll(widget.products);
    filterProductByPrice(_currentRangeValues.start.round().toDouble() , _currentRangeValues.end.round().toDouble());
    endPrice = _currentRangeValues.end.round().toString();
    average =
        (_currentRangeValues.start.round() + _currentRangeValues.end.round()) /
            2;
  }

  List<ProductModel> searchList = [];
  void searchProduct(String query) {
    print(query.toString());
    List<ProductModel> dummySearchList = [];
    dummySearchList.addAll(widget.products);
    if(query.isNotEmpty) {
      List<ProductModel> dummyListData = [];
      
      for (var item in dummySearchList) {
        if(item.name!.toLowerCase().toLowerCase().contains(query)) {
          dummyListData.add(item);
        }
      }
      setState(() {
        searchList.clear();
        searchList.addAll(dummyListData);
      });
      return;
    }
    else {
      setState(() {
        searchList.clear();
        searchList.addAll(dummySearchList);
      });
    }
  }

  void filterProductByPrice(double minPrice , double maxPrice){
    List<ProductModel> dummySearchList = [];
    dummySearchList.addAll(widget.products);
    List<ProductModel> dummyListData =[];
    for (var item in dummySearchList) {
      if(item.price!.isBetween(minPrice, maxPrice)) {
        dummyListData.add(item);
      }
    }
    setState(() {
      searchList.clear();
      searchList.addAll(dummyListData);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.to(const CartScreen(),
              duration: const Duration(seconds: 2), //duration of transitions, default 1 sec
              transition: Transition.cupertinoDialog
          );
        },
        child: const Icon(CupertinoIcons.cart_fill),
      ),
      appBar: AppBar(
        // The search area here
          title: Center(
            child: TextField(
              controller: _searchTextController,
              onChanged: (value){
                searchProduct(value.toLowerCase());
              },
              decoration: InputDecoration(
                   suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchTextController.clear();
                      setState(() {
                        searchList.clear();
                        searchList.addAll(widget.products);
                      });
                    },
                  ),
                  hintText: 'Search...',
                  border: InputBorder.none),
            ),
          )),
      body: Column(
        children: [
          //const SizedBox(height: 10,),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
                left: 20, right: 20, top: 20, bottom: 10),
            decoration: BoxDecoration(
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(TextSpan(
                            text: 'Price ',
                            style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: kButtonColor),
                            children: <InlineSpan>[
                              TextSpan(
                                text: 'Range',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              )
                            ])),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Rs.$firstPrice - Rs.$endPrice',
                          style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        )
                      ],
                    ),
                    Container(
                      height: 30,
                      width: 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color(0xffFDFAF8)),
                      child: Center(
                        child: Text(
                          'Average Price : Rs${average.round()}',
                          style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: kButtonColor),
                        ),
                      ),
                    )
                  ],
                ),
                SliderTheme(
                  data: const SliderThemeData(
                    trackHeight: 1,
                  ),
                  child: RangeSlider(
                    activeColor: kButtonColor,
                    inactiveColor: kLightGreyColor,
                    values: _currentRangeValues,
                    min: 0,
                    max: 2000,
                    labels: RangeLabels(
                      _currentRangeValues.start.round().toString(),
                      _currentRangeValues.end.round().toString(),
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        _currentRangeValues = values;
                        firstPrice = values.start.round().toString();
                        endPrice = values.end.round().toString();
                        average =
                            (values.start.round() + values.end.round()) / 2;
                      });
                      filterProductByPrice(values.start.round().toDouble() , values.end.round().toDouble());
                    },
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10,),
           searchList.isNotEmpty ? Expanded(
              child: AnimationLimiter(
                child: ListView.builder(
                    itemCount: searchList.length,
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                      return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(seconds: 2),
                          child: SlideAnimation(
                              horizontalOffset: -50.0,
                              child: FadeInAnimation(
                                  child: ShowSearchProduct(productModel: searchList[index],isFav: false,))));
                    }),
              )):
           Text(
             'No search result found',
             style: GoogleFonts.inter(
                 fontSize: 12,
                 fontWeight: FontWeight.w500,
                 color: kButtonColor),
           ),
        ],
      ),
    );
  }
}

extension Range on double {
  bool isBetween(double from, double to) {
    return from <= this && this <= to;
  }
}
import 'package:canteen_ordering_user/Constant/constant.dart';
import 'package:canteen_ordering_user/model/product_model.dart';
import 'package:canteen_ordering_user/view/dashboard/home/widgets/show_search_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FavouriteProduct extends StatefulWidget {
  final String canteenId;
  final String categoryId;
  final List<ProductModel> canteenProduct ;
  const FavouriteProduct({Key? key, required this.canteenId, required this.categoryId, required this.canteenProduct}) : super(key: key);

  @override
  State<FavouriteProduct> createState() => _FavouriteProductState();
}

class _FavouriteProductState extends State<FavouriteProduct> {
  @override
  void initState() {
    super.initState();
    productController.getFavouriteCanteenProduct(widget.canteenId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourite Product",style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black
        ),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10,width: double.infinity,),
          productController.favCanteenProducts.isNotEmpty ? Expanded(
              child: ListView.builder(
                  itemCount: productController.favCanteenProducts.length,
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    return ShowSearchProduct(
                      onTap: () {
                        productController.updateProductFav(productController.favCanteenProducts[index].id ??'', false);
                        for(var list in widget.canteenProduct){
                          if(list.id == productController.favCanteenProducts[index].id){
                            list.isFav =false;
                          }
                        }
                        setState(() {
                          productController.favCanteenProducts.removeWhere((element) => element.id == productController.favCanteenProducts[index].id);
                        });
                      },
                      productModel: productController.favCanteenProducts[index],
                      isFav: true,);
                  })):
          Text(
            'No favourite product found',
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

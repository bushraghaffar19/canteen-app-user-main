import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';


class HomeSlider extends StatefulWidget {
  const HomeSlider({Key? key}) : super(key: key);

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}
int currentIndex = 0;
List<String> imageUrl = [
  "https://images.unsplash.com/photo-1472851294608-062f824d29cc?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTV8fGUlMjBjb21tZXJjZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60",
  "https://images.unsplash.com/photo-1599658880436-c61792e70672?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjN8fGUlMjBjb21tZXJjZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60",
  "https://images.unsplash.com/photo-1475275083424-b4ff81625b60?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDF8fGUlMjBjb21tZXJjZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60"
];
final List<Widget> introWidgetsList = <Widget>[
  for (int i = 0; i < imageUrl.length; i++)
    SliderWidgetBox(
      imageUrl: imageUrl[i],
      currentPos: i+1,
      total: imageUrl.length,
    ),

];

class _HomeSliderState extends State<HomeSlider> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: [
          CarouselSlider(
              options: CarouselOptions(
                  height: h*.20,
                  //aspectRatio: 16/9,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  }
              ),
              items: introWidgetsList
          ),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < imageUrl.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Container(
                    width: currentIndex == i ? 30:8,
                    height: 8,
                    decoration: BoxDecoration(
                        color: currentIndex == i ? Theme.of(context).iconTheme.color:Theme.of(context).textTheme.headline2?.color,
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                )
            ],
          )
        ],
      ),
    );
  }
}


class SliderWidgetBox extends StatelessWidget {
  final String imageUrl;
  final int total;
  final int currentPos;
  const SliderWidgetBox({required this.currentPos ,required this.total,required this.imageUrl,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Image(
        image: NetworkImage(imageUrl),fit: BoxFit.fill,),
    );
  }
}

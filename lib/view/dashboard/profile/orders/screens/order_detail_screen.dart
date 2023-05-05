import 'dart:async';

import 'package:canteen_ordering_user/Constant/app_fonts.dart';
import 'package:canteen_ordering_user/Constant/constant.dart';
import 'package:canteen_ordering_user/model/order_model.dart';
import 'package:canteen_ordering_user/widgets/custom_button.dart';
import 'package:canteen_ordering_user/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


class OrderDetailScreen extends StatefulWidget {
  final OrderModel orderModel;
  const OrderDetailScreen({Key? key, required this.orderModel}) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> with SingleTickerProviderStateMixin {
  DateTime currentDateTime = DateTime.now();
  late DateTime orderDateTime;
  late DateTime orderAfterMinutes;
  late int resultedMinutes;
  late Timer _timer;
  int totalSeconds = 0;
  Duration? timerDuration;
  double percentage = 1;
  String seconds = "";
  String minutes = "";

  Future<void> timeInMinutes(int timeInSecond) async {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    setState(() {
      minutes = min.toString().length <= 1 ? "0$min" : "$min";
      seconds = sec.toString().length <= 1 ? "0$sec" : "$sec";
    });
  }
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (totalSeconds == 0) {
          timer.cancel();
        } else {
          timeInMinutes(totalSeconds);
          totalSeconds--;
        }
      },
    );
  }

  @override
  void initState() {
    orderDateTime = widget.orderModel.orderOn ?? DateTime.now();
    orderAfterMinutes = orderDateTime.add(const Duration(minutes: 5));
    Duration  difference = orderAfterMinutes.difference(currentDateTime);

    if(difference.inSeconds < 0){
      totalSeconds = 0;
    }
    else{
      totalSeconds = difference.inSeconds;
    }
    startTimer();

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text(
          "Order Detail",
          style: AppFonts.kFont16ptBold,
        ),
      ),
       floatingActionButton: widget.orderModel.paymentStatus == "pending" && totalSeconds != 0 ? FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: (){
          orderController.deleteOrder(widget.orderModel.orderId ??'',context);
        },
        child: const Icon(Icons.delete,color:Colors.red),
      ):null,
      body: LayoutBuilder(
        builder: (context, constraint) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20,),
                      widget.orderModel.paymentStatus == "pending" && totalSeconds != 0
                          ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 150,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                                  color: kButtonColor,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(
                                child: Text(
                                  "$minutes : $seconds",
                                  style: GoogleFonts.inter(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Note: yon can cancel the order within this specific times',
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.red
                            ),
                          ),
                        ],
                      ) : const SizedBox(),
                      const SizedBox(height: 40,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '#${widget.orderModel.orderCode.toString()}',
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black
                            ),
                          ),
                          Text(
                            widget.orderModel.orderStatus ??'',
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: widget.orderModel.orderStatus == "pending" ? Colors.red :Colors.green
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Text(
                        DateFormat('dd MMMM, yyyy - h:mm a').format(widget.orderModel.orderOn ?? DateTime.now()),
                        style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black
                        ),
                      ),
                      widget.orderModel.roomNo == '' ?const SizedBox():Column(
                        children: [
                          const SizedBox(height: 20,),
                          Text(
                            "Delivered to",
                            style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black
                            ),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            widget.orderModel.roomNo ??'',
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Text(
                        "Payment Method",
                        style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black
                        ),
                      ),
                      const SizedBox(height: 5,),
                      Text(
                        widget.orderModel.paymentMethod ??'',
                        style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Payment Status",
                            style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black
                            ),
                          ),
                          Text(
                            widget.orderModel.paymentStatus ??'',
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color:widget.orderModel.paymentStatus == "pending" ? Colors.red :Colors.green
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30,),
                      Divider(color: kLightGreyColor.withOpacity(.5),thickness: .5,),
                      const SizedBox(height: 20,),
                      ...widget.orderModel.cart!.map((item) {
                        return RowWidget(title: "${item.product?.name} x ${item.quantity}",
                            subtitle: "Rs.${(item.product?.price )??'' * (item.quantity ??0) }"
                        );
                      }).toList(),
                      const SizedBox(height: 20,),
                      Divider(color: kLightGreyColor.withOpacity(.5),thickness: .5,),
                      const SizedBox(height: 20,),
                      RowWidget(title: "Subtotal", subtitle: "Rs.${widget.orderModel.totalAmount}"),
                      const Spacer(),
                      widget.orderModel.orderStatus == "Delivered"?CustomButton(textColor: kBackgroundColor,
                          buttonColor: kButtonColor,
                          title: "Received",
                          function: (){
                            orderController.updateOrderStatus(
                                {
                                  OrderModel.orderSTATUS:"Received",
                                  OrderModel.paymentSTATUS:"Success"
                                },
                                widget.orderModel.orderId ??'').then((value) {
                              Get.back();
                            });
                          }):const SizedBox(),
                      const SizedBox(height: 60,),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}

class RowWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  const RowWidget({Key? key, required this.title, required this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black
            ),
          ),
          Text(
            subtitle,
            style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black
            ),
          ),
        ],
      ),
    );
  }
}

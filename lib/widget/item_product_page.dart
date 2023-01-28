import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:serenity/common/color.dart';

import '../model/product.dart';

class ItemProductPage extends StatelessWidget {
  const ItemProductPage({super.key, required this.product, required this.onTapDetail,required this.onTapUpdate});
  final Product product;
  final Function() onTapDetail;
  final Function() onTapUpdate;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          Expanded(
            flex: 6,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Container(
                child: Image.network(product.image!,height: 150,width: 150,),),
              SizedBox(width: 10,),
              Flexible(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(product.name!,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Color(0xFF1d272d)),),
                    SizedBox(height: 6,),
                    Text(product.content!,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Color(0xFFA5A6A8)),maxLines: 4,overflow: TextOverflow.ellipsis,),
                    SizedBox(height: 6,),
                    Text(NumberFormat.simpleCurrency(locale: "vi-VN",decimalDigits: 0).format(int.tryParse(product.price!)),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Color(0xFF1d272d)),),
                  ],),
                ),
            ],),
          ),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                InkWell(
                  onTap: onTapDetail, child: Container(
                    height: 40,
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: CustomColor.second
                    ),
                    child: Center(child: Text("View Detail",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),)))),
                    SizedBox(height: 10,),
                  InkWell(
                  onTap: onTapUpdate, child: Container(
                    height: 40,
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey
                    ),
                    child: Center(child: Text("Update",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),)))),
              ],
            ))
        ]),
      ),
    );
  }
}
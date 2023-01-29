import 'package:flutter/material.dart';
import 'package:serenity/common/color.dart';
import 'package:intl/intl.dart';
import '../model/product.dart';


class ItemProductMenu extends StatelessWidget {
  const ItemProductMenu({super.key, required this.product, required this.onTap});
  final Product product;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          Expanded(
            flex: 8,
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
            flex: 2,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30),),),
                minimumSize: Size(double.infinity,60),
              ),
              onPressed: onTap, child: Text("Add to bill")))
        ]),
      ),
    );
  }
}
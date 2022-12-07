import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:serenity/model/product_cart.dart';

import '../bloc/blocCart/bloc/cart_bloc.dart';

class ItemCart extends StatelessWidget {
  const ItemCart({super.key, required this.productCart,});
  final ProductCart productCart;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(       
          children: [
          Image.network(productCart.product!.image.toString(),height: 130,width: 130,),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(productCart.product!.name.toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,),),
          Text(productCart.product!.category.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Color(0xFFBFBFBF)),),
          Text(NumberFormat.simpleCurrency(locale: "vi-VN",decimalDigits: 0).format(int.tryParse(productCart.product!.price!)!*productCart.amount!).toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
          Row(children: [
            InkWell(
              onTap: (){
                BlocProvider.of<CartBloc>(context).add(DecreaseProductCart(productCart.product!));
              },
              child: Icon(Icons.remove,color: Colors.grey,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(productCart.amount.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
            ),
            InkWell(
              onTap: (){
                BlocProvider.of<CartBloc>(context).add(AddProductCart(productCart.product!));
              },
              child: Icon(Icons.add),
            )
          ],)
        ],),
        ],),
        InkWell(
          onTap: (){
            BlocProvider.of<CartBloc>(context).add(RemoveProductCart(productCart.product!));
          },
          child: Icon(Icons.close),
        )
      ],);
  }
}
import 'dart:ui';

import 'package:another_flushbar/flushbar.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:serenity/common/color.dart';
import 'package:serenity/model/category.dart';
import 'package:serenity/widget/item_cart.dart';
import 'package:serenity/widget/item_product_menu.dart';

import '../bloc/blocCart/bloc/cart_bloc.dart';
import '../bloc/blocCheckOut/bloc/checkout_bloc.dart';
import '../bloc/blocOrder/order_bloc.dart';
import '../model/Customer.dart';
import '../model/product_cart.dart';
import '../model/voucher.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _queryController = TextEditingController();
  String methodPayment="";
  @override
  void initState() {
    BlocProvider.of<CartBloc>(context).add(LoadCart());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CartLoaded) {
            int total = 0;
            state.listProductCart.forEach(
              (element) {
                total += int.parse(element.product!.price!) * element.amount!;
              },
            );
            return SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Welcome to Serenity",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFFA5A6A8)),
                                ),
                                Text(
                                  "Let's choose flower",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF1d272d)),
                                ),
                              ],
                            ),
                            Container(
                              height: 60,
                              width: 500,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: TextField(
                                  controller: _queryController,
                                  onChanged: (value) {
                                    BlocProvider.of<CartBloc>(context).add(
                                        SearchProduct(
                                            _queryController.text.trim()));
                                  },
                                  decoration: const InputDecoration(
                                      suffixIcon: Icon(Icons.search),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 16),
                                      border: InputBorder.none,
                                      hintText: 'Search product',
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFFBFBFBF))),
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 4,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white),
                            child: IconButton(
                              icon: Icon(Icons.chevron_right),
                              onPressed: () {
                                BlocProvider.of<OrderBloc>(context).add(LoadOrder());
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Divider(
                    height: 2,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Column(children: [
                            Container(
                              height: 60,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.listCategory.length,
                                itemBuilder: (context, index) {
                                  return state.listCategory[index] !=
                                          state.selectedCategory
                                      ? ItemCategory(state.listCategory[index],
                                          () {
                                          BlocProvider.of<CartBloc>(context)
                                              .add(ChooseCategory(
                                                  state.listCategory[index]));
                                        })
                                      : ItemSelectedCategory(
                                          state.listCategory[index]);
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 14.0),
                                child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 20.0,
                                          mainAxisSpacing: 20.0,
                                          mainAxisExtent: 270),
                                  itemCount: state.listProduct.length,
                                  itemBuilder: (context, index) {
                                    return ItemProductMenu(
                                      product: state.listProduct[index],
                                      onTap: () {
                                        BlocProvider.of<CartBloc>(context).add(
                                            AddProductCart(
                                                state.listProduct[index]));
                                      },
                                    );
                                  },
                                ),
                              ),
                            )
                          ]),
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 16),
                                  child: Column(children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Cart",
                                          style: TextStyle(
                                              fontSize: 26,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text("",
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFFA5A6A8)))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Expanded(
                                        child: Column(
                                      children: [
                                        Expanded(
                                          child: ListView.separated(
                                            separatorBuilder:
                                                (BuildContext context,
                                                        int index) =>
                                                    const Divider(),
                                            itemCount:
                                                state.listProductCart.length,
                                            itemBuilder: (context, index) {
                                              return ItemCart(
                                                  productCart: state
                                                      .listProductCart[index]);
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Total",
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFFA5A6A8)),
                                            ),
                                            Text(
                                                NumberFormat.simpleCurrency(
                                                        locale: "vi-VN",
                                                        decimalDigits: 0)
                                                    .format(total),
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFF5fb282)))
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(30),
                                                ),
                                              ),
                                              minimumSize:
                                                  Size(double.infinity, 60),
                                            ),
                                            onPressed: () {
                                              if(state.listProductCart.length==0){
                                                errorCart();
                                              }
                                              else{
                                                _showCheckOut(state.listProductCart);
                                              }
                                            },
                                            child: Text(
                                              "Checkout",
                                              style: TextStyle(fontSize: 18),
                                            ))
                                      ],
                                    ))
                                  ]),
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ));
          } else {
            return Container();
          }
        },
      ),
    );
  }

  void _showCheckOut(List<ProductCart> listProductCart) {
    BlocProvider.of<CheckoutBloc>(context).add(LoadCheckout(listProductCart));
    showDialog(
      context: context,
      builder: (context) {
        return BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            if(state is CheckoutLoading){
              return Container();
            }
            else if(state is CheckoutLoaded){
              return Dialog(
              child: Container(
                height: 700,
                width: 500,
          
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(children: [
                    SizedBox(height: 20,),
                    Text("Checkout",style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),),
                    SizedBox(height: 20,),
                    DropdownSearch<Customer>(
                      // itemAsString: (Customer u) => u.name.toString(),
                      popupProps: PopupProps.menu(
                        // showSelectedItems: true,

                        itemBuilder: (context, item, isSelected) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Container(
                              height: 50,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item.name.toString(),
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    item.phone.toString(),
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        showSearchBox: true,
                      ),
                      items: state.listCustomer,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                            labelText: "Customer",
                            hintText: "Choose customer",
                            labelStyle: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                            hintStyle: TextStyle(
                              fontSize: 20,
                            ),
                            border: InputBorder.none),
                      ),
                      dropdownBuilder: (context, selectedItem) {
                        return selectedItem == null
                            ? Container(
                                child: Text("Choose customer",style: TextStyle(
                              fontSize: 20,
                            ),),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    selectedItem.name.toString(),
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    selectedItem.phone.toString(),
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              );
                      },
                      onChanged: (value) {
                        BlocProvider.of<CheckoutBloc>(context).add(ChooseCustomer(value!));
                      },
                      selectedItem: null,
                    ),
                    DropdownSearch<Voucher>(
                      // itemAsString: (Customer u) => u.name.toString(),
                      popupProps: PopupProps.menu(
                        // showSelectedItems: true,

                        itemBuilder: (context, item, isSelected) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Container(
                              height: 50,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item.name.toString(),
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    item.content.toString(),
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      items: state.listVoucher,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                            labelText: "Voucher",
                            hintText: "Choose voucher",
                            labelStyle: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                            hintStyle: TextStyle(
                              fontSize: 20,
                            ),
                            border: InputBorder.none),
                      ),
                      dropdownBuilder: (context, selectedItem) {
                        return selectedItem == null
                            ? Container(
                                child: Text("Choose voucher",style: TextStyle(
                              fontSize: 20,
                            ),),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    selectedItem.name.toString(),
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    selectedItem.content.toString(),
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              );
                      },
                      onChanged: (value) {
                        BlocProvider.of<CheckoutBloc>(context).add(ChooseVoucher(value!));
                      },
                      selectedItem: null,
                    ),
                    DropdownSearch<String>(
                      // itemAsString: (Customer u) => u.name.toString(),
                      popupProps: PopupProps.menu(
                        // showSelectedItems: true,

                        itemBuilder: (context, item, isSelected) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Container(
                              height: 50,
                              child: Text(
                                item,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          );
                        },
                      ),
                      items: ["Cash","ZaloPay"],
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                            labelText: "Method Payment",
                            hintText: "Choose method",
                            labelStyle: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                            hintStyle: TextStyle(
                              fontSize: 20,
                            ),
                            border: InputBorder.none),
                      ),
                      dropdownBuilder: (context, selectedItem) {
                        return selectedItem == null
                            ? Container(
                                child: Text("Choose method",style: TextStyle(
                              fontSize: 20,
                            ),),
                              )
                            : Text(
                              selectedItem,
                              style: TextStyle(fontSize: 18),
                            );
                      },
                      onChanged: (value) {
                        setState(() {
                          methodPayment=value!;
                        });
                      },
                      selectedItem: null,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("List items",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),)),
                    Expanded(
                      child: ListView.builder(
                        itemCount: listProductCart.length,
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Text(listProductCart[index].product!.name!+"  x"+listProductCart[index].amount.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),
                            Text(
                                                NumberFormat.simpleCurrency(
                                                        locale: "vi-VN",
                                                        decimalDigits: 0)
                                                    .format(int.parse(listProductCart[index].product!.price!)*listProductCart[index].amount!),
                                                style: TextStyle(
                                                    fontSize: 20,
                                                   
                                                    ))
                          ],);
                      },),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text("Items",style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFFA5A6A8)),),
                      Text(
                                                NumberFormat.simpleCurrency(
                                                        locale: "vi-VN",
                                                        decimalDigits: 0)
                                                    .format(state.totalItem),
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color.fromARGB(255, 55, 170, 103)))
                    ],),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text("Discount",style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFFA5A6A8)),),
                      Text("-"+
                                                NumberFormat.simpleCurrency(
                                                        locale: "vi-VN",
                                                        decimalDigits: 0)
                                                    .format(state.discount),
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color.fromARGB(255, 225, 86, 86)))
                    ],),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text("Total",style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFFA5A6A8)),),
                      Text(
                                                NumberFormat.simpleCurrency(
                                                        locale: "vi-VN",
                                                        decimalDigits: 0)
                                                    .format(state.total),
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color.fromARGB(255, 55, 170, 103)))
                    ],),
                    SizedBox(height: 20,),
                    ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(30),
                                                ),
                                              ),
                                              minimumSize:
                                                  Size(double.infinity, 60),
                                            ),
                                            onPressed: () {
                                              if(state.selectedCustomer==null){
                                                errorCustomer();
                                              }
                                              else if(methodPayment==""){
                                                errorMethodPayment();
                                              }
                                              else{
                                                BlocProvider.of<CheckoutBloc>(context).add(Payment(listProductCart,methodPayment));
                                                BlocProvider.of<CartBloc>(context).add(LoadCart());
                                                // BlocProvider.of<OrderBloc>(context).add(LoadOrder());
                                                Navigator.pop(context);
                                              }
                                              
                                            },
                                            child: Text(
                                              "Payment",
                                              style: TextStyle(fontSize: 18),
                                            )),
                                            SizedBox(height: 10,),
                                            ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(30),
                                                ),
                                              ),
                                              minimumSize:
                                                  Size(double.infinity, 60),
                                                  backgroundColor: Colors.grey
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(fontSize: 18),
                                            )),
                                            SizedBox(height: 10,)
                  ]),
                ),
              ),
            );
            }
            else{
              return Container();
            }
          },
        );
      },
    );
  }
  void errorCustomer(){
    Flushbar(
      backgroundColor: Colors.red,
                                flushbarPosition: FlushbarPosition.TOP,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 300, vertical: 16),
                                borderRadius: BorderRadius.circular(10),
                                flushbarStyle: FlushbarStyle.FLOATING,
                                title: 'Error',
                                message: 'Please choose customer!',
                                duration: const Duration(seconds: 3),
                              ).show(context);
  }
  void errorCart(){
    Flushbar(
      backgroundColor: Colors.red,
                                flushbarPosition: FlushbarPosition.TOP,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 300, vertical: 16),
                                borderRadius: BorderRadius.circular(10),
                                flushbarStyle: FlushbarStyle.FLOATING,
                                title: 'Error',
                                message: 'Please add product!',
                                duration: const Duration(seconds: 3),
                              ).show(context);
  }
  void errorMethodPayment(){
    Flushbar(
      backgroundColor: Colors.red,
                                flushbarPosition: FlushbarPosition.TOP,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 300, vertical: 16),
                                borderRadius: BorderRadius.circular(10),
                                flushbarStyle: FlushbarStyle.FLOATING,
                                title: 'Error',
                                message: 'Please choose method payment!',
                                duration: const Duration(seconds: 3),
                              ).show(context);
  }
}

Widget ItemCategory(Category e, Function() onTap) {
  return Padding(
    padding: const EdgeInsets.only(right: 8),
    child: InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            color: Color(0xFFEFEFEF), borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white),
                    child: Icon(
                      Icons.spa,
                      color: Color(0xFFBFBFBF),
                    )),
                SizedBox(
                  width: 10,
                ),
                Text(
                  e.name.toString(),
                  style: TextStyle(
                      color: Color(0xFFBFBFBF), fontWeight: FontWeight.w600),
                )
              ]),
        ),
      ),
    ),
  );
}

Widget ItemSelectedCategory(Category e) {
  return Padding(
    padding: const EdgeInsets.only(right: 8),
    child: Container(
      height: 40,
      decoration: BoxDecoration(
          color: CustomColor.second, borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white),
                  child: Icon(
                    Icons.spa,
                    color: CustomColor.second,
                  )),
              SizedBox(
                width: 10,
              ),
              Text(
                e.name.toString(),
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              )
            ]),
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serenity/common/color.dart';
import 'package:serenity/screen/cart_page.dart';
import 'package:serenity/widget/modal_detail_product.dart';

import '../bloc/blocProduct/bloc/product_bloc.dart';
import '../model/product.dart';
import '../widget/item_product_menu.dart';
import '../widget/item_product_page.dart';
import '../widget/modal_add_product_page.dart';
import '../widget/modal_update_product.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    BlocProvider.of<ProductBloc>(context).add(LoadProduct());
    super.initState();
  }
  final _queryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if(state is ProductLoading){
            return Center(child: CircularProgressIndicator());
          }
          else if (state is ProductLoaded){
            return Column(children: [
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
                              width: 400,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: TextField(
                                  controller: _queryController,
                                  onChanged: (value) {
                                    BlocProvider.of<ProductBloc>(context).add(SearchProduct(_queryController.text.trim()));
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
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              height: 50,
                              width: 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: CustomColor.second),
                              child: InkWell(child: Center(child: Text("New Product",style: TextStyle(color: Colors.white),)),onTap: (){
                                List<String> temp=[];
                                temp.addAll(state.listCategory.map((e) => e.name!));
                                showDialog(context: context, builder: (context) => AlertDialog(
                                  content: ModalAddProductPage(category: temp ),
                                ),);
                              },)
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
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
                                          BlocProvider.of<ProductBloc>(context).add(ChooseCategory(state.listCategory[index]));
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
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 20.0,
                                          mainAxisSpacing: 20.0,
                                          mainAxisExtent: 340),
                                  itemCount: state.listProduct.length,
                                  itemBuilder: (context, index) {
                                    List<String> temp=[];
                                    temp.addAll(state.listCategory.map((e) => e.name!));
                                    return ItemProductPage(
                                      product: state.listProduct[index],
                                      onTapDetail: () {
                                        showDetailProduct(state.listProduct[index]);
                                      },
                                      onTapUpdate: (){showUpdateProduct(state.listProduct[index],temp);},
                                    );
                                  },
                                ),
                              ),
                            )
                          ]);
          }
          else{
            return Container();
          }
        },
      ),
    ));
  }
  showDetailProduct(Product product){
    showDialog(context: context, builder: (context) => AlertDialog(
      content: ModalDetailProductPage(product: product),
    ),);
  }
  showUpdateProduct(Product product,List<String> category){
    showDialog(context: context, builder: (context) => AlertDialog(
      content: ModalUpdateProductPage(product: product,category: category,),
    ),);
  }
}

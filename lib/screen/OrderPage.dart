import 'package:flutter/material.dart';
import 'package:serenity/common/color.dart';


class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    TabController _tabController=TabController(length: 4, vsync: this);
    return Container(
      color: CustomColor.customBackground,
      height: double.infinity,
      width: double.infinity,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top:16.0,left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text("Order",style: TextStyle(color: CustomColor.second,fontSize: 32,fontWeight: FontWeight.w600),)),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: 50,
              width: 120,
              child: ElevatedButton(
                onPressed: (){}, child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("Create",style: TextStyle(fontSize: 18),),Icon(Icons.add)],)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 20),
          child: Container(
            height: size.height*0.7,
            width: size.width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white,),
            child: Column(children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 550,
                  color: Colors.white,
                  child: TabBar(
                    controller: _tabController,
                    labelColor: CustomColor.second,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: CustomColor.second,
                    labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    tabs: [
                    Tab(text: "All orders",),
                    Tab(text: "Completed",),
                    Tab(text: "Continuing",),
                    Tab(text: "Cancelled",)
                  ]),
                ),
              ),
              Container(
                width: double.maxFinite,
                height: 100,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                  Text("hihi"),
                  Text("haha"),
                  Text("hoho"),
                  Text("hoho")
                ]),
              )
            ],)
          ),
        )
      ],));
  }
}
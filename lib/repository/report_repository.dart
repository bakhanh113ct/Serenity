import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

import '../model/Customer.dart';

class ReportRepository {
  final orders= FirebaseFirestore.instance.collection("Order");
  final customers= FirebaseFirestore.instance.collection("Customer");
  final reportTroubles= FirebaseFirestore.instance.collection("ReportTrouble");
  Future<String> quantityOrderInMonth()async{
    final dateStart=DateTime(DateTime.now().year,DateTime.now().month,1);
    final dateEnd=DateTime(DateTime.now().year,DateTime.now().month+1,1);
    int quantity=0;
    await orders.where("dateCreated",isGreaterThan: dateStart).where("dateCreated",isLessThan: dateEnd).get().then((value){
      value.docs.forEach((element) { 
        if(element.data()['status']!="Cancelled"){
          quantity+=1;
        }
      });
    });
    print(quantity.toString());
    return quantity.toString();
  }
  Future<String> quantityCustomerInMonth()async{
    final dateStart=DateTime(DateTime.now().year,DateTime.now().month,1);
    final dateEnd=DateTime(DateTime.now().year,DateTime.now().month+1,1);
    int quantity=0;
    await customers.where("dateCreated",isGreaterThan: dateStart).where("dateCreated",isLessThan: dateEnd).get().then((value){
      quantity=value.docs.length;
    });
    print(quantity.toString());
    return quantity.toString();
  }
  Future<String> totalOrderInMonth()async{
    final format = NumberFormat("###,###.###", "tr_TR");
    final dateStart=DateTime(DateTime.now().year,DateTime.now().month,1);
    final dateEnd=DateTime(DateTime.now().year,DateTime.now().month+1,1);
    double total=0;
    await orders.where("dateCreated",isGreaterThan: dateStart).where("dateCreated",isLessThan: dateEnd).get().then((value){
      value.docs.forEach((element) { 
        if(element.data()['status']=="Completed"){
          total+=double.tryParse(element.data()['price'].toString())!;
        }
      });
    });
    await reportTroubles.where("dateCreated",isGreaterThan: dateStart).where("dateCreated",isLessThan: dateEnd).get().then((value){
      value.docs.forEach((element) { 
        if(element.data()['isCompensate']==false&&element.data()['status']=="Paymented"){
          total-=double.tryParse(element.data()['totalMoney'].toString())!;
        }
        else if(element.data()['isCompensate']==true&&element.data()['status']=="Paymented"){
          total+=double.tryParse(element.data()['totalMoney'].toString())!;
        }
      });
    });
    print(total.toString());
    return format.format(total)+"đ";
  }
  Future<String> profitOrderInMonth()async{
    final format = NumberFormat("###,###.###", "tr_TR");
    final dateStart=DateTime(DateTime.now().year,DateTime.now().month,1);
    final dateEnd=DateTime(DateTime.now().year,DateTime.now().month+1,1);
    double total=0;
    await orders.where("dateCreated",isGreaterThan: dateStart).where("dateCreated",isLessThan: dateEnd).get().then((value){
      value.docs.forEach((element) { 
        if(element.data()['status']=="Completed"){
          total+=double.tryParse(element.data()['profit'].toString())!;
        }
      });   
    });
    await reportTroubles.where("dateCreated",isGreaterThan: dateStart).where("dateCreated",isLessThan: dateEnd).get().then((value){
      value.docs.forEach((element) { 
        if(element.data()['isCompensate']==false&&element.data()['status']=="Paymented"){
          total-=double.tryParse(element.data()['totalMoney'].toString())!;
        }
        else if(element.data()['isCompensate']==true&&element.data()['status']=="Paymented"){
          total+=double.tryParse(element.data()['totalMoney'].toString())!;
        }
      });
    });
    print(total.toString());
    if(total<0)
    total=0;
    return format.format(total)+'đ';
  }
  Future<int> customerInMonth()async{
    final dateStart=DateTime(DateTime.now().year,DateTime.now().month,1);
    final dateEnd=DateTime(DateTime.now().year,DateTime.now().month+1,1);
    int quantity=0;
    await customers.where("dateCreated",isGreaterThan: dateStart).where("dateCreated",isLessThan: dateEnd).get().then((value){
      quantity=value.docs.length;
    });
    print(quantity.toString());
    return quantity;
  }
  Future<List<ChartSampleData>> dataColumnChart()async{
    List<ChartSampleData> data=[];
    for(int i=1;i<=12;i++){
       final dateStart=DateTime(DateTime.now().year,i,1);
       final dateEnd=DateTime(DateTime.now().year,i+1,1);
       double total=0;
       await orders.where("dateCreated",isGreaterThan: dateStart).where("dateCreated",isLessThan: dateEnd).get().then((value){
          value.docs.forEach((element) {
              if(element.data()['status']=='Completed'){
                total+=double.tryParse(element.data()['price'].toString())!;
              }
           });
       });
       await reportTroubles.where("dateCreated",isGreaterThan: dateStart).where("dateCreated",isLessThan: dateEnd).get().then((value){
      value.docs.forEach((element) { 
        if(element.data()['isCompensate']==false&&element.data()['status']=="Paymented"){
          total-=double.tryParse(element.data()['totalMoney'].toString())!;
        }
        else if(element.data()['isCompensate']==true&&element.data()['status']=="Paymented"){
          total+=double.tryParse(element.data()['totalMoney'].toString())!;
        }
      });
    });
       data.add(ChartSampleData(x: i.toString(), y: total));
    }
    return data;
  }
  Future<List<ChartSampleData1>> dataPieChart()async{
    List<ChartSampleData1> data=[];
    List<Customer> listCustomer=[];
    double total=0;
    await customers.get().then((value) {
      value.docs.forEach((element) { 
        listCustomer.add(Customer.fromJson(element.data()));
        total+=double.tryParse(element.data()['purchased'].toString())!;
      });
    });
    listCustomer.sort((a, b) => double.tryParse(a.purchased.toString())!>double.tryParse(b.purchased.toString())!?0:1,);
    double temp=total;
    for(int i=0;i<4;i++){
      data.add(ChartSampleData1(x: listCustomer[i].name.toString(),y: double.tryParse(listCustomer[i].purchased.toString())!, text: (listCustomer[i].name.toString()+"\n"+double.tryParse(listCustomer[i].purchased.toString())!.toString()))); 
      temp-=double.tryParse(listCustomer[i].purchased.toString())!;
    }
    data.add(ChartSampleData1(x:"Other",y:temp,text:"Other \n" + (temp).toString()));
    return data;
  }
}
class ChartSampleData {
  ChartSampleData({required this.x, required this.y});
  final String x;
  final double y;
}
class ChartSampleData1 {
        ChartSampleData1({required this.x, required this.y, required this.text});
        final String x;
        final double y;  
        final String text;
    }
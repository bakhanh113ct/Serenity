import 'package:flutter/material.dart';
import 'package:serenity/widget/warehouseWidget/receipt_document_list.dart';
import '../common/color.dart';
import '../widget/WarehouseWidget/Warehouse_header.dart';
import '../widget/warehouseWidget/delivery_receipt_list.dart';
import '../widget/warehouseWidget/export_book_list.dart';
import '../widget/warehouseWidget/import_book_list.dart';

class WarehousePage extends StatefulWidget {
  const WarehousePage({Key? key}) : super(key: key);
  static const routeName = '/Warehouse';
  @override
  State<WarehousePage> createState() => _WarehousePageState();
}

class _WarehousePageState extends State<WarehousePage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const Expanded(flex: 1, child: WarehouseHeader(title: 'Warehouse')),
          Expanded(
            flex: 6,
            child: Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            padding: const EdgeInsets.all(20),
                            child: TabBar(
                                controller: _tabController,
                                labelColor: CustomColor.second,
                                unselectedLabelColor: Colors.grey,
                                indicatorColor: CustomColor.second,
                                labelStyle: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                                tabs: const [
                                  Tab(
                                    text: "Receipt Document",
                                  ),
                                  Tab(
                                    text: "Product Import",
                                  ),
                                  Tab(
                                    text: "Delivery Receipt",
                                  ),
                                  Tab(
                                    text: "Product Export",
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: TabBarView(
                          controller: _tabController,
                          children:  const [
                            ReceiptDocumentList(),
                            ImportBookList(),
                            DeliveryReceiptList(),
                            ExportBookList(),
                          ]),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'multiselect_bottom_sheet.dart';
import 'multiselect_bottom_sheet_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const  MyHomePage(title: 'multi select bottom sheet'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<MultiSelectBottomSheetModel> shippingStatusesItems = [
    MultiSelectBottomSheetModel(id: 0, name: "All", isSelected: true),
    MultiSelectBottomSheetModel(id: 1, name: "India", isSelected: false),
    MultiSelectBottomSheetModel(id: 2, name: "US", isSelected: false),
    MultiSelectBottomSheetModel(id: 3, name: "Canada", isSelected: false),
    MultiSelectBottomSheetModel(id: 4, name: "Africa", isSelected: false),
    MultiSelectBottomSheetModel(id: 5, name: "Germany", isSelected: false),
  ];

  @override
  Widget build(BuildContext context) {
    var width= MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(width*0.02),
          child: Column(
            children: [

               MultiSelectBottomSheet(
                  items: shippingStatusesItems,
                  width: width*0.96,
                  hint: "select country",
                ),

            ],
          ),
        ),
      ),
    );
  }
}

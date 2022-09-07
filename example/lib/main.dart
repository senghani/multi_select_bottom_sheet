import 'package:example/multiselect_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'multiselect_bottom_sheet_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'multi select bottom sheet',
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

  List<MultiSelectBottomSheetModel> selectCountryItem = [
    MultiSelectBottomSheetModel(id: 0, name: "All", isSelected: true),
    MultiSelectBottomSheetModel(id: 1, name: "India", isSelected: false),
    MultiSelectBottomSheetModel(id: 2, name: "US", isSelected: false),
    MultiSelectBottomSheetModel(id: 3, name: "Canada", isSelected: false),
    MultiSelectBottomSheetModel(id: 4, name: "Africa", isSelected: false),
    MultiSelectBottomSheetModel(id: 5, name: "Germany", isSelected: false),
  ];

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width= MediaQuery.of(context).size.width;
    var height= MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(width*0.02),
          child: Column(
            children: [

              //############################################
              // MultiSelectBottomSheet
              //############################################
              MultiSelectBottomSheet(
                  items:selectCountryItem ,// required for Item list
                  width: width*0.96,
                  bottomSheetHeight: height*0.7,// required for min/max height of bottomSheet
                  hint: "select country",
                  controller: controller,
                  searchTextFieldWidth:width*0.96,
                  searchIcon:const Icon(   // required for searchIcon
                     Icons.search,
                     color:Colors.black87,
                     size: 22
                 ),
                 selectTextStyle: const TextStyle(
                     color: Colors.white,
                     fontSize: 17
                 ),
                 unSelectTextStyle:const TextStyle(
                     color: Colors.black,
                     fontSize: 17
                 ),
               ),
            ],
          ),
        ),
      ),
    );
  }
}

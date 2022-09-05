import 'package:flutter/material.dart';
import 'package:multi_select_bottom_sheet/utils/colors.dart';
import 'package:multi_select_bottom_sheet/utils/text_style.dart';
import 'multiselect_bottom_sheet_model.dart';

class CustomMultiSelectBottomSheet extends StatefulWidget {

  final TextEditingController controller;
  final String? hint;
  List<MultiSelectBottomSheetModel> items=[];

  CustomMultiSelectBottomSheet({
    required this.controller,
    required this.items,
    this.hint,
    Key? key
  }) : super(key: key);

  @override
  _CustomMultiSelectBottomSheetState createState() => _CustomMultiSelectBottomSheetState();
}

class _CustomMultiSelectBottomSheetState extends State<CustomMultiSelectBottomSheet> {
  List<MultiSelectBottomSheetModel> filterList=[];
  List<MultiSelectBottomSheetModel> defaultList=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    defaultList.clear();
    filterList.clear();
    for(var item in widget.items)
    {
      defaultList.add( MultiSelectBottomSheetModel(id: item.id, name: item.name, isSelected: item.isSelected));
      filterList.add( MultiSelectBottomSheetModel(id: item.id, name: item.name, isSelected: item.isSelected));
    }

  }

  @override
  Widget build(BuildContext context) {

    var width= MediaQuery.of(context).size.width;
    var height= MediaQuery.of(context).size.height;

    return SizedBox(
      height:height*0.7,
      width: 100,
      child: Column(
        children: [

          SizedBox(height: height*0.01),

          Container(
            width: width*0.96,
            decoration: BoxDecoration(
                border: Border.all(
                    color: borderColor
                ),
                color: Colors.red
            ),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [

                TextFormField(
                  controller: widget.controller,
                  maxLines: 1,
                  style:textFieldInputTextStyle,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                          Icons.search,
                          color:Colors.black87,
                          size: 22
                      ),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      isDense: true,
                      filled: true,
                      fillColor: whiteColor,
                      hintText: "search here..",
                      contentPadding: const EdgeInsets.fromLTRB(10, 12, 0, 0),
                      hintStyle: textFieldInputTextStyle
                  ),
                  onChanged:(values) {
                    setState(() {
                      filterList = widget.items.where((element) => element.name.toLowerCase().contains(values.toLowerCase())).toList();
                    });
                  },
                  validator: (values) {
                  },
                  // keyboardType: type,
                  cursorColor: cursorColor,
                  textInputAction: TextInputAction.next,
                  focusNode: FocusNode(),
                ),

                widget.controller.text.isEmpty ? Container() :
                InkWell(
                  onTap: (){
                    setState((){
                      widget.controller.text="";
                      filterList = widget.items;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: width*0.02
                    ),
                    child: const Icon(
                      Icons.close,
                      color: iconColor,
                      size: 20,
                    ),
                  ),
                )
              ],
            ),
          ),

          SizedBox(height: height*0.01),

          const Divider(thickness: 1,height: 1,color: dividerColor),

          SizedBox(height:height*0.01),

          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: width,
                padding: EdgeInsets.symmetric(horizontal:width*0.02
                ),
                child: Wrap(
                  spacing: width*0.01,
                  runSpacing: width*0.01
                  ,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  alignment: WrapAlignment.start,
                  children: filterList.map((e) {

                    return GestureDetector(
                      onTap: ()
                      {

                        setState((){

                          e.isSelected = !e.isSelected;

                          if(e.id == widget.items[0].id)
                          {
                            for(var item in filterList.where((element) => element.id != e.id))
                            {
                              item.isSelected = false;
                              defaultList.where((element) => element.id==item.id).first.isSelected = false;
                            }
                          }else{
                            if(filterList[0].id != widget.items[0].id) {
                              filterList[0].isSelected = false;
                            }
                            defaultList.where((element) => element.id==filterList[0].id).first.isSelected = false;
                          }
                          defaultList.where((element) => element.id==e.id).first.isSelected = e.isSelected;
                        });
                        // setState((){
                        //   e.isSelected = !e.isSelected;
                        //   defaultList.where((element) => element.id==e.id).first.isSelected = e.isSelected;
                        // });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: width*0.02, vertical: width*0.01),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: e.isSelected ? chipsSelectedBackgroundColor : chipsUnselectedBackgroundColor,
                          border: Border.all(color:  chipsSelectedBackgroundColor),
                        ),
                        child: Text(
                          e.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: e.isSelected ? contentTextStyle2 : contentTextStyle,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),

          SizedBox(height:height*0.01),

          const Divider(thickness: 1,height: 1,color: dividerColor),

          Container(
            width: width*100,
            decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: borderColor
                    )
                )
            ),
            padding:  EdgeInsets.symmetric(vertical: height*0.01
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                defaultList.where((element) => element.isSelected).isEmpty ? Container() :
                GestureDetector(
                  onTap: (){
                    setState(()
                    {
                      for(var item in defaultList)
                      {
                        item.isSelected = false;
                      }
                      filterList = defaultList;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal:width*0.02,
                        vertical: height*0.01),
                    child: Text(
                      "Clear all",
                      style: contentTextStyle,
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: width*0.02,vertical: height*0.01),
                        child: Text(
                          "cancel",
                          style: contentTextStyle,
                        ),
                      ),
                    ),

                    SizedBox(width: width*0.02,),

                    GestureDetector(
                      onTap:(){
                        setState(()
                        {
                          widget.items.clear();
                          widget.items.addAll(defaultList);
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal:width*0.02,vertical: height*0.01),
                        child: Text(
                          "Conform",
                          style: contentTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

        ],
      ),
    );

  }
}

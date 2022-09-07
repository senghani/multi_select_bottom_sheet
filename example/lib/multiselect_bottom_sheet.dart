import 'package:example/multiselect_bottom_sheet_model.dart';
import 'package:example/utils/colors.dart';
import 'package:flutter/material.dart';

class MultiSelectBottomSheet extends StatefulWidget {
  final List<MultiSelectBottomSheetModel> items;
  final double width;
  final double bottomSheetHeight;
  final double? searchTextFieldWidth;
  final String? hint;
  final String? searchHint;
  final String cancelText;
  final String confirmText;
  final String clearAll;
  final Color  hintColor;
  final Color textColor;
  final Color borderColor;
  final Color selectedBackgroundColor;
  final Color unSelectedBackgroundColor;
  final Color suggestionListBorderColor;
  final TextEditingController controller;
  final TextStyle? searchHintTextStyle;
  final TextStyle? selectTextStyle;
  final TextStyle? unSelectTextStyle;
  final Icon searchIcon;

  const MultiSelectBottomSheet({
    required this.items,
    required this.width,
    required this.hint,
    required this.bottomSheetHeight,
    required this.searchIcon,
    required this.controller,
    this.searchTextFieldWidth,
    this.searchHint="search here..",
    this.cancelText='cancel',
    this.confirmText='confirm',
    this.clearAll='clear All',
    this.hintColor=Colors.black,
    this.textColor=Colors.black54,
    this.borderColor=Colors.black12,
    this.selectedBackgroundColor=Colors.lightBlueAccent,
    this.unSelectedBackgroundColor=Colors.white,
    this.suggestionListBorderColor=Colors.lightBlueAccent,
    this.searchHintTextStyle,
    this.selectTextStyle,
    this.unSelectTextStyle,
    Key? key,
  }) : super(key: key);

  @override
  _MultiSelectBottomSheetState createState() => _MultiSelectBottomSheetState();
}

class _MultiSelectBottomSheetState extends State<MultiSelectBottomSheet> {

  TextEditingController controller = TextEditingController();
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
    return GestureDetector(
      onTap: (){
        showModalBottomSheet(
          isScrollControlled: true,
          isDismissible: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          context: context,
          builder: (context){
            return StatefulBuilder(
              builder: (BuildContext context,StateSetter setState) {
                return SizedBox(
                  height:widget.bottomSheetHeight,
                  width: width,
                  child: Column(
                    children: [

                      SizedBox(height: height*0.01),

                      Container(
                        width: widget.searchTextFieldWidth,
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
                              style:const TextStyle(
                                  color: lightTextColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17
                              ),
                              decoration: InputDecoration(
                                  prefixIcon: widget.searchIcon,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  isDense: true,
                                  filled: true,
                                  fillColor: whiteColor,
                                  hintText: widget.searchHint,
                                  contentPadding: const EdgeInsets.fromLTRB(10, 12, 0, 0),
                                  hintStyle: widget.searchHintTextStyle
                              ),
                              onChanged:(values) {
                                setState(() {
                                  filterList = widget.items.where((element) => element.name.toLowerCase().contains(values.toLowerCase())).toList();
                                });
                              },
                              cursorColor: Colors.black,
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
                            padding: EdgeInsets.symmetric(horizontal:width*0.02),
                            child: Wrap(
                              spacing: width*0.01,
                              runSpacing: width*0.01,
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
                                    },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: width*0.02, vertical: width*0.01),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: e.isSelected ? widget.selectedBackgroundColor : widget.unSelectedBackgroundColor,
                                      border: Border.all(color:  widget.suggestionListBorderColor),
                                    ),
                                    child: Text(
                                      e.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: e.isSelected ? widget.selectTextStyle : widget.unSelectTextStyle,
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
                                  widget.clearAll,
                                  style: const TextStyle(
                                      color: lightTextColor,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 17
                                  ),
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
                                      widget.cancelText,
                                      style: const TextStyle(
                                          color: lightTextColor,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 17
                                      ),
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
                                      widget.confirmText,
                                      style: const TextStyle(
                                          color: lightTextColor,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 17
                                      ),
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
            );
          },
        ).then((value){
          setState((){});
        });
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: widget.borderColor,
            ),
            color: whiteColor
        ),
        padding: EdgeInsets.symmetric(horizontal: 2,vertical: widget.items.where((element) => element.isSelected).isEmpty? height*0.02 : height*0.01),
        width: widget.width,
        alignment: Alignment.centerLeft,
        child: Column(
          children: [

            widget.items.where((element) => element.isSelected).isEmpty?
            Text(
              "${widget.hint}",
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: widget.hintColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 17
              ),
            ) :
            Wrap(
              spacing: width*0.01,
              runSpacing: width*0.01,
              children: widget.items.where((element) => element.isSelected).map((e) {
                String separator = e.id == widget.items.where((element) => element.isSelected).last.id? "":", ";
                return Text(
                  "${e.name}$separator",
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: widget.textColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 17
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:multi_select_bottom_sheet/utils/colors.dart';
import 'package:multi_select_bottom_sheet/utils/text_style.dart';
import 'custom_multi_select_bottom_sheet.dart';
import 'multiselect_bottom_sheet_model.dart';

class MultiSelectBottomSheet extends StatefulWidget {
  final List<MultiSelectBottomSheetModel> items;
  final double width;
  final String? hint;

  const MultiSelectBottomSheet({
    required this.items,
    required this.width,
    required this.hint,
    Key? key,
  }) : super(key: key);

  @override
  _MultiSelectBottomSheetState createState() => _MultiSelectBottomSheetState();
}

class _MultiSelectBottomSheetState extends State<MultiSelectBottomSheet> {

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
            return CustomMultiSelectBottomSheet(controller: controller, items: widget.items);
          },
        ).then((value){
          setState((){});
        });
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: borderColor
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
              style: textFieldInputTextStyle,
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
                  style: textFieldInputTextStyle,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

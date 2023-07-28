import 'package:bms_salesco/app/data/DropDownValue.dart';
import 'package:bms_salesco/widgets/CheckBox/app_check_box.dart';
import 'package:flutter/widgets.dart';

class MultiCheckBox extends StatelessWidget {
  final List<MultiCheckBoxModel> list;
  final double width;
  final bool isHorizontal, canScroll;
  final void Function(int index, bool val)? onChanged;
  const MultiCheckBox({super.key, required this.list, this.width = 0, this.isHorizontal = true, this.onChanged, this.canScroll = false});

  @override
  Widget build(BuildContext context) {
    return isHorizontal
        ? Wrap(
            runSpacing: 10,
            spacing: 10,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: buildUI(),
          )
        : canScroll
            ? ListView(
                children: buildUI(),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: buildUI(),
              );
  }

  List<Widget> buildUI() {
    return List.generate(
      list.length,
      (index) => AppCheckBox(
        title: list[index].val?.value ?? "",
        value: list[index].isSelected ?? false,
        width: width,
        onChanged: (val) {
          if (onChanged != null) {
            onChanged!(index, val);
          }
        },
      ),
    ).toList();
  }
}

class MultiCheckBoxModel {
  DropDownValue? val;
  bool? isSelected;
  MultiCheckBoxModel(this.val, this.isSelected);
}

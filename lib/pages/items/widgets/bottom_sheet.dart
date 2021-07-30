import 'package:flutter/material.dart';
import 'package:password_manager/constants/variables.dart';
import 'package:password_manager/pages/items/widgets/bottom_sheet_content.dart';

Future<dynamic> customBottomSheet(context, item, itemType) {
  return showModalBottomSheet(
    enableDrag: true,
    shape: kBottomSheetShape,
    context: context,
    builder: (context) => BottomSheetCentent(item: item, itemType: itemType),
  );
}

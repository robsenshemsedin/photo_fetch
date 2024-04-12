import 'package:flutter/material.dart';
import 'package:photo_fetch/enums/enums.dart';
import 'package:photo_fetch/resources/app_sizes.dart';

class EditingButton extends StatelessWidget {
  final Function? callback;
  final EditButtonType buttonType;
  const EditingButton(
      {super.key, required this.callback, required this.buttonType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: PaddingSizes.sm),
      child: ElevatedButton(
        onPressed: callback == null
            ? null
            : () {
                callback!();
              },
        child: Text(buttonType.name.toUpperCase()),
      ),
    );
  }
}

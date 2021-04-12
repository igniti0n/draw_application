import 'package:flutter/material.dart';

class QuickSettings extends StatelessWidget {
  const QuickSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _deviceSize = MediaQuery.of(context).size;

    return Container(
      constraints: BoxConstraints(
        maxHeight: _deviceSize.height / 4, maxWidth: _deviceSize.width,
        //maxHeight: 300,
      ),
      color: Colors.blue,
      child: null,
    );
  }
}

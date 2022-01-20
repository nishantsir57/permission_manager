import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Granted extends StatelessWidget
{
  String permissionType;
  Granted(this.permissionType);

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(permissionType),
        ),
      );
  }

}
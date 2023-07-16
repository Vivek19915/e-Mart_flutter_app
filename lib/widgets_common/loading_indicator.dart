import 'package:flutter/material.dart';

Widget loadingIndicator(){
  return CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(Colors.red),
  );
}
import 'dart:io';

import 'package:flutter/material.dart';

class AppUtils {

  static PreferredSizeWidget appBar(){
    return AppBar(
        title: const Text('Wireless Build tool'),
      );
  }

static showLoading(BuildContext context,String message){
  showDialog(context: context, builder: (context) {
    return AlertDialog(
      title: Row(
        children: [
          Text(message),
          const Expanded(child: SizedBox()),
          Image.asset('assets/images/diagram.gif',width: 50,height: 50,)
        ],
      ),
    ) ;
  },);
}

static showMessage(BuildContext context,String message){
  showDialog(context: context, builder: (context) {
    return AlertDialog(
      content: Row(
        children: [
          Expanded(child: Text(message,textAlign:TextAlign.center,)),
          //const Expanded(child: SizedBox()),
          //Image.asset('assets/images/diagram.gif',width: 50,height: 50,)
        ],
      ),
    ) ;
  },);
}

static hideLoading(BuildContext context){
  Navigator.pop(context);
}

}

  Future printIps(String ip) async {
    for (var interface in await NetworkInterface.list()) {
      for (var addr in interface.addresses) {
         ip = addr.address;
        print('My IP : ${addr.address}');
      }
    }
  }
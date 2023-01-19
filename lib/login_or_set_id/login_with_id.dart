import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:wireless_build/data_model/data_class.dart';
import 'package:wireless_build/home_screen/home_screen.dart';

import '../firebase_manager/firebase_manager.dart';
import '../utils/app_utils.dart';

class LogingScreen extends StatelessWidget {
  LogingScreen({super.key});

  String? ip = '';

  /*Future printIps() async {
    for (var interface in await NetworkInterface.list()) {
      for (var addr in interface.addresses) {
         ip = addr.address;
        print('My IP : ${addr.address}');
      }
    }
  }*/
  TextEditingController idController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppUtils.appBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  validator: (value) {},
                  style: const TextStyle(fontSize: 30),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.account_tree_outlined),
                      border: OutlineInputBorder(),
                      hintText: 'Login With Your ID',
                      hintStyle: TextStyle(color: Colors.grey),
                      labelText: 'ID',
                      labelStyle: TextStyle(color: Colors.black)),
                  controller: idController,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            AppUtils.showLoading(context, 'Loading . . . .');
            await getAllDocument();
            //print(IdList);
            if (IdList.contains(idController.text)) {
              AppUtils.hideLoading(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(idController.text),
                  ));
            } else {
              AppUtils.hideLoading(context);
              AppUtils.showMessage(context,'This ID is not Exist , please create one and LogIn');
              //print('This Id is not  Exist');
        
              //AppUtils.hideLoading(context);
             
            }
            IdList.clear();
            //AppUtils.hideLoading(context);
          },
          label: const Text('LogIn'),
          icon: const Icon(Icons.arrow_forward_ios)),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}

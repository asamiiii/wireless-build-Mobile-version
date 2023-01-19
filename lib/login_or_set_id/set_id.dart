import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:wireless_build/data_model/data_class.dart';
import 'package:wireless_build/login_or_set_id/login_with_id.dart';

import '../firebase_manager/firebase_manager.dart';
import '../utils/app_utils.dart';

class SetIdScreen extends StatefulWidget {
  SetIdScreen({super.key});

  @override
  State<SetIdScreen> createState() => _SetIdScreenState();
}

class _SetIdScreenState extends State<SetIdScreen> {
  String? ip = '';

    Future printIps() async {
    for (var interface in await NetworkInterface.list()) {
      for (var addr in interface.addresses) {
         ip = addr.address;
        print('My IP : ${addr.address}');
      }
    }
  }

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
                      hintText: 'Creat Your ID',
                      hintStyle: TextStyle(color: Colors.grey),
                      labelText: 'ID',
                      labelStyle: TextStyle(color: Colors.black)),
                  controller: idController,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LogingScreen(),));
                    },
                    child: const Text(
                      'I have an ID',
                      style: TextStyle(color: Colors.blueAccent),
                    ))
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            //AppUtils.showLoading(context, 'Loading . . . .');
            await getAllDocument();
            //print(IdList);
            if (IdList.contains(idController.text)) {
             // print('This Id is exist');
              AppUtils.showMessage(context, 'This Id is exist');
            } else {
              AppUtils.showLoading(context, 'Loading . . . ');
                await printIps();
                await addTaskToFirebase(
                    User(userId: idController.text, ipAddress: ip));
                //print('This Id is not  Exist');
                setState(() {});
               AppUtils.hideLoading(context);
               AppUtils.showMessage(context, 'Your Id is Created Successfully .. Please Log in With ID and Save It :> ');
               AppUtils.hideLoading(context);
               Navigator.push(context, MaterialPageRoute(builder: (context) => LogingScreen(),));
            }
            IdList.clear();
            //AppUtils.hideLoading(context);
          },
          label: const Text('Set ID'),
          icon: const Icon(Icons.arrow_forward_ios)),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}

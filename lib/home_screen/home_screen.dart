import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wireless_build/data_model/data_class.dart';
import 'package:wireless_build/firebase_manager/firebase_manager.dart';

import '../utils/app_utils.dart';

class HomeScreen extends StatefulWidget {
  String userId = '';
  HomeScreen(this.userId);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String ip = '';

  Future printIps() async {
    for (var interface in await NetworkInterface.list()) {
      for (var addr in interface.addresses) {
        ip = addr.address;
        print('My IP : ${addr.address}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppUtils.appBar(),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ip.isNotEmpty
                ? Container(
                  alignment: Alignment.center,
                  color: Colors.greenAccent,
                  width: 200,
                  height: 100,
                    child: Text(
                    'Your IP is : $ip',
                    textAlign: TextAlign.center,
                    style:const TextStyle(fontSize: 20,fontWeight:FontWeight.bold),
                  ))
                : const Text('')
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          AppUtils.showLoading(context, 'Loading ....');
          await printIps();
          await addTaskToFirebase(User(userId: widget.userId, ipAddress: ip));
          // ignore: use_build_context_synchronously
          AppUtils.hideLoading(context);
          setState(() {});
        },
        label: const Text('Connect to My PC'),
        icon: const Icon(Icons.wifi),
        backgroundColor: ip.isEmpty ? Colors.blueGrey : Colors.greenAccent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

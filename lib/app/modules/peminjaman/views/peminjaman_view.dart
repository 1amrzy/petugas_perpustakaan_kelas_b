import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/peminjaman_controller.dart';

class PeminjamanView extends GetView<PeminjamanController> {
  const PeminjamanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PeminjamanView'),
        centerTitle: true,
      ),
      body: controller.obx((state) => ListView.separated(
        itemCount: state!.length,
        itemBuilder: (context, index){
          return ListTile(
            title: Text("${state[index].book}"),
            subtitle: Text("Penulis ${state[index].status}"),
          );
        },
        separatorBuilder: (context, index){
          return Divider();
        },
      ))
    );
  }
}

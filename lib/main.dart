import 'package:blog_explorer/views/detailed_view.dart';
import 'package:blog_explorer/views/home_page.dart';
import 'package:flutter/material.dart';

import 'controller/controller.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final postController = Get.put(PostController()); // controller is initialised

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      debugShowCheckedModeBanner: false,

      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/blogDetail': (context) => Detailedview(),
      },
    );
  }
}

 
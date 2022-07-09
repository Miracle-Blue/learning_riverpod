import 'package:flutter/material.dart';
import 'package:learning_riverpod/domain/entities/contact.dart';
import 'package:learning_riverpod/ui/pages/detail/detail_notifier.dart';
import 'package:learning_riverpod/ui/pages/detail/detail_page.dart';

import 'pages/home/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        HomePage.id: (context) => const HomePage(),
        DetailPage.id: (context) => const DetailPage(),
      },
    );
  }
}

class RouteArgs {
  final DetailState detailState;
  final Contact? contact;

  const RouteArgs({
    required this.detailState,
    required this.contact,
  });
}

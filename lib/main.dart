import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nchat/common/routes/pages.dart';
import 'package:nchat/common/services/storage.dart';
import 'package:nchat/common/store/config.dart';
import 'package:nchat/common/store/user.dart';
import 'package:nchat/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize local storage ConfigStore
  await Get.putAsync<StorageService>(() => StorageService().init());
  Get.put<ConfigStore>(ConfigStore());
  Get.put<UserStore>(UserStore());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (BuildContext context, Widget? child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'nchat',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: AppPages.Initial,
        getPages: AppPages.routes,
      ),
    );
  }
}


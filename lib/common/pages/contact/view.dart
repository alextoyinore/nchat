import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nchat/common/pages/contact/widgets/contact_list.dart';
import 'package:nchat/common/styles/color.dart';
import 'package:nchat/common/widgets/appbar.dart';

import 'controller.dart';

class ContactPage extends GetView<ContactController> {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {

    AppBar buildAppBar(){
      return transparentAppBar(
        title: Text(
          'Contact',
          style: TextStyle(
            color: AppColor.primaryBG,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        )
      );
    }

    return Scaffold(
      appBar: buildAppBar(),
      body: const ContactList(),
    );
  }
}

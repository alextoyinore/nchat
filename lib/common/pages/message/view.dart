import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nchat/common/pages/message/widget/message_list.dart';
import '../../styles/color.dart';
import '../../widgets/appbar.dart';
import 'controller.dart';

class MessagePage extends GetView<MessageController> {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {

    AppBar buildAppBar(){
      return transparentAppBar(
          title: Text(
            'Messages',
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
      body: const Center(
        child: MessageList(),
      ),
    );
  }
}

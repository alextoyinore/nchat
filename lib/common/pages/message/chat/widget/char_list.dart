import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nchat/common/pages/message/chat/controller.dart';
import 'package:nchat/common/pages/message/chat/widget/chat_left_item.dart';
import 'package:nchat/common/pages/message/chat/widget/chat_right_item.dart';
import 'package:nchat/common/styles/color.dart';

class ChatList extends GetView<ChatController> {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      padding: EdgeInsets.only(bottom: 50.h),
      decoration: BoxDecoration(
        color: AppColor.primaryElement.withOpacity(.01),
      ),
      child: CustomScrollView(
        reverse: true,
        controller: controller.msgScrollControl,
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: 0.w, horizontal: 0.w,
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    var item = controller.state.msgContentList[index];
                    if (controller.token==item.uid){
                      return ChatRightItem(item);
                    }else {
                      return ChatLeftItem(item);
                    }
                  },
                  childCount: controller.state.msgContentList.length
              ),

            ),
          ),
        ],
      ),
    ),
    );
  }
}

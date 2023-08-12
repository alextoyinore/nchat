import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nchat/common/entities/msg.dart';
import 'package:nchat/common/pages/message/controller.dart';
import 'package:nchat/common/store/user.dart';
import 'package:nchat/common/styles/color.dart';
import 'package:nchat/common/utils/date.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MessageList extends GetView<MessageController> {
  const MessageList({super.key});

  Widget messageListItem(QueryDocumentSnapshot<Msg> item) {
    return InkWell(
      onTap: (){
        controller.toChatFromMessage(item);
      },
      child: Container(
        // margin: EdgeInsets.zero,
        margin: EdgeInsets.symmetric(
          vertical: 0.w, horizontal: 15.w,
        ),
        padding: EdgeInsets.symmetric(
          vertical: 10.w, horizontal: 0.w,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColor.primaryBlack_20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CachedNetworkImage(
            imageUrl: item.data().from_uid==controller.token ?
            item.data().to_avatar! : item.data().from_avatar!,
              imageBuilder: (context, imageProvider) => Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.w),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              errorWidget: (context, url, error)=>Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.w),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/no_image.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              width: 200.w,
              height: 40.w,
              margin: EdgeInsets.only(left: 10.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.data().from_uid==controller.token ?
                  item.data().to_name! : item.data().from_name!,
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'Avenir',
                      fontSize: 14.w,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(item.data().last_msg ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'Avenir',
                      fontSize: 11.w,
                      color: AppColor.primaryBlack_80,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 80.w,
              height: 40.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(duTimeLineFormat(
                      (item.data().last_time as Timestamp).toDate(),
                  ),
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      color: AppColor.primaryBlack_80,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.check,
                      color: AppColor.primaryElement.withOpacity(.5),
                      size: 15.w,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SmartRefresher(
        controller: controller.refreshController,
        enablePullDown: true,
        enablePullUp: true,
        onLoading: controller.onLoading,
        onRefresh: controller.onRefresh,
        header: const WaterDropHeader(),
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(
                  horizontal: 0.w,
                  vertical: 0.w,
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, index){
                      var item = controller.state.msgList[index];
                      return messageListItem(item);
                    },
                    childCount: controller.state.msgList.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

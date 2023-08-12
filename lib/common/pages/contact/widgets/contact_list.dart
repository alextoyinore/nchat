import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nchat/common/entities/entities.dart';
import 'package:nchat/common/pages/contact/controller.dart';
import 'package:nchat/common/styles/color.dart';

class ContactList extends GetView<ContactController> {
  const ContactList({super.key});

  Widget BuildListItem(UserData item) {
    return InkWell(
      splashColor: AppColor.primaryPurple,
      onTap: () {
        if (item.id != null) {
          controller.toChat(item);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 15.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 0.w, left: 0.w, right: 10.w),
              child: SizedBox(
                width: 40.w,
                height: 40.w,
                child: CachedNetworkImage(
                  imageUrl: "${item.photourl}",
                  imageBuilder: (context, imageProvider) => Container(
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
              ),
            ),
            Container(
              height: 38.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name ?? '',
                    style: TextStyle(
                      fontFamily: 'Avenir',
                      fontWeight: FontWeight.w600,
                      fontSize: 16.w,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: 0.w,
              horizontal: 0.w,
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  var item = controller.state.contactList[index];
                  return BuildListItem(item);
                },
                childCount: controller.state.contactList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

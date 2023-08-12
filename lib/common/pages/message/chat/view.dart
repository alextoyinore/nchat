import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nchat/common/pages/message/chat/widget/char_list.dart';
import 'package:nchat/common/styles/color.dart';
import 'package:nchat/common/values/strings.dart';
import 'package:nchat/common/widgets/appbar.dart';

import 'controller.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({super.key});

  buildAppBar() {
    return transparentAppBar(
        title: Container(
      padding: EdgeInsets.only(top: 0.w, bottom: 0.w, right: 0.w),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(top: 0.w, bottom: 0.w, right: 0.w),
            child: InkWell(
              child: SizedBox(
                width: 35.w,
                height: 35.w,
                child: CachedNetworkImage(
                  imageUrl: controller.state.to_avatar.value,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.w),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  controller.state.to_name.value,
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Obx(
                  () => Text(
                    controller.state.to_location.value,
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'Avenir',
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }

  void showPicker(context) {
    showModalBottomSheet(
        backgroundColor: AppColor.primaryElement,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        )),
        clipBehavior: Clip.antiAlias,
        context: context,
        builder: (BuildContext buildContext) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.photo_library,
                    color: AppColor.primaryBG,
                  ),
                  title: const Text(
                    'Gallery',
                    style: TextStyle(
                      color: AppColor.primaryBG,
                    ),
                  ),
                  onTap: () {
                    controller.imageFromGallery();
                    Get.back();
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.photo_camera,
                    color: AppColor.primaryBG,
                  ),
                  title: const Text(
                    'Camera',
                    style: TextStyle(
                      color: AppColor.primaryBG,
                    ),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(
                    Icons.folder,
                    color: AppColor.primaryBG,
                  ),
                  title: const Text(
                    'Files',
                    style: TextStyle(
                      color: AppColor.primaryBG,
                    ),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SafeArea(
        child: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: Stack(
            children: [
              const ChatList(),
              Positioned(
                bottom: 0.h,
                height: 50.h,
                child: Container(
                  width: 360.w,
                  height: 50.w,
                  color: AppColor.primaryBG,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 52.w,
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: 3,
                            controller: controller.textController,
                            autofocus: false,
                            focusNode: controller.contentNode,
                            decoration: InputDecoration(
                                hintText: AppString.chatTextFieldHint,
                                fillColor:
                                    AppColor.primaryElement.withOpacity(.1),
                                filled: true,
                                contentPadding: const EdgeInsets.only(
                                  left: 10,
                                  top: 10,
                                ),
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  width: 1.w,
                                  color: AppColor.primaryElement,
                                )),
                                suffixIcon: InkWell(
                                  onTap: () {
                                    showPicker(context);
                                  },
                                  child: SizedBox(
                                    width: 50.w,
                                    height: 50.w,
                                    child: Transform.rotate(
                                      angle: 0.w,
                                      child: const Icon(
                                        Icons.attach_file,
                                        size: 35,
                                        color: AppColor.primaryElement,
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          controller.sendMessage();
                        },
                        child: Container(
                          width: 55.w,
                          height: 55.w,
                          decoration: const BoxDecoration(
                              color: AppColor.primaryElement),
                          child: Transform.rotate(
                            angle: 0.w,
                            child: Icon(
                              Icons.send,
                              color: AppColor.primaryBG,
                              size: 25.w,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

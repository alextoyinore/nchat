import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nchat/common/entities/entities.dart';
import 'package:nchat/common/styles/color.dart';

import '../../../../utils/date.dart';

Widget ChatRightItem(MsgContent item){
  return Container(
    margin: EdgeInsets.only(
        right: 10.w,
        top: 10.w,
        bottom: 10.w,
        left: 10.w,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 230.w,
            minHeight: 30.w,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 10.w,
            ),
            decoration: BoxDecoration(
              color: AppColor.primaryElement,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColor.primaryBlack.withOpacity(.1),
                  blurRadius: 1.0,
                  offset: const Offset(0, 1),
                ),
              ]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                item.type=='text' ?
              Text('${item.content}',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: 14.w,
                  height: 1.25.w,
                  color: AppColor.primaryBG,
                ),
              )
              :ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 100.w,
                  ),
                child: GestureDetector(
                  onTap: (){},
                  child: CachedNetworkImage(
                    imageUrl: '${item.content}',
                  ),
                ),
              ),
              Text(
                duTimeLineFormat((item.addtime as Timestamp).toDate()),
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: 11.w,
                  color: AppColor.primaryPurple.withOpacity(.5),
                ),
              ),
            ],
          ),
          ),
        ),
      ],
    ),

  );
}


import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:nchat/common/pages/contact/state.dart';
import 'package:nchat/common/store/user.dart';

import '../../entities/msg.dart';
import '../../entities/user.dart';

class ContactController extends GetxController{
  final state = ContactState();
  ContactController();

  final db = FirebaseFirestore.instance;
  final token = UserStore.to.token;

  toChat(UserData toUserData) async {
    var fromMessages = await db.collection('message').withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg, options) => msg.toFirestore())
        .where('from_uid', isEqualTo: token)
        .where('to_uid', isEqualTo: toUserData.id).get();

    var toMessages = await db.collection('message').withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg, options) => msg.toFirestore())
        .where('from_uid', isEqualTo: toUserData.id)
        .where('to_uid', isEqualTo: token).get();

    if (fromMessages.docs.isEmpty && toMessages.docs.isEmpty){
      String profile = await UserStore.to.getProfile();
      UserLoginResponseEntity fromUserData = UserLoginResponseEntity.fromJson(jsonDecode(profile));
      var msgData = Msg(
        from_uid: fromUserData.accessToken,
        to_uid: toUserData.id, from_name: fromUserData.displayName,
        to_name: toUserData.name,
        from_avatar: fromUserData.photoUrl,
        to_avatar: toUserData.photourl,
        last_msg: '',
        last_time: Timestamp.now(),
        msg_num: 0,
      );

      db.collection('message').withConverter(
          fromFirestore: Msg.fromFirestore,
          toFirestore: (Msg msg, options) => msg.toFirestore())
          .add(msgData).then((value) {
          Get.toNamed('/chat', parameters: {
            'doc_id': value.id,
            'to_uid': toUserData.id ?? '',
            'to_name': toUserData.name ?? '',
            'to_avatar': toUserData.photourl ?? ''
          });
      });
    }
    else{
      if(fromMessages.docs.isNotEmpty){
        Get.toNamed('/chat', parameters: {
          'doc_id': fromMessages.docs.first.id,
          'to_uid': toUserData.id ?? '',
          'to_name': toUserData.name ?? '',
          'to_avatar': toUserData.photourl ?? ''
        });
      }

      if(toMessages.docs.isNotEmpty){
        Get.toNamed('/chat', parameters: {
          'doc_id': toMessages.docs.first.id,
          'to_uid': toUserData.id ?? '',
          'to_name': toUserData.name ?? '',
          'to_avatar': toUserData.photourl ?? ''
        });
      }
    }

  }

  asyncLoadAllData() async{
    // .where('id', isNotEqualTo:token) us this snippet in userBase to
    // ensure you are not returning the user back to them in their contact list
    var usersBase = await db.collection('users')
        .where('id', isNotEqualTo: token)
        .withConverter(
        fromFirestore: UserData.fromFirestore,
        toFirestore: (UserData userdata, options)=>userdata.toFirestore())
        .get();
    for(var doc in usersBase.docs){
      state.contactList.add(doc.data());
      print(doc.toString());
    }
  }

  @override
  void onReady(){
    super.onReady();
    asyncLoadAllData();
  }


}

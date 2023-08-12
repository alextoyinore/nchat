
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:nchat/common/entities/entities.dart';
import 'package:nchat/common/widgets/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../store/user.dart';
import 'index.dart';
import 'package:location/location.dart';
import 'package:nchat/common/utils/http.dart';

class MessageController extends GetxController{
  MessageController();
  final MessageState state = MessageState();
  final token  = UserStore.to.token;
  final db = FirebaseFirestore.instance;
  var listener;

  RefreshController refreshController = RefreshController(initialRefresh: true);

  @override
  void onReady(){
    super.onReady();
    getMyLocation();
  }

  asyncLoadAllData() async{
    var fromMessage = await db.collection('message').withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg, options) => msg.toFirestore())
    .where('from_uid', isEqualTo: token).get();

    var toMessage = await db.collection('message').withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg, options) => msg.toFirestore())
        .where('to_uid', isEqualTo: token).get();

    state.msgList.clear();

    if(fromMessage.docs.isNotEmpty){
      state.msgList.assignAll(fromMessage.docs);
    }

    if(toMessage.docs.isNotEmpty){
      state.msgList.assignAll(toMessage.docs);
    }
  }

  void toChatFromMessage(QueryDocumentSnapshot<Msg> item){
    var toUid = '';
    var toName = '';
    var toAvatar = '';
    if(item.data().from_uid==token){
      toUid = item.data().to_uid ?? '';
      toName = item.data().to_name ?? '';
      toAvatar = item.data().to_avatar ?? '';
    }else{
      toUid = item.data().from_uid ?? '';
      toName = item.data().from_name ?? '';
      toAvatar = item.data().from_avatar ?? '';
    }
    Get.toNamed('/chat', parameters: {
      'doc_id':item.id,
      'to_uid':toUid,
      'to_name':toName,
      'to_avatar':toAvatar
    });
  }

  void onRefresh(){
    asyncLoadAllData().then((_){
      refreshController.refreshCompleted(resetFooterState: true);
    }).catchError((_){
      refreshController.refreshFailed();
    });
  }


  void onLoading(){
    asyncLoadAllData().then((_){
      refreshController.loadComplete();
    }).catchError((_){
      refreshController.refreshFailed();
    });
  }

  getMyLocation() async {
    try{
      final location = await Location().getLocation();
      String address = "${location.latitude}, ${location.longitude}";
      String key = '';
      String url = "https://maps.googleapis"
          ".com/maps/api/geocode/json?address=$address&key=$key";
      var response = await HttpUtil().get(url);
      MyLocation locationRes = MyLocation.fromJson(response);
      if(locationRes.status=='OK'){
        String? myAddress = locationRes.results!.first.formattedAddress;
        if(myAddress != null){
          var userLocation = await db.collection('users')
              .where('id', isEqualTo: token).get();
          if(userLocation.docs.isNotEmpty){
            var docId = userLocation.docs.first.id;
            await db.collection('users').doc(docId)
                .update({'location':myAddress});
          }
        }
      }
    }catch(e){
      toastInfo(msg: 'Unable to get your location');
      if (kDebugMode) {
        print('An error occurred $e');
      }
    }
  }
}


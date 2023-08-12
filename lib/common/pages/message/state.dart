
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:nchat/common/entities/entities.dart';

class MessageState{
  /*
  obs makes a variable observable. If this variable changes,
  ui will be rebuilt.
  Variables used in our login logic will be tracked here so it can be accessed
  upward from controllers
  */

  RxList<QueryDocumentSnapshot<Msg>> msgList = <QueryDocumentSnapshot<Msg>>[]
      .obs;
}


import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nchat/common/entities/entities.dart';
import 'package:nchat/common/pages/message/chat/state.dart';
import 'package:path/path.dart';
import '../../../store/user.dart';
import '../../../utils/security.dart';
import '../../../widgets/toast.dart';

class ChatController extends GetxController {
  ChatState state = ChatState();
  ChatController();

  var doc_id;
  final textController = TextEditingController();
  ScrollController msgScrollControl = ScrollController();
  FocusNode contentNode = FocusNode();
  final token = UserStore.to.token;
  final db = FirebaseFirestore.instance;

  // To listen to messages
  var listener;

  // For file sharing

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future imageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _photo = File(pickedFile.path);
      uploadImage();
    } else {
      toastInfo(msg: 'No image selected');
    }
  }

  Future uploadImage() async {
    if (_photo == null) return;
    final filename = getRandomString(15) + extension(_photo!.path);
    try {
      final ref = FirebaseStorage.instance.ref('chat').child(filename);
      await ref.putFile(_photo!).snapshotEvents.listen((event) async {
        switch (event.state) {
          case TaskState.running:
            break;
          case TaskState.paused:
            break;
          case TaskState.error:
            break;
          case TaskState.canceled:
            break;
          case TaskState.success:
            String imgUrl = await getImgUrl(filename);
            sendImageMessage(imgUrl);
            break;
        }
      });
    } catch (e) {
      toastInfo(msg: 'An error occurred');
      if (kDebugMode) {
        print('An error occurred $e');
      }
    }
  }

  Future getImgUrl(String filename) async {
    final spaceRef = FirebaseStorage.instance.ref('chat').child(filename);
    var str = await spaceRef.getDownloadURL();
    return str ?? '';
  }

  @override
  void onInit() {
    super.onInit();
    var data = Get.parameters;
    doc_id = data['doc_id'];
    state.to_uid.value = data['to_uid'] ?? '';
    state.to_name.value = data['to_name'] ?? '';
    state.to_avatar.value = data['to_avatar'] ?? '';
    state.to_location.value = data['to_location'] ?? '';
  }

  sendMessage() async {
    String message = textController.text;
    final content = MsgContent(
      uid: token,
      content: message,
      type: 'text',
      addtime: Timestamp.now(),
    );
    await db
        .collection('message')
        .doc(doc_id)
        .collection('msglist')
        .withConverter(
            fromFirestore: MsgContent.fromFirestore,
            toFirestore: (MsgContent msgContent, options) =>
                msgContent.toFirestore())
        .add(content)
        .then((DocumentReference doc) {
      if (kDebugMode) {
        print('Document snapshot added with id ${doc.id}');
      }
      textController.clear();
      Get.focusScope?.unfocus();
    });

    await db.collection('message').doc(doc_id).update({
      'last_msg': message,
      'last_time': Timestamp.now(),
    });
  }

  sendImageMessage(String url) async {
    final content = MsgContent(
      uid: token,
      content: url,
      type: 'image',
      addtime: Timestamp.now(),
    );
    await db
        .collection('message')
        .doc(doc_id)
        .collection('msglist')
        .withConverter(
            fromFirestore: MsgContent.fromFirestore,
            toFirestore: (MsgContent msgContent, options) =>
                msgContent.toFirestore())
        .add(content)
        .then((DocumentReference doc) {
      if (kDebugMode) {
        print('Document snapshot added with id ${doc.id}');
      }
      textController.clear();
      Get.focusScope?.unfocus();
    });

    await db.collection('message').doc(doc_id).update({
      'last_msg': '[image]',
      'last_time': Timestamp.now(),
    });
  }

  @override
  void onReady() {
    super.onReady();
    var messages = db
        .collection('message')
        .doc(doc_id)
        .collection('msglist')
        .withConverter(
            fromFirestore: MsgContent.fromFirestore,
            toFirestore: (MsgContent msgContent, options) =>
                msgContent.toFirestore())
        .orderBy('addtime', descending: false);

    // clear msgcontentlist
    state.msgContentList.clear();

    // Listen for new messages
    listener = messages.snapshots().listen((event) {
      for (var change in event.docChanges) {
        switch (change.type) {
          case DocumentChangeType.added:
            if (change.doc.data() != null) {
              state.msgContentList.insert(0, change.doc.data()!);
            }
            break;
          case DocumentChangeType.modified:
            // TODO: Handle this case.
            break;
          case DocumentChangeType.removed:
            // TODO: Handle this case.
            break;
        }
      }
    }, onError: (error) => print('Listen failed $error'));

    getChatUserLocation();
  }

  getChatUserLocation() async {
    try {
      var location = await db
          .collection('users')
          .where('id', isEqualTo: state.to_uid)
          .withConverter(
              fromFirestore: UserData.fromFirestore,
              toFirestore: (UserData userData, options) =>
                  userData.toFirestore())
          .get();
      var chatUserLocation = location.docs.first.data().location;
      if (chatUserLocation != '') {
        state.to_location.value = chatUserLocation ?? 'Unknown';
      }
    } catch (e) {
      toastInfo(msg: 'Unable to get user\'s location');
      if (kDebugMode) {
        print('Failed to get user location: $e');
      }
    }
  }

  @override
  void dispose() {
    msgScrollControl.dispose();
    listener.cancel();
    super.dispose();
  }
}

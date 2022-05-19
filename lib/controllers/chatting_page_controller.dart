//import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/models/chat_model/chat_model.dart';
import 'package:petapp_mobile/models/post_model/post_model.dart';

class ChattingPageController extends GetxController {
  RxString chatTextValue = ''.obs;
  late PostModel postModel;
  RxString requestStatus = 'NOT_SEND'.obs;
  RxBool showPost = true.obs;
  RxBool isDisplayCalender = false.obs;
  RxString transactionTimeText = ''.obs;
  DateTime? transactionTime;
  RxString transactionLocation = ''.obs;
  RxString description = ''.obs;
  DateTime? tmpTransactionTime;
  RxBool isShowCreateRequest = false.obs;
  ScrollController scrollController = ScrollController();
  RxBool isUseOwnerAddress = false.obs;
  late io.Socket socket;

  ChattingPageController() {
    initSocketIO();
  }

  Future initSocketIO() async {
    socket = io.io(
        'http://127.0.1.1:4000',
        io.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .setExtraHeaders({'foo': 'bar'}) // optional
            .build());
    socket.onConnect((_) {
      print('connect');
    });
    socket.on('event', (data) => print(data));
    socket.onDisconnect((_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));
    socket.emit('joinRoom', '628543ae50adfd01065edf37');
    socket.emit('chatToServer', '6285417450adfd01065edf31');
    socket.on('joinedRoom', (data) => print(data));
    //socket.emit('leaveRoom', '628543ae50adfd01065edf37');
    socket.on('leftRoom', (data) => print(data));
    socket.connect();
    // SocketIOManager socketIOManager = SocketIOManager();
    // SocketOptions socketOptions = SocketOptions(
    //   // 'https://socketio-chat-h9jt.herokuapp.com/',
    //   'http://54.215.144.186/',
    //   enableLogging: true,
    //   transports: [
    //     Transports.webSocket,
    //     // Transports.polling,
    //   ],
    // );
    // socketIO = await socketIOManager.createInstance(socketOptions);
    // socketIO.onConnect.listen((event) {
    //   print('connectedttttttttttttttttttttttttttttttttttt');
    //   // List<String> listUser = [];
    //   // listUser.add('LapDeptrai');
    //   // socketIO.emit('add user', listUser);
    // });
    // socketIO.on('login').listen((event) {
    //   print('login' + event.toString());
    // });
    // socketIO.onConnectError.listen((event) {
    //   event.printError();
    // });
    // socketIO.on('new message').listen((event) {
    //   chatModelsList.add(
    //     ChatModel(
    //       isOwnerChat: false,
    //       isLastChat: true,
    //       chatContent: event[0]['message'],
    //       chatTime: DateTime.now(),
    //     ),
    //   );
    //   update();
    //   scrollController.animateTo(scrollController.position.maxScrollExtent,
    //       duration: const Duration(seconds: 1), curve: Curves.ease);
    // });
    // socketIO.connect();
  }

  List<ChatModel> chatModelsList = [];
}

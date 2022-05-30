import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/controllers/auth_controller.dart';
import 'package:petapp_mobile/controllers/sign_in_page_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/chat_room_model/chat_room_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:get/get.dart';

class ChattingListPageController extends GetxController {
  late List<ChatRoomModel> chatRoomList;
  RxBool isLoadingRoom = true.obs;
  late io.Socket socket;
  AccountModel accountModel = Get.find<AuthController>().accountModel;
  @override
  void onInit() {
    initSocketIO();
    super.onInit();
  }

  Future initSocketIO() async {
    socket = io.io(
        'http://$API_SERVER',
        io.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .setExtraHeaders({'foo': 'bar'}) // optional
            .build());
    socket.onConnect((_) {
      print('connect');
    });
    socket.onDisconnect((_) => print('disconnect'));
  }
}

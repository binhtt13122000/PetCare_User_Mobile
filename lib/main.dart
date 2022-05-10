import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/bindings/add_pet_page_binding.dart';
import 'package:petapp_mobile/bindings/chatting_page_binding.dart';
import 'package:petapp_mobile/bindings/create_post_page_binding.dart';
import 'package:petapp_mobile/bindings/home_page_binding.dart';
import 'package:petapp_mobile/bindings/notification_page_binding.dart';
import 'package:petapp_mobile/bindings/personal_information_page_binding.dart';
import 'package:petapp_mobile/bindings/register_page_binding.dart';
import 'package:petapp_mobile/bindings/sign_in_page_binding.dart';
import 'package:petapp_mobile/bindings/pet_management_page_binding.dart';
import 'package:petapp_mobile/bindings/purchase_posts_page_binding.dart';
import 'package:petapp_mobile/bindings/post_management_page_binding.dart';
import 'package:petapp_mobile/bindings/transaction_page_binding.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/rounter.dart';
import 'package:petapp_mobile/controllers/sign_in_page_controller.dart';
import 'package:petapp_mobile/services/account_services.dart';
import 'package:petapp_mobile/views/customer/action_page/action_page.dart';
import 'package:petapp_mobile/views/customer/add_pet_page/add_pet_page.dart';
import 'package:petapp_mobile/views/customer/chatting_detail_page/chatting_detail_page.dart';
import 'package:petapp_mobile/views/customer/chatting_landing_page/chatting_landing_page.dart';
import 'package:petapp_mobile/views/customer/create_post_page/create_post_page.dart';
import 'package:petapp_mobile/views/customer/home_page/home_page.dart';
import 'package:petapp_mobile/views/customer/notification_page/notification_page.dart';
import 'package:petapp_mobile/views/customer/personal_infomation_page/personal_infomation_page.dart';
import 'package:petapp_mobile/views/customer/pet_management_page/pet_management_page.dart';
import 'package:petapp_mobile/views/customer/post_management_page/post_management_page.dart';
import 'package:petapp_mobile/views/customer/profile_page/profile_page.dart';
import 'package:petapp_mobile/views/customer/purchase_posts_filter_page/purchase_posts_filter_page.dart';
import 'package:petapp_mobile/views/customer/purchase_posts_page/purchase_posts_page.dart';
import 'package:petapp_mobile/views/customer/setting_page/setting.dart';
import 'package:petapp_mobile/views/customer/support_page/support.dart';
import 'package:petapp_mobile/views/customer/transaction_page/transaction_page.dart';
import 'package:petapp_mobile/views/guest/landing_page/landing_page.dart';
import 'package:petapp_mobile/views/guest/register_otp_page/register_otp_page.dart';
import 'package:petapp_mobile/views/guest/register_page/register_page.dart';
import 'package:petapp_mobile/views/guest/register_phone_number_page/register_phone_number_page.dart';
import 'package:petapp_mobile/views/guest/sign_in_page/sign_in_page.dart';
import 'package:petapp_mobile/views/guest/verification_otp_page/verification_otp_page.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  String initRounter = HOME_PAGE_ROUNTER;
  if (FirebaseAuth.instance.currentUser == null) {
    initRounter = LANDING_PAGE_ROUNTER;
  } else {
    String idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    SignInPageController signInPageController = Get.put(SignInPageController());
    await signInPageController.setUserDeviceToken();
    signInPageController.accountModel = await AccountService.signIn(
      idToken: idToken,
      userDeviceToken: signInPageController.userDeviceToken,
    );
  }

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  io.Socket socket = io.io('$API_SERVER/chat', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });

  socket.connect();
  socket.onConnect(
    (data) => print('adsfasdfasdfdfasdfasdfsdfasdfasdfasfd'),
  );
  print(socket.connected.toString() + 'connected');
  runApp(MainApp(initRounter: initRounter));
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key, required this.initRounter}) : super(key: key);
  final String initRounter;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pet App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      initialRoute: initRounter,
      getPages: [
        //!Guest
        //*Landing page
        GetPage(
          name: LANDING_PAGE_ROUNTER,
          page: () => const GuestLandingPage(),
        ),
        //*Login page
        GetPage(
          name: SIGN_IN_PAGE_ROUNTER,
          page: () => const SignInPage(),
          binding: SignInPageBinding(),
        ),
        GetPage(
          name: VERIFICATION_OTP_PAGE_ROUNTER,
          page: () => const VerificationOTPPage(),
        ),
        //*Register page
        GetPage(
          name: REGISTER_PHONE_NUMBER_PAGE_ROUNTER,
          page: () => const RegisterPhoneNumberPage(),
          binding: RegisterPageBinding(),
        ),
        GetPage(
          name: REGISTER_USER_INFORMATION_PAGE_ROUNTER,
          page: () => const RegisterUserInformationPage(),
        ),
        GetPage(
          name: REGISTER_OTP_PAGE_ROUNTER,
          page: () => const RegisterOTPPage(),
        ),
        //!Customer
        //*Home
        GetPage(
          name: HOME_PAGE_ROUNTER,
          page: () => const HomePage(),
          binding: HomePageBinding(),
        ),
        // GetPage(
        //   name: POST_DETAIL_PAGE_ROUNTER,
        //   page: () => const PostDetaiPage(),
        // ),
        GetPage(
          name: PURCHASE_POSTS_PAGE_ROUNTER,
          page: () => const PurchasePostsPage(),
          binding: PurchasePostsPageBinding(),
        ),
        GetPage(
          name: PURCHASE_POSTS_FILTER_PAGE_ROUNTER,
          page: () => const PurchasePostsFilterPage(),
        ),
        GetPage(
          name: NOTIFICATION_PAGE_ROUNTER,
          page: () => const NotificationPage(),
          binding: NotificationPageBinding(),
        ),
        //*Action
        GetPage(
          name: ACTION_PAGE_ROUNTER,
          page: () => const AcctionPage(),
        ),
        GetPage(
          name: CREATE_POST_PAGE_ROUNTER,
          page: () => const CreatePostPage(),
          binding: CreatePostPageBinding(),
        ),
        GetPage(
          name: POST_MANAGEMENT_PAGE_ROUNTER,
          page: () => const PostManagementPage(),
          binding: PostManagementPageBinding(),
        ),
        GetPage(
          name: TRANSACTION_PAGE_ROUNTER,
          page: () => const TransactionPage(),
          binding: TransactionPageBinding(),
        ),
        //*Support
        GetPage(
          name: SUPPORT_PAGE_ROUNTER,
          page: () => const SupportPage(),
        ),
        //*Profile
        GetPage(
          name: PROFILE_PAGE_ROUNTER,
          page: () => const ProfilePage(),
        ),
        GetPage(
          name: PET_MANAGEMENT_PAGE_ROUNTER,
          page: () => const PetManagementPage(),
          binding: PetManagementPageBinding(),
        ),
        GetPage(
          name: ADD_PET_PAGE_ROUNTER,
          page: () => const AddPetPage(),
          binding: AddPetPagePageBinding(),
        ),
        GetPage(
          name: PERSONAl_INFOMATION_PAGE_ROUNTER,
          page: () => const PersonalInformationPage(),
          binding: PersonalInformationPageBinding(),
        ),
        // GetPage(
        //   name: PET_DETAIL_PAGE_ROUNTER,
        //   page: () => const PetDetaiPage(),
        //   binding: PetDetailPageBinding(),
        // ),
        //*Setting
        GetPage(
          name: SETTING_PAGE_ROUNTER,
          page: () => const SettingPage(),
        ),
        //*Chatting
        GetPage(
          name: CHATTING_LANDING_PAGE_ROUNTER,
          page: () => const ChattingLandingPage(),
          binding: ChattingPageBinding(),
        ),
        GetPage(
          name: CHATTING_DETAIL_PAGE_ROUNTER,
          page: () => const ChattingDetailPage(),
        )
      ],
    );
  }
}

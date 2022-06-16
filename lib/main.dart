import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/bindings/action_page_binding.dart';
import 'package:petapp_mobile/bindings/add_pet_page_binding.dart';
import 'package:petapp_mobile/bindings/breeding_transaction_detail_page_binding.dart';
import 'package:petapp_mobile/bindings/buy_services_combo_page_binding.dart';
import 'package:petapp_mobile/bindings/chatting_detail_page_binding.dart';
import 'package:petapp_mobile/bindings/chatting_list_page_binding.dart';
import 'package:petapp_mobile/bindings/create_post_page_binding.dart';
import 'package:petapp_mobile/bindings/create_ticket_page_binding.dart';
import 'package:petapp_mobile/bindings/deworming_history_page_binding.dart';
import 'package:petapp_mobile/bindings/home_page_binding.dart';
import 'package:petapp_mobile/bindings/notification_page_binding.dart';
import 'package:petapp_mobile/bindings/payment_for_center_services_transaction_page_binding.dart';
import 'package:petapp_mobile/bindings/personal_information_page_binding.dart';
import 'package:petapp_mobile/bindings/pet_combo_detail_page_binding.dart';
import 'package:petapp_mobile/bindings/pet_detail_page_binding.dart';
import 'package:petapp_mobile/bindings/pet_weight_page_binding.dart';
import 'package:petapp_mobile/bindings/profile_page_binding.dart';
import 'package:petapp_mobile/bindings/post_detail_page_binding.dart';
import 'package:petapp_mobile/bindings/register_page_binding.dart';
import 'package:petapp_mobile/bindings/remove_tick_history_page_binding.dart';
import 'package:petapp_mobile/bindings/sale_transaction_detail_page_binding.dart';
import 'package:petapp_mobile/bindings/sign_in_page_binding.dart';
import 'package:petapp_mobile/bindings/pet_management_page_binding.dart';
import 'package:petapp_mobile/bindings/purchase_posts_page_binding.dart';
import 'package:petapp_mobile/bindings/post_management_page_binding.dart';
import 'package:petapp_mobile/bindings/center_services_transaction_detail_page_binding.dart';
import 'package:petapp_mobile/bindings/ticket_detail_page_binding.dart';
import 'package:petapp_mobile/bindings/transaction_list_page_binding.dart';
import 'package:petapp_mobile/bindings/update_pet_page_binding.dart';
import 'package:petapp_mobile/bindings/update_sale_post_page_binding.dart';
import 'package:petapp_mobile/bindings/vaccine_list_page_binding.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/controllers/auth_controller.dart';
import 'package:petapp_mobile/controllers/sign_in_page_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/services/account_services.dart';
import 'package:petapp_mobile/views/customer/action_page/action_page.dart';
import 'package:petapp_mobile/views/customer/app_logo_page/app_logon_page.dart';
import 'package:petapp_mobile/views/customer/breeding_transaction_detail_page/breeding_transaction_detail_page.dart';
import 'package:petapp_mobile/views/customer/buy_services_combo_page/buy_services_combo_page.dart';
import 'package:petapp_mobile/views/customer/center_services_transaction_detail_page/center_services_transaction_detail_page.dart';
import 'package:petapp_mobile/views/customer/center_services_transaction_payment_method_page/center_services_transaction_payment_method_page.dart';
import 'package:petapp_mobile/views/customer/chatting_detail_page/chatting_detail_page.dart';
import 'package:petapp_mobile/views/customer/chatting_list_page/chatting_list_page.dart';
import 'package:petapp_mobile/views/customer/create_pet_page/create_pet_page.dart';
import 'package:petapp_mobile/views/customer/create_post_page/create_post_page.dart';
import 'package:petapp_mobile/views/customer/create_ticket_page/create_ticket_page.dart';
import 'package:petapp_mobile/views/customer/deworming_history_page/deworming_history_page.dart';
import 'package:petapp_mobile/views/customer/home_page/home_page.dart';
import 'package:petapp_mobile/views/customer/notification_page/notification_page.dart';
import 'package:petapp_mobile/views/customer/payment_for_center_services_transaction_page/payment_for_center_services_transaction_page.dart';
import 'package:petapp_mobile/views/customer/personal_information_page/personal_information_page.dart';
import 'package:petapp_mobile/views/customer/pet_combo_detail_page/pet_combo_detail_page.dart';
import 'package:petapp_mobile/views/customer/pet_detail_page/pet_detail_page.dart';
import 'package:petapp_mobile/views/customer/pet_management_page/pet_management_page.dart';
import 'package:petapp_mobile/views/customer/pet_weight_page/pet_weight_page.dart';
import 'package:petapp_mobile/views/customer/post_detail_page/post_detail_page.dart';
import 'package:petapp_mobile/views/customer/post_management_page/post_management_page.dart';
import 'package:petapp_mobile/views/customer/profile_page/profile_page.dart';
import 'package:petapp_mobile/views/customer/purchase_posts_filter_page/purchase_posts_filter_page.dart';
import 'package:petapp_mobile/views/customer/sale_post_list_page/sale_post_page.dart';
import 'package:petapp_mobile/views/customer/sale_transaction_detail_page/sale_transaction_detail_page.dart';
import 'package:petapp_mobile/views/customer/ticket_detail_page/ticket_detail_page.dart';
import 'package:petapp_mobile/views/customer/transaction_list_page/transaction_list_page.dart';
import 'package:petapp_mobile/views/customer/update_pet_page/update_pet_page.dart';
import 'package:petapp_mobile/views/customer/update_sale_post_page/update_sale_post_page.dart';
import 'package:petapp_mobile/views/customer/vaccine_list_page/vaccine_list_page.dart';
import 'package:petapp_mobile/views/guest/landing_page/landing_page.dart';
import 'package:petapp_mobile/views/guest/register_otp_page/register_otp_page.dart';
import 'package:petapp_mobile/views/guest/register_page/register_page.dart';
import 'package:petapp_mobile/views/guest/register_phone_number_page/register_phone_number_page.dart';
import 'package:petapp_mobile/views/guest/sign_in_page/sign_in_page.dart';
import 'package:petapp_mobile/views/guest/sign_in_verification_otp_page/sign_in_verification_otp_page.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:petapp_mobile/views/remove_ticks_history_page/remove_ticks_history_page.dart';

final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey(debugLabel: "Main Navigator");

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(0, 199, 57, 57),
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const MainApp());

  await Firebase.initializeApp();

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
        playSound: true,
        enableVibration: true);

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  late String initRoute;

  if (FirebaseAuth.instance.currentUser == null) {
    initRoute = LANDING_PAGE_ROUTE;
  } else {
    String idToken = await FirebaseAuth.instance.currentUser!.getIdToken();

    SignInPageController signInPageController = Get.put(SignInPageController());
    await signInPageController.setUserDeviceToken();

    AccountModel? accountModel = await AccountService.signIn(
      idToken: idToken,
      userDeviceToken: signInPageController.userDeviceToken,
    );

    if (accountModel != null) {
      Get.lazyPut<AuthController>(
          () => AuthController(accountModel: accountModel),
          fenix: true);
      initRoute = HOME_PAGE_ROUTE;
    } else {
      initRoute = LANDING_PAGE_ROUTE;
    }
  }

  Get.offNamed(initRoute);
}

onSelectNotification(String? type, String? metaData) async {
  if (type == null) {
    return;
  }
  switch (type) {
    case "CONFIRM_POST":
    case "REJECT_POST":
      if (metaData != null) {
        var id = int.tryParse(metaData);
        id != null
            ? Get.toNamed('$POST_DETAIL_PAGE_ROUTE/$id')
            : Get.toNamed(POST_MANAGEMENT_PAGE_ROUTE);
      }
      break;
    case "NEW_REQUEST":
    case "UPDATE_REQUEST":
    case "CANCELED_REQUEST":
    case "REJECT_REQUEST":
    case "APPROVE_REQUEST":
    case "NEW_ROOM_CREATED":
      if (metaData != null) {
        Get.toNamed('$CHATTING_DETAIL_PAGE_ROUTE/$metaData');
      }
      break;
    case "CREATED_TICKET":
      if (metaData != null) {
        var id = int.tryParse(metaData);
        id != null
            ? Get.toNamed('$TICKET_DETAIL_PAGE_ROUTE/$id')
            : Get.toNamed(HOME_PAGE_ROUTE);
      }
      break;
    case "SUCCESS_SALE_TRANSACTION":
      if (metaData != null) {
        var id = int.tryParse(metaData);
        id != null
            ? Get.toNamed('$SALE_TRANSACTION_DETAIL_PAGE_ROUTE/$id')
            : Get.toNamed(TRANSACTION_PAGE_ROUTE);
      }
      break;
    case "SUCCESS_BREEDING_TRANSACTION":
      if (metaData != null) {
        var id = int.tryParse(metaData);
        id != null
            ? Get.toNamed('$BREEDING_TRANSACTION_DETAIL_PAGE_ROUTE/$id')
            : Get.toNamed(TRANSACTION_PAGE_ROUTE);
      }
      break;
    default:
      Get.toNamed(HOME_PAGE_ROUTE);
      break;
  }
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  showNotification(
      message.notification!.title ?? "",
      message.notification!.body ?? "",
      message.data["metadata"],
      message.data["type"]);
}

void showNotification(
    String title, String body, String? metaData, String type) async {
  await demoNotification(title, body, metaData, type);
}

Future<void> demoNotification(
    String title, String body, String? metaData, String type) async {
  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'channel_ID', 'channel name',
      importance: Importance.max,
      playSound: true,
      showProgress: true,
      priority: Priority.high,
      ticker: 'test ticker');
  var iOSChannelSpecifics = const IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics, iOS: iOSChannelSpecifics);
  const initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const initializationSettingsIOS = IOSInitializationSettings();
  var initializationSettings = const InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (payload) => onSelectNotification(type, metaData));
  await flutterLocalNotificationsPlugin
      .show(0, title, body, platformChannelSpecifics, payload: 'notification');
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pet App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      initialRoute: APP_LOGO_PAGE_ROUTE,
      // routingCallback: (routing) {
      //   print('callback' + routing!.current);
      // },
      getPages: [
        //*App logo
        GetPage(
          name: APP_LOGO_PAGE_ROUTE,
          page: () => const AppLogoPage(),
        ),
        //!Guest
        //*Landing page
        GetPage(
          name: LANDING_PAGE_ROUTE,
          page: () => const GuestLandingPage(),
        ),
        //*Login page
        GetPage(
          name: SIGN_IN_PAGE_ROUTE,
          page: () => const SignInPage(),
          binding: SignInPageBinding(),
        ),
        GetPage(
          name: SIGN_IN_VERIFICATION_OTP_PAGE_ROUTE,
          page: () => const SignInVerificationOTPPage(),
        ),
        //*Register page
        GetPage(
          name: REGISTER_PHONE_NUMBER_PAGE_ROUTE,
          page: () => const RegisterPhoneNumberPage(),
          binding: RegisterPageBinding(),
        ),
        GetPage(
          name: REGISTER_USER_INFORMATION_PAGE_ROUTE,
          page: () => const RegisterUserInformationPage(),
        ),
        GetPage(
          name: REGISTER_OTP_PAGE_ROUTE,
          page: () => const RegisterOTPPage(),
        ),
        //!Customer
        //*Home
        GetPage(
          name: HOME_PAGE_ROUTE,
          page: () => const HomePage(),
          binding: HomePageBinding(),
        ),
        GetPage(
          name: PURCHASE_POSTS_PAGE_ROUTE,
          page: () => const SalePostListPage(),
          binding: PurchasePostsPageBinding(),
        ),
        GetPage(
          name: PURCHASE_POSTS_FILTER_PAGE_ROUTE,
          page: () => const PurchasePostsFilterPage(),
        ),
        GetPage(
          name: NOTIFICATION_PAGE_ROUTE,
          page: () => const NotificationPage(),
          binding: NotificationPageBinding(),
        ),
        GetPage(
            name: '$POST_DETAIL_PAGE_ROUTE/:postId',
            page: () => const PostDetailPage(),
            binding: PostDetailPageBinding()),
        GetPage(
            name: '$UPDATE_SALE_POST_PAGE_ROUTE/:salePostId',
            page: () => const UpdateSalePostPage(),
            binding: UpdateSalePostPageBinding()),
        //*Action
        GetPage(
          name: ACTION_PAGE_ROUTE,
          page: () => const ActionPage(),
          binding: ActionPageBinding(),
        ),
        GetPage(
          name: CREATE_POST_PAGE_ROUTE,
          page: () => const CreatePostPage(),
          binding: CreatePostPageBinding(),
        ),
        GetPage(
          name: POST_MANAGEMENT_PAGE_ROUTE,
          page: () => const PostManagementPage(),
          binding: PostManagementPageBinding(),
        ),
        GetPage(
          name: TRANSACTION_PAGE_ROUTE,
          page: () => const TransactionListPage(),
          binding: TransactionListPageBinding(),
        ),
        GetPage(
          name:
              '$PAYMENT_FOR_CENTER_SERVICES_TRANSACTION_PAGE_ROUTE/:transactionId',
          page: () => const PaymentForCenterServicesTransactionPage(),
          binding: PaymentForCenterServicesTransactionPageBinding(),
        ),
        GetPage(
          name: CENTER_SERVICES_TRANSACTION_PAYMENT_METHOD_PAGE_ROUTE,
          page: () => const CenterServicesTransactionPaymentMethodPage(),
        ),
        GetPage(
          name: '$CENTER_SERVICES_TRANSACTION_DETAIL_PAGE_ROUTE/:transactionId',
          page: () => const CenterServicesTransactionDetailPage(),
          binding: CenterServicesTransactionDetailPageBinding(),
        ),
        GetPage(
          name: '$SALE_TRANSACTION_DETAIL_PAGE_ROUTE/:saleTransactionId',
          page: () => const SaleTransactionDetailPage(),
          binding: SaleTransactionDetailPageBinding(),
        ),
        GetPage(
          name:
              '$BREEDING_TRANSACTION_DETAIL_PAGE_ROUTE/:breedingTransactionId',
          page: () => const BreedingTransactionDetailPage(),
          binding: BreedingTransactionDetailPageBinding(),
        ),
        //*Profile
        GetPage(
          name: PROFILE_PAGE_ROUTE,
          page: () => const ProfilePage(),
          binding: ProfilePageBinding(),
        ),

        GetPage(
          name: PERSONAl_INFORMATION_PAGE_ROUTE,
          page: () => const PersonalInformationPage(),
          binding: PersonalInformationPageBinding(),
        ),
        //*Pet
        GetPage(
          name: PET_MANAGEMENT_PAGE_ROUTE,
          page: () => const PetManagementPage(),
          binding: PetManagementPageBinding(),
        ),
        GetPage(
          name: CREATE_PET_PAGE_ROUTE,
          page: () => const CreatePetPage(),
          binding: AddPetPagePageBinding(),
        ),
        GetPage(
          name: '$PET_DETAIL_PAGE_ROUTE/:petId',
          page: () => const PetDetailPage(),
          binding: PetDetailPageBinding(),
        ),
        GetPage(
          name: '$PET_WEIGHT_PAGE_ROUTE/:petId',
          page: () => const PetWeightPage(),
          binding: PetWeightPageBinding(),
        ),
        GetPage(
          name: '$UPDATE_PET_PAGE_ROUTE/:petId',
          page: () => const UpdatePetPage(),
          binding: UpdatePetPageBinding(),
        ),
        GetPage(
          name: '$VACCINE_LIST_PAGE_ROUTE/:petId',
          page: () => const VaccineListPage(),
          binding: VaccineListPageBinding(),
        ),
        GetPage(
          name: '$DEWORMING_HISTORY_PAGE_ROUTE/:petId',
          page: () => const DewormingHistoryPage(),
          binding: DewormingHistoryPageBiding(),
        ),
        GetPage(
          name: '$REMOVE_TICKS_PAGE_ROUTE/:petId',
          page: () => const RemoveTickHistoryPage(),
          binding: RemoveTicksHistoryPageBinding(),
        ),
        //*Chatting
        GetPage(
          name: CHATTING_LIST_PAGE_ROUTE,
          page: () => const ChattingListPage(),
          binding: ChattingListPageBinding(),
        ),
        GetPage(
          name: '$CHATTING_DETAIL_PAGE_ROUTE/:chatRoomId',
          page: () => const ChattingDetailPage(),
          binding: ChattingDetailPageBinding(),
        ),
        GetPage(
          name: '$CHATTING_DETAIL_PAGE_ROUTE/sellerId/:sellerId/postId/:postId',
          page: () => const ChattingDetailPage(),
          binding: ChattingDetailPageBinding(),
        ),
        //*Pet Services Combo
        GetPage(
          name: BUY_SERVICES_COMBO_PAGE_ROUTE,
          page: () => const BuyServicesComboPage(),
          binding: BuyServicesComboPageBinding(),
        ),
        GetPage(
          name: '$PET_COMBO_DETAIL_PAGE_ROUTE/:petComboId',
          page: () => const PetComboDetailPage(),
          binding: PetComboDetailPageBinding(),
        ),
        //*Ticket
        GetPage(
            name: '$TICKET_DETAIL_PAGE_ROUTE/:ticketId',
            page: () => const TicketDetailPage(),
            binding: TicketDetailPageBinding()),
        GetPage(
          name: CREATE_TICKET_PAGE_ROUTE,
          page: () => const CreateTicketPage(),
          binding: CreateTicketPageBinding(),
        ),
      ],
    );
  }
}

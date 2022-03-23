import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:petapp_mobile/bindings/add_pet_page_binding.dart';
import 'package:petapp_mobile/bindings/create_ticket_page_binding.dart';
import 'package:petapp_mobile/bindings/home_page_binding.dart';
import 'package:petapp_mobile/bindings/sign_in_page_binding.dart';
import 'package:petapp_mobile/bindings/pet_detail_page_binding.dart';
import 'package:petapp_mobile/bindings/pet_management_page_binding.dart';
import 'package:petapp_mobile/bindings/purchase_posts_page_binding.dart';
import 'package:petapp_mobile/bindings/ticket_management_page_binding.dart';
import 'package:petapp_mobile/bindings/transaction_page_binding.dart';
import 'package:petapp_mobile/configs/rounter.dart';
import 'package:petapp_mobile/views/customer/action_page/action_page.dart';
import 'package:petapp_mobile/views/customer/add_pet_page/add_pet_page.dart';
import 'package:petapp_mobile/views/customer/create_ticket_page/create_ticket_page.dart';
import 'package:petapp_mobile/views/customer/home_page/home_page.dart';
import 'package:petapp_mobile/views/customer/pet_detail_page/pet_detail_page.dart';
import 'package:petapp_mobile/views/customer/pet_management_page/pet_management_page.dart';
import 'package:petapp_mobile/views/customer/post_detail_page/post_detail_page.dart';
import 'package:petapp_mobile/views/customer/profile_page/profile.dart';
import 'package:petapp_mobile/views/customer/purchase_posts_filter_page/purchase_posts_filter_page.dart';
import 'package:petapp_mobile/views/customer/purchase_posts_page/purchase_posts_page.dart';
import 'package:petapp_mobile/views/customer/setting_page/setting.dart';
import 'package:petapp_mobile/views/customer/support_page/support.dart';
import 'package:petapp_mobile/views/customer/ticket_management_page/ticket_management_page.dart';
import 'package:petapp_mobile/views/customer/transaction_page/transaction_page.dart';
import 'package:petapp_mobile/views/guest/landing_page/landing_page.dart';
import 'package:petapp_mobile/views/guest/sign_in_page/sign_in_page.dart';
import 'package:petapp_mobile/views/guest/verification_otp_page/verification_otp_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pet App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      initialRoute: HOME_PAGE_ROUNTER,
      getPages: [
        //!Guest
        GetPage(
          name: LANDING_PAGE_ROUNTER,
          page: () => const LandingPage(),
        ),
        GetPage(
          name: SIGN_IN_PAGE_ROUNTER,
          page: () => const SignInPage(),
          binding: SignInPageBinding(),
        ),
        GetPage(
          name: VERIFICATION_OTP_PAGE_ROUNTER,
          page: () => const VerificationOTPPage(),
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
        //*Action
        GetPage(
          name: ACTION_PAGE_ROUNTER,
          page: () => const AcctionPage(),
        ),
        GetPage(
          name: CREATE_TICKET_PAGE_ROUNTER,
          page: () => const CreateTicketPage(),
          binding: CreateTicketPageBinding(),
        ),
        GetPage(
          name: TICKET_MANAGEMENT_PAGE_ROUNTER,
          page: () => const TicketManagementPage(),
          binding: TicketManagementPageBinding(),
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
      ],
    );
  }
}

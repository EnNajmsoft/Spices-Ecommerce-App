
import 'package:Spices_Ecommerce_app/views/auth/login_or_signup_page.dart';
import 'package:Spices_Ecommerce_app/views/auth/login_page.dart';
import 'package:Spices_Ecommerce_app/views/auth/number_verification_page.dart';
import 'package:Spices_Ecommerce_app/views/auth/password_reset_page.dart';
import 'package:Spices_Ecommerce_app/views/auth/sign_up_page.dart';
import 'package:Spices_Ecommerce_app/views/cart/cart_page.dart';
import 'package:Spices_Ecommerce_app/views/cart/checkout_page.dart';
import 'package:Spices_Ecommerce_app/views/drawer/about_us_page.dart';
import 'package:Spices_Ecommerce_app/views/drawer/contact_us_page.dart';
import 'package:Spices_Ecommerce_app/views/drawer/drawer_page.dart';
import 'package:Spices_Ecommerce_app/views/drawer/faq_page.dart';
import 'package:Spices_Ecommerce_app/views/drawer/help_page.dart';
import 'package:Spices_Ecommerce_app/views/drawer/terms_and_conditions_page.dart';
import 'package:Spices_Ecommerce_app/views/entrypoint/entrypoint_ui.dart';
import 'package:Spices_Ecommerce_app/views/home/bundle_details_page.dart';
import 'package:Spices_Ecommerce_app/views/home/bundle_product_details_page.dart';
import 'package:Spices_Ecommerce_app/views/home/home_page.dart';
import 'package:Spices_Ecommerce_app/views/home/new_item_page.dart';
import 'package:Spices_Ecommerce_app/views/home/order_failed_page.dart';
import 'package:Spices_Ecommerce_app/views/home/order_successfull_page.dart';
import 'package:Spices_Ecommerce_app/views/home/product_details_page.dart';
import 'package:Spices_Ecommerce_app/views/home/search_page.dart';
import 'package:Spices_Ecommerce_app/views/home/search_result_page.dart';
import 'package:Spices_Ecommerce_app/views/menu/category_page.dart';
import 'package:Spices_Ecommerce_app/views/profile/address/new_address_page.dart';
import 'package:Spices_Ecommerce_app/views/profile/coupon/coupon_details_page.dart';
import 'package:Spices_Ecommerce_app/views/profile/order/order_details.dart';
import 'package:Spices_Ecommerce_app/views/profile/payment_method/payment_method_page.dart';
import 'package:Spices_Ecommerce_app/views/profile/profile_edit_page.dart';
import 'package:Spices_Ecommerce_app/views/profile/profile_page.dart';
import 'package:Spices_Ecommerce_app/views/profile/settings/change_password_page.dart';
import 'package:Spices_Ecommerce_app/views/profile/settings/change_phone_number_page.dart';
import 'package:Spices_Ecommerce_app/views/profile/settings/notifications_settings_page.dart';
import 'package:Spices_Ecommerce_app/views/profile/settings/settings_page.dart';
import 'package:Spices_Ecommerce_app/views/review/review_page.dart';
import 'package:Spices_Ecommerce_app/views/review/submit_review_page.dart';
import 'package:get/get.dart';


class AppRoutes {
  /// The Initial Page
  static const introLogin = '/intro_login';
  static const onboarding = '/onboarding';

  /* <---- Login, Signup -----> */
  static const login = '/login';
  static const signup = '/signup';
  static const loginOrSignup = '/loginOrSignup';
  static const numberVerification = '/numberVerification';
  static const forgotPassword = '/forgotPassword';
  static const passwordReset = '/passwordReset';

  /* <---- ENTRYPOINT -----> */
  static const entryPoint = '/entry_point';

  /* <---- Products Order Process -----> */
  static const home = '/home';
  static const newItems = '/newItems';
  static const popularItems = '/popularItems';
  static const bundleProduct = '/bundleProduct';
  static const createMyPack = '/createMyPack';
  static const bundleDetailsPage = '/bundleDetailsPage';
  static const productDetails = '/productDetails';
  static const cartPage = '/cartPage';
  static const savePage = '/favouriteList';
  static const checkoutPage = '/checkoutPage';

  /// Order Status
  static const orderSuccessfull = '/orderSuccessfull';
  static const orderFailed = '/orderFailed';
  static const noOrderYet = '/noOrderYet';

  /// Category
  static const category = '/category';
  static const categoryDetails = '/categoryDetails';

  /// Search Page
  static const search = '/search';
  static const searchResult = '/searchResult';

  /* <---- Profile & Settings -----> */
  static const profile = '/profile';
  static const myOrder = '/myOrder';
  static const orderDetails = '/orderDetails';
  static const coupon = '/coupon';
  static const couponDetails = '/couponDetails';
  static const deliveryAddress = '/deliveryAddress';
  static const newAddress = '/newAddress';
  static const orderTracking = '/orderTracking';
  static const profileEdit = '/profileEdit';
  static const notifications = '/notifications';
  static const settings = '/settings';
  static const settingsLanguage = '/settingsLanguage';
  static const settingsNotifications = '/settingsNotifications';
  static const changePassword = '/changePassword';
  static const changePhoneNumber = '/changePhoneNumber';

  /* <---- Review and Comments -----> */
  static const review = '/review';
  static const submitReview = '/submitReview';

  /* <---- Drawer Page -----> */
  static const drawerPage = '/drawerPage';
  static const aboutUs = '/aboutUs';
  static const faq = '/faq';
  static const termsAndConditions = '/termsAndConditions';
  static const help = '/help';
  static const contactUs = '/contactUs';

  /* <---- Payment Method -----> */
  static const paymentMethod = '/paymentMethod';
  static const paymentCardAdd = '/paymentCardAdd';

  static final List<GetPage> routes = [
    
     GetPage(
      name: entryPoint,
      page: () => const EntryPointUI(),
    ),

    GetPage(
      name: home,
      page: () => const HomePage(),
    ),

    GetPage(
      name: login,
      page: () => LoginPage(),
    ),
    GetPage(
      name: signup,
      page: () => SignUpPage(),
    ),
    GetPage(
      name: loginOrSignup,
      page: () => LoginOrSignUpPage(),
    ),
    GetPage(
      name: numberVerification,
      page: () => NumberVerificationPage(),
    ),
    // GetPage(
    //   name: forgotPassword,
    //   page: () => ForgotPasswordPage(),
    // ),
    GetPage(
      name: passwordReset,
      page: () => PasswordResetPage(),
    ),

    // صفحات المنتجات
    GetPage(
      name: newItems,
      page: () => NewItemsPage(),
    ),
    // GetPage(
    //   name: popularItems,
    //   page: () => PopularItemsPage(),
    // ),
    GetPage(
      name: bundleProduct,
      page: () => BundleProductDetailsPage(),
    ),
    // GetPage(
    //   name: createMyPack,
    //   page: () => CreateMyPackPage(),
    // ),
    GetPage(
      name: bundleDetailsPage,
      page: () => BundleDetailsPage(),
    ),
    GetPage(
      name: productDetails,
      page: () => ProductDetailsPage(),
    ),
    GetPage(
      name: cartPage,
      page: () => CartPage(),
    ),
    // GetPage(
    //   name: savePage,
    //   page: () => FavouriteListPage(),
    // ),
    GetPage(
      name: checkoutPage,
      page: () => CheckoutPage(),
    ),

    // صفحات حالة الطلب
    GetPage(
      name: orderSuccessfull,
      page: () => OrderSuccessfullPage(),
    ),
    GetPage(
      name: orderFailed,
      page: () => OrderFailedPage(),
    ),
    // GetPage(
    //   name: noOrderYet,
    //   page: () => NoOrderYetPage(),
    // ),

    // صفحات الفئة
    GetPage(
      name: category,
      page: () => CategoryProductPage(),
    ),
    // GetPage(
    //   name: categoryDetails,
    //   page: () => CategoryDetailsPage(),
    // ),

    // صفحات البحث
    GetPage(
      name: search,
      page: () => SearchPage(),
    ),
    GetPage(
      name: searchResult,
      page: () => SearchResultPage(),
    ),

    // صفحات الملف الشخصي والإعدادات
    GetPage(
      name: profile,
      page: () => ProfilePage(),
    ),
    // GetPage(
    //   name: myOrder,
    //   page: () => MyOrderPage(),
    // ),
    GetPage(
      name: orderDetails,
      page: () => OrderDetailsPage(),
    ),
    // GetPage(
    //   name: coupon,
    //   page: () => CouponPage(),
    // ),
    GetPage(
      name: couponDetails,
      page: () => CouponDetailsPage(),
    ),
    // GetPage(
    //   name: deliveryAddress,
    //   page: () => DeliveryAddressPage(),
    // ),
    GetPage(
      name: newAddress,
      page: () => NewAddressPage(),
    ),
    // GetPage(
    //   name: orderTracking,
    //   page: () => OrderTrackingPage(),
    // ),
    GetPage(
      name: profileEdit,
      page: () => ProfileEditPage(),
    ),
    GetPage(
      name: notifications,
      page: () => NotificationSettingsPage(),
    ),
    GetPage(
      name: settings,
      page: () => SettingsPage(),
    ),
    // GetPage(
    //   name: settingsLanguage,
    //   page: () => SettingsLanguagePage(),
    // ),
    // GetPage(
    //   name: settingsNotifications,
    //   page: () => SettingsNotificationsPage(),
    // ),
    GetPage(
      name: changePassword,
      page: () => ChangePasswordPage(),
    ),
    GetPage(
      name: changePhoneNumber,
      page: () => ChangePhoneNumberPage(),
    ),

    // صفحات المراجعة والتعليقات
    GetPage(
      name: review,
      page: () => ReviewPage(),
    ),
    GetPage(
      name: submitReview,
      page: () => SubmitReviewPage(),
    ),

    // صفحات القائمة الجانبية
    GetPage(
      name: drawerPage,
      page: () => DrawerPage(),
    ),
    GetPage(
      name: aboutUs,
      page: () => AboutUsPage(),
    ),
    GetPage(
      name: faq,
      page: () => FAQPage(),
    ),
    GetPage(
      name: termsAndConditions,
      page: () => TermsAndConditionsPage(),
    ),
    GetPage(
      name: help,
      page: () => HelpPage(),
    ),
    GetPage(
      name: contactUs,
      page: () => ContactUsPage(),
    ),

    // صفحات طريقة الدفع
    GetPage(
      name: paymentMethod,
      page: () => PaymentMethodPage(),
    ),
    // GetPage(
    //   name: paymentCardAdd,
    //   page: () => PaymentCardAddPage(),
    // ),
  ];
}

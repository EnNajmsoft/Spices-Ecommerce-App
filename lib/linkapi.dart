class AppLink {
  static const String server = "https://spices.seha-sa.in/api";

// ================================= Auth ========================== //

  static const String signUp = "$server/user/auth/register";
   static const String login  = "$server/user/auth/login";
  static const String verifyOTP  = "$server/user/auth/verifyOtp";

// ================================= ForgetPassword ========================== //

  static const String checkEmail    = "$server/forgetpassword/checkemail.php";
  static const String resetPassword = "$server/forgetpassword/resetpassword.php";
  static const String verifycodeforgetpassword = "$server/forgetpassword/verifycode.php";

// ================================= Profile ========================== //

  static const String profile = "$server/user/profile";

// ================================= products ========================== //


  static const String productsFetch   = "$server/products";
  static const String categoriesFetch = "$server/attribute/categories";

// ================================= favorites ========================== //

  static const String favoritesFetch = "$server/user/favorites";
  static const String addFavorite    = "$server/user/favorites";
  static const String removeFavorite = "$server/user/favorites";

// ================================= cart ========================== //

  static const String cartFetch  = "$server/user/cart";
  static const String cartAdd    = "$server/user/cart";
  static const String cartUpdate = "$server/user/cart";
  static const String cartRemove = "$server/user/cart";
  static const String cartClear  = "$server/user/cart";


//============================order =============================//

  static const String ordersFetch = "$server/user/orders";
  static const String orderCreate = "$server/user/orders/create";
  static const String orderCancel = "$server/user/orders/cancel";
  static const String couponApply = "$server/user/coupon/apply";
}

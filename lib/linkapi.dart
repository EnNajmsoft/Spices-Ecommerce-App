class AppLink {
  static const String server = "https://spices-ecommerce.test/api";


// ================================= Auth ========================== //

  static const String signUp = "$server/user/auth/register";
  static const String login = "$server/user/auth/login";
// ================================= ForgetPassword ========================== //

  static const String checkEmail = "$server/forgetpassword/checkemail.php";
  static const String resetPassword =
      "$server/forgetpassword/resetpassword.php";
  static const String verifycodeforgetpassword =
      "$server/forgetpassword/verifycode.php";

// ================================= products ========================== //
  static const String productsFetch = "$server/products";
  static const String categoriesFetch = "$server/categories";

// ================================= favorites ========================== //
  static const String favoritesFetch = "$server/user/favorites";
  static const String addFavorite = "$server/user/favorites";
  static const String removeFavorite = "$server/user/favorites";

// ================================= cart ========================== //
  static const String cartFetch = "$server/user/cart";
  static const String cartAdd = "$server/user/cart";
  static const String cartUpdate = "$server/user/cart";
  static const String cartRemove = "$server/user/cart";
  static const String cartClear = "$server/user/cart";



}

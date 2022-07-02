class ApiHelper {
  static final ApiHelper _instance = ApiHelper._();

  ApiHelper._();

  factory ApiHelper() => _instance;

  // Base URL
  static const String baseUrl = "https://test-ven.herokuapp.com/api/";

  // Auth
  static const String login = "login";
  static const String register = "register";
  static const String logout = "logout";

  // CRUD Product
  static const String getProduct = "get-product";
  static const String getDetail = "get-detail/";
  static const String createProduct = "create-product";
  static const String updateProduct = "update-product/";
  static const String deleteProduct = "delete-product/";
}

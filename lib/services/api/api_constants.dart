class ApiConstants {
  static const String baseUrl = "https://myntacloneappbackend-1.onrender.com";

  static const String registerEndpoint = "$baseUrl/register";
  static const String loginEndpoint = "$baseUrl/login";
  static String? token; // on production change to sharedpreference
  static String? userID; // User ID as constant
}

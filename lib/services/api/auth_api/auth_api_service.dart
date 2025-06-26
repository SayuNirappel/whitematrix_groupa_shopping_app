import 'package:whitematrix_groupa_shopping_app/services/api/api_constants.dart';
import 'package:whitematrix_groupa_shopping_app/services/api/api_helper.dart';
import 'package:whitematrix_groupa_shopping_app/services/api/auth_api/user_model.dart';

class AuthService {
  static Future<UserModel?> registerUser(String email, String password) async {
    try {
      final response = await ApiHelper.post(ApiConstants.registerEndpoint, {
        'email': email,
        'password': password,
      });

      return UserModel.fromJson(response);
    } catch (e) {
      print("Register error: $e");
      return null;
    }
  }

//   static Future<UserModel> registerUser(String email, String password) async {
//     final response = await ApiHelper.post(ApiConstants.registerEndpoint, {
//       'email': email,
//       'password': password,
//     }

//     );
// return UserModel.fromJson(response);

//     //return UserModel.fromJson(response['user']);
//   }

  static Future<UserModel?> loginUser(String email, String password) async {
    try {
      final response = await ApiHelper.post(ApiConstants.loginEndpoint, {
        'email': email,
        'password': password,
      });

      if (response.containsKey('user')) {
        ApiConstants.token = UserModel.fromJson(response).token;
        // return UserModel.fromJson(response['user']);
        return UserModel.fromJson(response);
      } else {
        // handle error - maybe throw or return null
        return null;
      }
    } catch (e) {
      print("Login error: $e");
      return null;
    }
  }
}

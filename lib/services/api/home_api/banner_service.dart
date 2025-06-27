import 'package:http/http.dart' as http;
import 'package:whitematrix_groupa_shopping_app/services/api/api_constants.dart';
import 'package:whitematrix_groupa_shopping_app/services/api/banner_model.dart';

class BannerService {
  static Future<List<String>> fetchActiveBannerImages() async {
    try {
      final url = Uri.parse("${ApiConstants.baseUrl}/get-ads");
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer ${ApiConstants.token}",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final BannerModel bannerModel = bannerModelFromJson(response.body);
        final List<String> imageUrls = bannerModel.ads
                ?.where((ad) => ad.isActive == true)
                .map((ad) => ad.image ?? '')
                .where((url) => url.isNotEmpty)
                .toList() ??
            [];
        return imageUrls;
      } else {
        throw Exception("Failed to fetch banners: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching banners: $e");
      return [];
    }
  }
}

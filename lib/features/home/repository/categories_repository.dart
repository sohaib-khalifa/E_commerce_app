
import 'package:login_app_test/core/services/dio_service.dart';

class CategoriesRepository {
  static const String _categoriesUrl =
      'https://dummyjson.com/products/categories';

  static Future<List<String>> fetchCategories() async {
    try {
      final response = await DioService.get(_categoriesUrl);

      if (response.data is List) {
        final List data = response.data as List;

        // ✅ ناخد name أو slug لو مش موجود
        return data
            .map(
              (item) => (item is Map && item['name'] != null)
                  ? item['name'].toString()
                  : (item is Map && item['slug'] != null)
                  ? item['slug'].toString()
                  : item.toString(),
            )
            .toList();
      } else {
        print("⚠️ Unexpected categories format: ${response.data}");
        return [];
      }
    } catch (e) {
      print('❌ Error fetching categories: $e');
      return [];
    }
  }
}

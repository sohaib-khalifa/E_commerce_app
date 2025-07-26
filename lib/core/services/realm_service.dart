import 'package:login_app_test/features/products/models/realm_product_model.dart';
import 'package:realm/realm.dart';

class RealmService {
  static Realm init() {
    final config = Configuration.local([RealmProduct.schema]);
    return Realm(config);
  }
}

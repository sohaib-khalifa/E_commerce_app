import 'package:login_app_test/features/products/models/product_model.dart';
import 'package:login_app_test/features/products/models/realm_product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realm/realm.dart';

/// 1. Realm Model
@RealmModel()
class _RealmProduct {
  late int id;
  late String title;
  late double price;
  late String thumbnail;
  late String category;
}

/// 2. Realm Provider
final realmProvider = Provider<Realm>((ref) {
  final config = Configuration.local([RealmProduct.schema]);
  return Realm(config);
});

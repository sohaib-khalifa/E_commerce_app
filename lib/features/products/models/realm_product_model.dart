import 'package:realm/realm.dart';

part 'realm_product_model.realm.dart'; 

@RealmModel()
class _RealmProduct {
  late int id;
  late String title;
  late double price;
  late String thumbnail;
  late String category;
}

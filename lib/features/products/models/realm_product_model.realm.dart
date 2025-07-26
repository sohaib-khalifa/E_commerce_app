// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_product_model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
class RealmProduct extends _RealmProduct
    with RealmEntity, RealmObjectBase, RealmObject {
  RealmProduct(
    int id,
    String title,
    double price,
    String thumbnail,
    String category,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'price', price);
    RealmObjectBase.set(this, 'thumbnail', thumbnail);
    RealmObjectBase.set(this, 'category', category);
  }

  RealmProduct._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get title => RealmObjectBase.get<String>(this, 'title') as String;
  @override
  set title(String value) => RealmObjectBase.set(this, 'title', value);

  @override
  double get price => RealmObjectBase.get<double>(this, 'price') as double;
  @override
  set price(double value) => RealmObjectBase.set(this, 'price', value);

  @override
  String get thumbnail =>
      RealmObjectBase.get<String>(this, 'thumbnail') as String;
  @override
  set thumbnail(String value) => RealmObjectBase.set(this, 'thumbnail', value);

  @override
  String get category =>
      RealmObjectBase.get<String>(this, 'category') as String;
  @override
  set category(String value) => RealmObjectBase.set(this, 'category', value);

  @override
  Stream<RealmObjectChanges<RealmProduct>> get changes =>
      RealmObjectBase.getChanges<RealmProduct>(this);

  @override
  Stream<RealmObjectChanges<RealmProduct>> changesFor([
    List<String>? keyPaths,
  ]) => RealmObjectBase.getChangesFor<RealmProduct>(this, keyPaths);

  @override
  RealmProduct freeze() => RealmObjectBase.freezeObject<RealmProduct>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'title': title.toEJson(),
      'price': price.toEJson(),
      'thumbnail': thumbnail.toEJson(),
      'category': category.toEJson(),
    };
  }

  static EJsonValue _toEJson(RealmProduct value) => value.toEJson();
  static RealmProduct _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'title': EJsonValue title,
        'price': EJsonValue price,
        'thumbnail': EJsonValue thumbnail,
        'category': EJsonValue category,
      } =>
        RealmProduct(
          fromEJson(id),
          fromEJson(title),
          fromEJson(price),
          fromEJson(thumbnail),
          fromEJson(category),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(RealmProduct._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
      ObjectType.realmObject,
      RealmProduct,
      'RealmProduct',
      [
        SchemaProperty('id', RealmPropertyType.int),
        SchemaProperty('title', RealmPropertyType.string),
        SchemaProperty('price', RealmPropertyType.double),
        SchemaProperty('thumbnail', RealmPropertyType.string),
        SchemaProperty('category', RealmPropertyType.string),
      ],
    );
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

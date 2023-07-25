// To parse this JSON data, do
//
//     final groceryModel = groceryModelFromJson(jsonString);

import 'dart:convert';

GroceryModel groceryModelFromJson(String str) => GroceryModel.fromJson(json.decode(str));

String groceryModelToJson(GroceryModel data) => json.encode(data.toJson());

class GroceryModel {
  List<Item>? items;

  GroceryModel({
     this.items,
  });

  factory GroceryModel.fromJson(Map<String, dynamic> json) => GroceryModel(
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class Item {
  String itemId;
  bool isMarketPlaceItem;
  List<Image> images;
  Price? price;
  String? description;
  String title;
  String brand;
  ProductType productType;
  Properties properties;
  String? customerRating;

  Item({
    required this.itemId,
    required this.isMarketPlaceItem,
    required this.images,
    this.price,
    this.description,
    required this.title,
    required this.brand,
    required this.productType,
    required this.properties,
    this.customerRating,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    itemId: json["itemId"],
    isMarketPlaceItem: json["isMarketPlaceItem"],
    images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    price: json["price"] == null ? null : Price.fromJson(json["price"]),
    description: json["description"],
    title: json["title"],
    brand: json["brand"],
    productType: productTypeValues.map[json["productType"]]!,
    properties: Properties.fromJson(json["properties"]),
    customerRating: json["customerRating"],
  );

  Map<String, dynamic> toJson() => {
    "itemId": itemId,
    "isMarketPlaceItem": isMarketPlaceItem,
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
    "price": price?.toJson(),
    "description": description,
    "title": title,
    "brand": brand,
    "productType": productTypeValues.reverse[productType],
    "properties": properties.toJson(),
    "customerRating": customerRating,
  };
}

class Image {
  String url;

  Image({
    required this.url,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
  };
}

class Price {
  String amount;
  Currency currency;

  Price({
    required this.amount,
    required this.currency,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
    amount: json["amount"],
    currency: currencyValues.map[json["currency"]]!,
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "currency": currencyValues.reverse[currency],
  };
}

enum Currency { USD }

final currencyValues = EnumValues({
  "USD": Currency.USD
});

enum ProductType { REGULAR, VARIANT }

final productTypeValues = EnumValues({
  "REGULAR": ProductType.REGULAR,
  "VARIANT": ProductType.VARIANT
});

class Properties {
  List<String> categories;
  bool nextDayEligible;
  String? numReviews;
  String? variantItemsNum;
  Variants? variants;

  Properties({
    required this.categories,
    required this.nextDayEligible,
    this.numReviews,
    this.variantItemsNum,
    this.variants,
  });

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
    categories: List<String>.from(json["categories"].map((x) => x)),
    nextDayEligible: json["next_day_eligible"],
    numReviews: json["num_reviews"],
    variantItemsNum: json["variant_items_num"],
    variants: json["variants"] == null ? null : Variants.fromJson(json["variants"]),
  );

  Map<String, dynamic> toJson() => {
    "categories": List<dynamic>.from(categories.map((x) => x)),
    "next_day_eligible": nextDayEligible,
    "num_reviews": numReviews,
    "variant_items_num": variantItemsNum,
    "variants": variants?.toJson(),
  };
}

class Variants {
  List<VariantMeta> variantMeta;
  List<VariantDatum> variantData;

  Variants({
    required this.variantMeta,
    required this.variantData,
  });

  factory Variants.fromJson(Map<String, dynamic> json) => Variants(
    variantMeta: List<VariantMeta>.from(json["variantMeta"].map((x) => VariantMeta.fromJson(x))),
    variantData: List<VariantDatum>.from(json["variantData"].map((x) => VariantDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "variantMeta": List<dynamic>.from(variantMeta.map((x) => x.toJson())),
    "variantData": List<dynamic>.from(variantData.map((x) => x.toJson())),
  };
}

class VariantDatum {
  String productImageUrl;
  String itemId;
  String isAvailable;
  String title;
  List<VariantValue> variantValues;

  VariantDatum({
    required this.productImageUrl,
    required this.itemId,
    required this.isAvailable,
    required this.title,
    required this.variantValues,
  });

  factory VariantDatum.fromJson(Map<String, dynamic> json) => VariantDatum(
    productImageUrl: json["productImageUrl"],
    itemId: json["itemId"],
    isAvailable: json["isAvailable"],
    title: json["title"],
    variantValues: List<VariantValue>.from(json["variantValues"].map((x) => VariantValue.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "productImageUrl": productImageUrl,
    "itemId": itemId,
    "isAvailable": isAvailable,
    "title": title,
    "variantValues": List<dynamic>.from(variantValues.map((x) => x.toJson())),
  };
}

class VariantValue {
  String name;
  String value;

  VariantValue({
    required this.name,
    required this.value,
  });

  factory VariantValue.fromJson(Map<String, dynamic> json) => VariantValue(
    name: json["name"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "value": value,
  };
}

class VariantMeta {
  String name;

  VariantMeta({
    required this.name,
  });

  factory VariantMeta.fromJson(Map<String, dynamic> json) => VariantMeta(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

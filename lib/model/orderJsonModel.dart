// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  ListClass? list;

  OrderModel({
     this.list,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    list: ListClass.fromJson(json["list"]),
  );

  Map<String, dynamic> toJson() => {
    "list": list!.toJson(),
  };
}

class ListClass {
  Meta meta;
  Elements elements;

  ListClass({
    required this.meta,
    required this.elements,
  });

  factory ListClass.fromJson(Map<String, dynamic> json) => ListClass(
    meta: Meta.fromJson(json["meta"]),
    elements: Elements.fromJson(json["elements"]),
  );

  Map<String, dynamic> toJson() => {
    "meta": meta.toJson(),
    "elements": elements.toJson(),
  };
}

class Elements {
  List<Order> order;

  Elements({
    required this.order,
  });

  factory Elements.fromJson(Map<String, dynamic> json) => Elements(
    order: List<Order>.from(json["order"].map((x) => Order.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "order": List<dynamic>.from(order.map((x) => x.toJson())),
  };
}

class Order {
  int purchaseOrderId;
  int customerOrderId;
  String customerEmailId;
  OrderType orderType;
  int? originalCustomerOrderId;
  DateTime orderDate;
  ShippingInfo shippingInfo;
  OrderLines orderLines;

  Order({
    required this.purchaseOrderId,
    required this.customerOrderId,
    required this.customerEmailId,
    required this.orderType,
    this.originalCustomerOrderId,
    required this.orderDate,
    required this.shippingInfo,
    required this.orderLines,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    purchaseOrderId: json["purchaseOrderId"],
    customerOrderId: json["customerOrderId"],
    customerEmailId: json["customerEmailId"],
    orderType: orderTypeValues.map[json["orderType"]]!,
    originalCustomerOrderId: json["originalCustomerOrderID"],
    orderDate: DateTime.parse(json["orderDate"]),
    shippingInfo: ShippingInfo.fromJson(json["shippingInfo"]),
    orderLines: OrderLines.fromJson(json["orderLines"]),
  );

  Map<String, dynamic> toJson() => {
    "purchaseOrderId": purchaseOrderId,
    "customerOrderId": customerOrderId,
    "customerEmailId": customerEmailId,
    "orderType": orderTypeValues.reverse[orderType],
    "originalCustomerOrderID": originalCustomerOrderId,
    "orderDate": orderDate.toIso8601String(),
    "shippingInfo": shippingInfo.toJson(),
    "orderLines": orderLines.toJson(),
  };
}

class OrderLines {
  OrderLine orderLine;

  OrderLines({
    required this.orderLine,
  });

  factory OrderLines.fromJson(Map<String, dynamic> json) => OrderLines(
    orderLine: OrderLine.fromJson(json["orderLine"]),
  );

  Map<String, dynamic> toJson() => {
    "orderLine": orderLine.toJson(),
  };
}

class OrderLine {
  int lineNumber;
  Item item;
  Charges charges;
  Quantity orderLineQuantity;
  DateTime statusDate;
  OrderLineStatuses orderLineStatuses;
  Fulfillment fulfillment;

  OrderLine({
    required this.lineNumber,
    required this.item,
    required this.charges,
    required this.orderLineQuantity,
    required this.statusDate,
    required this.orderLineStatuses,
    required this.fulfillment,
  });

  factory OrderLine.fromJson(Map<String, dynamic> json) => OrderLine(
    lineNumber: json["lineNumber"],
    item: Item.fromJson(json["item"]),
    charges: Charges.fromJson(json["charges"]),
    orderLineQuantity: Quantity.fromJson(json["orderLineQuantity"]),
    statusDate: DateTime.parse(json["statusDate"]),
    orderLineStatuses: OrderLineStatuses.fromJson(json["orderLineStatuses"]),
    fulfillment: Fulfillment.fromJson(json["fulfillment"]),
  );

  Map<String, dynamic> toJson() => {
    "lineNumber": lineNumber,
    "item": item.toJson(),
    "charges": charges.toJson(),
    "orderLineQuantity": orderLineQuantity.toJson(),
    "statusDate": statusDate.toIso8601String(),
    "orderLineStatuses": orderLineStatuses.toJson(),
    "fulfillment": fulfillment.toJson(),
  };
}

class Charges {
  Charge charge;

  Charges({
    required this.charge,
  });

  factory Charges.fromJson(Map<String, dynamic> json) => Charges(
    charge: Charge.fromJson(json["charge"]),
  );

  Map<String, dynamic> toJson() => {
    "charge": charge.toJson(),
  };
}

class Charge {
  ChargeType chargeType;
  ChargeName chargeName;
  Amount chargeAmount;
  Tax? tax;

  Charge({
    required this.chargeType,
    required this.chargeName,
    required this.chargeAmount,
    this.tax,
  });

  factory Charge.fromJson(Map<String, dynamic> json) => Charge(
    chargeType: chargeTypeValues.map[json["chargeType"]]!,
    chargeName: chargeNameValues.map[json["chargeName"]]!,
    chargeAmount: Amount.fromJson(json["chargeAmount"]),
    tax: json["tax"] == null ? null : Tax.fromJson(json["tax"]),
  );

  Map<String, dynamic> toJson() => {
    "chargeType": chargeTypeValues.reverse[chargeType],
    "chargeName": chargeNameValues.reverse[chargeName],
    "chargeAmount": chargeAmount.toJson(),
    "tax": tax?.toJson(),
  };
}

class Amount {
  Currency currency;
  double amount;

  Amount({
    required this.currency,
    required this.amount,
  });

  factory Amount.fromJson(Map<String, dynamic> json) => Amount(
    currency: currencyValues.map[json["currency"]]!,
    amount: json["amount"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "currency": currencyValues.reverse[currency],
    "amount": amount,
  };
}

enum Currency { USD }

final currencyValues = EnumValues({
  "USD": Currency.USD
});

enum ChargeName { ITEM_PRICE }

final chargeNameValues = EnumValues({
  "ItemPrice": ChargeName.ITEM_PRICE
});

enum ChargeType { PRODUCT }

final chargeTypeValues = EnumValues({
  "PRODUCT": ChargeType.PRODUCT
});

class Tax {
  String taxName;
  Amount taxAmount;

  Tax({
    required this.taxName,
    required this.taxAmount,
  });

  factory Tax.fromJson(Map<String, dynamic> json) => Tax(
    taxName: json["taxName"],
    taxAmount: Amount.fromJson(json["taxAmount"]),
  );

  Map<String, dynamic> toJson() => {
    "taxName": taxName,
    "taxAmount": taxAmount.toJson(),
  };
}

class Fulfillment {
  FulfillmentOption fulfillmentOption;
  ShipMethod shipMethod;
  DateTime pickUpDateTime;

  Fulfillment({
    required this.fulfillmentOption,
    required this.shipMethod,
    required this.pickUpDateTime,
  });

  factory Fulfillment.fromJson(Map<String, dynamic> json) => Fulfillment(
    fulfillmentOption: fulfillmentOptionValues.map[json["fulfillmentOption"]]!,
    shipMethod: shipMethodValues.map[json["shipMethod"]]!,
    pickUpDateTime: DateTime.parse(json["pickUpDateTime"]),
  );

  Map<String, dynamic> toJson() => {
    "fulfillmentOption": fulfillmentOptionValues.reverse[fulfillmentOption],
    "shipMethod": shipMethodValues.reverse[shipMethod],
    "pickUpDateTime": pickUpDateTime.toIso8601String(),
  };
}

enum FulfillmentOption { S2_H }

final fulfillmentOptionValues = EnumValues({
  "S2H": FulfillmentOption.S2_H
});

enum ShipMethod { VALUE }

final shipMethodValues = EnumValues({
  "VALUE": ShipMethod.VALUE
});

class Item {
  String productName;
  Sku sku;

  Item({
    required this.productName,
    required this.sku,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    productName: json["productName"],
    sku: skuValues.map[json["sku"]]!,
  );

  Map<String, dynamic> toJson() => {
    "productName": productName,
    "sku": skuValues.reverse[sku],
  };
}

enum Sku { TEST1, TEST_02, AC004 }

final skuValues = EnumValues({
  "AC004": Sku.AC004,
  "test1": Sku.TEST1,
  "TEST-02": Sku.TEST_02
});

class Quantity {
  UnitOfMeasurement unitOfMeasurement;
  int amount;

  Quantity({
    required this.unitOfMeasurement,
    required this.amount,
  });

  factory Quantity.fromJson(Map<String, dynamic> json) => Quantity(
    unitOfMeasurement: unitOfMeasurementValues.map[json["unitOfMeasurement"]]!,
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "unitOfMeasurement": unitOfMeasurementValues.reverse[unitOfMeasurement],
    "amount": amount,
  };
}

enum UnitOfMeasurement { EACH }

final unitOfMeasurementValues = EnumValues({
  "EACH": UnitOfMeasurement.EACH
});

class OrderLineStatuses {
  OrderLineStatus orderLineStatus;

  OrderLineStatuses({
    required this.orderLineStatus,
  });

  factory OrderLineStatuses.fromJson(Map<String, dynamic> json) => OrderLineStatuses(
    orderLineStatus: OrderLineStatus.fromJson(json["orderLineStatus"]),
  );

  Map<String, dynamic> toJson() => {
    "orderLineStatus": orderLineStatus.toJson(),
  };
}

class OrderLineStatus {
  Status status;
  Quantity statusQuantity;
  TrackingInfo? trackingInfo;

  OrderLineStatus({
    required this.status,
    required this.statusQuantity,
    this.trackingInfo,
  });

  factory OrderLineStatus.fromJson(Map<String, dynamic> json) => OrderLineStatus(
    status: statusValues.map[json["status"]]!,
    statusQuantity: Quantity.fromJson(json["statusQuantity"]),
    trackingInfo: json["trackingInfo"] == null ? null : TrackingInfo.fromJson(json["trackingInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "status": statusValues.reverse[status],
    "statusQuantity": statusQuantity.toJson(),
    "trackingInfo": trackingInfo?.toJson(),
  };
}

enum Status { CREATED, CANCELLED, SHIPPED }

final statusValues = EnumValues({
  "Cancelled": Status.CANCELLED,
  "Created": Status.CREATED,
  "Shipped": Status.SHIPPED
});

class TrackingInfo {
  DateTime shipDateTime;
  CarrierName carrierName;
  MethodCode methodCode;
  double trackingNumber;
  String trackingUrl;

  TrackingInfo({
    required this.shipDateTime,
    required this.carrierName,
    required this.methodCode,
    required this.trackingNumber,
    required this.trackingUrl,
  });

  factory TrackingInfo.fromJson(Map<String, dynamic> json) => TrackingInfo(
    shipDateTime: DateTime.parse(json["shipDateTime"]),
    carrierName: CarrierName.fromJson(json["carrierName"]),
    methodCode: methodCodeValues.map[json["methodCode"]]!,
    trackingNumber: json["trackingNumber"]?.toDouble(),
    trackingUrl: json["trackingURL"],
  );

  Map<String, dynamic> toJson() => {
    "shipDateTime": shipDateTime.toIso8601String(),
    "carrierName": carrierName.toJson(),
    "methodCode": methodCodeValues.reverse[methodCode],
    "trackingNumber": trackingNumber,
    "trackingURL": trackingUrl,
  };
}

class CarrierName {
  String? otherCarrier;
  String? carrier;

  CarrierName({
    this.otherCarrier,
    this.carrier,
  });

  factory CarrierName.fromJson(Map<String, dynamic> json) => CarrierName(
    otherCarrier: json["otherCarrier"],
    carrier: json["carrier"],
  );

  Map<String, dynamic> toJson() => {
    "otherCarrier": otherCarrier,
    "carrier": carrier,
  };
}

enum MethodCode { VALUE }

final methodCodeValues = EnumValues({
  "Value": MethodCode.VALUE
});

enum OrderType { REPLACEMENT, REGULAR }

final orderTypeValues = EnumValues({
  "REGULAR": OrderType.REGULAR,
  "REPLACEMENT": OrderType.REPLACEMENT
});

class ShippingInfo {
  int phone;
  DateTime estimatedDeliveryDate;
  DateTime estimatedShipDate;
  MethodCode methodCode;
  PostalAddress postalAddress;

  ShippingInfo({
    required this.phone,
    required this.estimatedDeliveryDate,
    required this.estimatedShipDate,
    required this.methodCode,
    required this.postalAddress,
  });

  factory ShippingInfo.fromJson(Map<String, dynamic> json) => ShippingInfo(
    phone: json["phone"],
    estimatedDeliveryDate: DateTime.parse(json["estimatedDeliveryDate"]),
    estimatedShipDate: DateTime.parse(json["estimatedShipDate"]),
    methodCode: methodCodeValues.map[json["methodCode"]]!,
    postalAddress: PostalAddress.fromJson(json["postalAddress"]),
  );

  Map<String, dynamic> toJson() => {
    "phone": phone,
    "estimatedDeliveryDate": estimatedDeliveryDate.toIso8601String(),
    "estimatedShipDate": estimatedShipDate.toIso8601String(),
    "methodCode": methodCodeValues.reverse[methodCode],
    "postalAddress": postalAddress.toJson(),
  };
}

class PostalAddress {
  String name;
  String address1;
  String? address2;
  String city;
  String state;
  int postalCode;
  Country country;
  AddressType addressType;

  PostalAddress({
    required this.name,
    required this.address1,
    this.address2,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    required this.addressType,
  });

  factory PostalAddress.fromJson(Map<String, dynamic> json) => PostalAddress(
    name: json["name"],
    address1: json["address1"],
    address2: json["address2"],
    city: json["city"],
    state: json["state"],
    postalCode: json["postalCode"],
    country: countryValues.map[json["country"]]!,
    addressType: addressTypeValues.map[json["addressType"]]!,
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "address1": address1,
    "address2": address2,
    "city": city,
    "state": state,
    "postalCode": postalCode,
    "country": countryValues.reverse[country],
    "addressType": addressTypeValues.reverse[addressType],
  };
}

enum AddressType { RESIDENTIAL }

final addressTypeValues = EnumValues({
  "RESIDENTIAL": AddressType.RESIDENTIAL
});

enum Country { USA }

final countryValues = EnumValues({
  "USA": Country.USA
});

class Meta {
  int totalCount;
  int limit;
  String nextCursor;

  Meta({
    required this.totalCount,
    required this.limit,
    required this.nextCursor,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    totalCount: json["totalCount"],
    limit: json["limit"],
    nextCursor: json["nextCursor"],
  );

  Map<String, dynamic> toJson() => {
    "totalCount": totalCount,
    "limit": limit,
    "nextCursor": nextCursor,
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

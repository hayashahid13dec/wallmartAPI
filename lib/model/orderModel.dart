import 'package:xml/xml.dart';

class OrderList {
  Meta? meta;
  List<Order>? elements;

  OrderList({this.meta, this.elements});

  factory OrderList.fromXml(XmlElement xml) {
    return OrderList(
      meta: Meta.fromXml(xml.findElements('meta').single),
      elements: xml.findElements('order').map((e) => Order.fromXml(e)).toList(),
    );
  }
}

class Meta {
  int? totalCount;
  int? limit;
  String? nextCursor;

  Meta({this.totalCount, this.limit, this.nextCursor});

  factory Meta.fromXml(XmlElement xml) {
    return Meta(
      totalCount: int.parse(xml.findElements('totalCount').single.text),
      limit: int.parse(xml.findElements('limit').single.text),
      nextCursor: xml.findElements('nextCursor').single.text,
    );
  }
}

class Order {
  String? purchaseOrderId;
  String? customerOrderId;
  String? customerEmailId;
  String? orderType;
  String? originalCustomerOrderId;
  DateTime? orderDate;
  ShippingInfo? shippingInfo;
  List<OrderLine>? orderLines;

  Order({
    this.purchaseOrderId,
    this.customerOrderId,
    this.customerEmailId,
    this.orderType,
    this.originalCustomerOrderId,
    this.orderDate,
    this.shippingInfo,
    this.orderLines,
  });

  factory Order.fromXml(XmlElement xml) {
    return Order(
      purchaseOrderId: xml.findElements('purchaseOrderId').single.text,
      customerOrderId: xml.findElements('customerOrderId').single.text,
      customerEmailId: xml.findElements('customerEmailId').single.text,
      orderType: xml.findElements('orderType').single.text,
      originalCustomerOrderId: xml.findElements('originalCustomerOrderID').single.text,
      orderDate: DateTime.parse(xml.findElements('orderDate').single.text),
      shippingInfo: ShippingInfo.fromXml(xml.findElements('shippingInfo').single),
      orderLines: xml.findElements('orderLines').map((e) => OrderLine.fromXml(e)).toList(),
    );
  }
}

class ShippingInfo {
  String? phone;
  DateTime? estimatedDeliveryDate;
  DateTime? estimatedShipDate;
  String? methodCode;
  PostalAddress? postalAddress;

  ShippingInfo({
    this.phone,
    this.estimatedDeliveryDate,
    this.estimatedShipDate,
    this.methodCode,
    this.postalAddress,
  });

  factory ShippingInfo.fromXml(XmlElement xml) {
    return ShippingInfo(
      phone: xml.findElements('phone').single.text,
      estimatedDeliveryDate: DateTime.parse(xml.findElements('estimatedDeliveryDate').single.text),
      estimatedShipDate: DateTime.parse(xml.findElements('estimatedShipDate').single.text),
      methodCode: xml.findElements('methodCode').single.text,
      postalAddress: PostalAddress.fromXml(xml.findElements('postalAddress').single),
    );
  }
}

class PostalAddress {
  String? name;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? postalCode;
  String? country;
  String? addressType;

  PostalAddress({
    this.name,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.postalCode,
    this.country,
    this.addressType,
  });

  factory PostalAddress.fromXml(XmlElement xml) {
    return PostalAddress(
      name: xml.findElements('name').single.text,
      address1: xml.findElements('address1').single.text,
      address2: xml.findElements('address2').single.text,
      city: xml.findElements('city').single.text,
      state: xml.findElements('state').single.text,
      postalCode: xml.findElements('postalCode').single.text,
      country: xml.findElements('country').single.text,
      addressType: xml.findElements('addressType').single.text,
    );
  }
}

class OrderLine {
  int? lineNumber;
  Item? item;
  Charges? charges;
  OrderLineQuantity? orderLineQuantity;
  DateTime? statusDate;
  OrderLineStatuses? orderLineStatuses;
  Fulfillment? fulfillment;

  OrderLine({
    this.lineNumber,
    this.item,
    this.charges,
    this.orderLineQuantity,
    this.statusDate,
    this.orderLineStatuses,
    this.fulfillment,
  });

  factory OrderLine.fromXml(XmlElement xml) {
    return OrderLine(
      lineNumber: int.parse(xml.findElements('lineNumber').single.text),
      item: Item.fromXml(xml.findElements('item').single),
      charges: Charges.fromXml(xml.findElements('charges').single),
      orderLineQuantity: OrderLineQuantity.fromXml(xml.findElements('orderLineQuantity').single),
      statusDate: DateTime.parse(xml.findElements('statusDate').single.text),
      orderLineStatuses: OrderLineStatuses.fromXml(xml.findElements('orderLineStatuses').single),
      fulfillment: Fulfillment.fromXml(xml.findElements('fulfillment').single),
    );
  }
}

class Item {
  String? productName;
  String? sku;

  Item({this.productName, this.sku});

  factory Item.fromXml(XmlElement xml) {
    return Item(
      productName: xml.findElements('productName').single.text,
      sku: xml.findElements('sku').single.text,
    );
  }
}

class Charges {
  String? chargeType;
  String? chargeName;
  ChargeAmount? chargeAmount;
  TaxAmount? tax;

  Charges({this.chargeType, this.chargeName, this.chargeAmount, this.tax});

  factory Charges.fromXml(XmlElement xml) {
    return Charges(
      chargeType: xml.findElements('chargeType').single.text,
      chargeName: xml.findElements('chargeName').single.text,
      chargeAmount: ChargeAmount.fromXml(xml.findElements('chargeAmount').single),
      tax: TaxAmount.fromXml(xml.findElements('taxAmount').single),
    );
  }
}

class ChargeAmount {
  String? currency;
  double? amount;

  ChargeAmount({this.currency, this.amount});

  factory ChargeAmount.fromXml(XmlElement xml) {
    return ChargeAmount(
      currency: xml.findElements('currency').single.text,
      amount: double.parse(xml.findElements('amount').single.text),
    );
  }
}

class TaxAmount {
  String? currency;
  double? amount;

  TaxAmount({this.currency, this.amount});

  factory TaxAmount.fromXml(XmlElement xml) {
    return TaxAmount(
      currency: xml.findElements('currency').single.text,
      amount: double.parse(xml.findElements('amount').single.text),
    );
  }
}

class OrderLineQuantity {
  String? unitOfMeasurement;
  double? amount;

  OrderLineQuantity({this.unitOfMeasurement, this.amount});

  factory OrderLineQuantity.fromXml(XmlElement xml) {
    return OrderLineQuantity(
      unitOfMeasurement: xml.findElements('unitOfMeasurement').single.text,
      amount: double.parse(xml.findElements('amount').single.text),
    );
  }
}

class OrderLineStatuses {
  String? status;
  int? statusQuantity;

  OrderLineStatuses({this.status, this.statusQuantity});

  factory OrderLineStatuses.fromXml(XmlElement xml) {
    return OrderLineStatuses(
      status: xml.findElements('status').single.text,
      statusQuantity: int.parse(xml.findElements('statusQuantity').single.text),
    );
  }
}

class Fulfillment {
  DateTime? fulfillmentDate;

  Fulfillment({this.fulfillmentDate});

  factory Fulfillment.fromXml(XmlElement xml) {
    return Fulfillment(
      fulfillmentDate: DateTime.parse(xml.findElements('fulfillmentDate').single.text),
    );
  }
}

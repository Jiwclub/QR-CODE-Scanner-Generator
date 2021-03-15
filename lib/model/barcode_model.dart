// To parse this JSON data, do
//
//     final barCodeModel = barCodeModelFromJson(jsonString);

import 'dart:convert';

BarCodeModel barCodeModelFromJson(String str) => BarCodeModel.fromJson(json.decode(str));

String barCodeModelToJson(BarCodeModel data) => json.encode(data.toJson());

class BarCodeModel {
    BarCodeModel({
        this.barcode,
        this.categoryName,
        this.name,
        this.priceAverage,
        this.image,
    });

    String barcode;
    String categoryName;
    String name;
    int priceAverage;
    String image;

    factory BarCodeModel.fromJson(Map<String, dynamic> json) => BarCodeModel(
        barcode: json["barcode"],
        categoryName: json["categoryName"],
        name: json["name"],
        priceAverage: json["price_average"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "barcode": barcode,
        "categoryName": categoryName,
        "name": name,
        "price_average": priceAverage,
        "image": image,
    };
}

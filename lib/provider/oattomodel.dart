import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import '../model/addressmodel.dart';
import '../model/cartmodel.dart';
import '../model/productmodel.dart';

class OattoModel with ChangeNotifier, DiagnosticableTreeMixin {
  List<todo> productList = []; // รายการสินค้า
  List<Cart> cartList = []; // ตะกร้าสินค้า
  List<Cart> selectedCartItems = []; // รายการรวมหน้าสั่งซื้อ
  bool? checkOrder;

  // เพิ่มฟังก์ชั่นสำหรับการสร้างข้อมูลใหม่ลงในรายการ
  void createProduct(
      {required String productName,
      required String desc,
      required int productCount,
      required double productPrice,
      required String productImg}) {
    String uuid = const Uuid().v4(); // สร้าง uuid ใหม่
    String createdAt = DateTime.now().toString(); // วันที่เวลาปัจจุบัน

    todo newProduct = todo(
      uuid: uuid,
      productName: productName,
      desc: desc,
      productCount: productCount,
      productPrice: productPrice,
      productImg: productImg,
      createdAt: createdAt,
    );

    productList.add(newProduct); // เพิ่มข้อมูลใหม่ลงในรายการ
    notifyListeners(); // แจ้งเตือน listener ว่ามีการเปลี่ยนแปลงใน model
  }

  // เพิ่มฟังก์ชันสำหรับการแก้ไขข้อมูลในรายการ
  void updateProduct(
      {required String uuid,
      String? productName,
      String? desc,
      int? productCount,
      double? productPrice,
      String? productImg}) {
    todo? productToUpdate = productList
        // ignore: null_check_always_fails
        .firstWhere((product) => product.uuid == uuid, orElse: () => null!);

    if (productName != null) productToUpdate.productName = productName;
    if (desc != null) productToUpdate.desc = desc;
    if (productCount != null) productToUpdate.productCount = productCount;
    if (productPrice != null) productToUpdate.productPrice = productPrice;
    if (productImg != null) productToUpdate.productImg = productImg;

    notifyListeners(); // แจ้งเตือน listener ว่ามีการเปลี่ยนแปลงใน model
  }

  // เพิ่มฟังก์ชันสำหรับลบข้อมูลในรายการโดยใช้ UUID
  void deleteProductByUuid(String uuid) {
    productList.removeWhere((product) => product.uuid == uuid);
    notifyListeners(); // แจ้งเตือน listener ว่ามีการเปลี่ยนแปลงใน model
  }

  void addToCart(int index, BuildContext context) {
    // ตรวจสอบว่า index ที่รับมามีค่าที่ถูกต้องหรือไม่
    if (index >= 0 && index < productList.length) {
      todo productToAdd =
          productList[index]; // เลือกสินค้าจาก productList โดยใช้ index
      int existingIndex =
          cartList.indexWhere((cartItem) => cartItem.uuid == productToAdd.uuid);

      // ตรวจสอบว่า valCount ในตะกร้ามีค่าเท่ากับหรือน้อยกว่า productCount หรือไม่
      if (existingIndex != -1 &&
          (cartList[existingIndex].valcount ?? 0) <
              productToAdd.productCount!) {
        // เพิ่มค่า valcount เฉพาะเมื่อไม่ null
        cartList[existingIndex].valcount =
            (cartList[existingIndex].valcount ?? 0) + 1;
        final snackBar = SnackBar(
          content: Text(
            'เพิ่มตะกร้าสินค้าสำเร็จ',
            style: GoogleFonts.prompt(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (existingIndex == -1) {
        Cart newCartItem = Cart(
            uuid: productToAdd.uuid,
            productName: productToAdd.productName,
            desc: productToAdd.desc,
            productCount: productToAdd.productCount,
            productPrice: productToAdd.productPrice,
            productImg: productToAdd.productImg,
            createdAt: productToAdd.createdAt,
            valcount: 1,
            check: false);
        cartList.add(newCartItem); // เพิ่มข้อมูลใหม่ลงในรายการ cart
        final snackBar = SnackBar(
          content: Text(
            'เพิ่มตะกร้าสินค้าสำเร็จ',
            style: GoogleFonts.prompt(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        // แจ้งเตือนผู้ใช้ว่าไม่สามารถเพิ่มสินค้าได้เนื่องจากเกินจำนวนที่มีอยู่
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'ไม่สามารถเพิ่มสินค้าได้',
                style: GoogleFonts.prompt(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              content: Text(
                'เกินจำนวนสินค้าที่มีอยู่แล้วในระบบ',
                style: GoogleFonts.prompt(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // ปิด Alert Dialog
                  },
                  child: Text(
                    'ตกลง',
                    style: GoogleFonts.prompt(
                      fontSize: 14,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            );
          },
        );
        print('Cannot add more items. Exceeds available quantity.');
      }
      notifyListeners(); // แจ้งเตือน listener ว่ามีการเปลี่ยนแปลงใน model
    } else {
      // หาก index ไม่ถูกต้อง แสดงข้อความแจ้งเตือน
      print('Invalid index');
    }
  }

  double totalPrice = 0.0;
  int totalValCount = 0;

  void updateCartItemQty(String uuid, int newQty) {
    // หาตำแหน่งของสินค้าใน cartList ที่ตรงกับ uuid ที่กำหนด
    int index = cartList.indexWhere((cartItem) => cartItem.uuid == uuid);
    // ตรวจสอบว่าตำแหน่งของสินค้าที่หาได้มีค่าที่ถูกต้องหรือไม่
    if (index != -1) {
      // อัปเดตจำนวนสินค้าในตะกร้า
      cartList[index].valcount = newQty;
      // หากจำนวนสินค้าใหม่เป็น 0 ให้ลบสินค้าออกจากตะกร้า
      if (newQty == 0) {
        cartList.removeAt(index);
      }
      totalPrice = calculateTotalPrice();
      notifyListeners(); // แจ้งเตือน listener ว่ามีการเปลี่ยนแปลงใน model
    } else {
      // หากไม่พบสินค้าที่ต้องการอัปเดต ให้แสดงข้อความแจ้งเตือน
      print('Product not found in cart');
    }
  }

  void removeCartItem(String uuid, int newQty) {
    int index = cartList.indexWhere((cartItem) => cartItem.uuid == uuid);
    cartList.removeAt(index);
    notifyListeners();
  }

  double calculateTotalPrice() {
    double totalPrice = 0.0;
    for (int i = 0; i < cartList.length; i++) {
      if (cartList[i].check == true) {
        totalPrice += cartList[i].productPrice! * cartList[i].valcount!;
        totalValCount = cartList[i].valcount!;
      }
    }
    return totalPrice;
  }

  List<dynamic> selectproductprice = [];
  List<dynamic> valselect = [];
  dynamic valvalue;
  double lastTotalPrice = 0;

  void calculateTotal() {
    double total = 0;
    for (var item in selectproductprice) {
      // ignore: unused_local_variable
      for (var item1 in valselect) {
        double productPrice = item['productPrice'] ?? 0; // ราคาสินค้า
        // int val = item['val']  ?? 0; // จำนวนสินค้าที่เลือก
        total += productPrice * item['val'];
      }
    }
    lastTotalPrice = total;
    notifyListeners();
  }

  lasttotalprice(double value) {
    lastTotalPrice = value;
    notifyListeners();
  }

// Address Page
  List<AddressButton> AddressList = [];
  Iterable<String> provinces = [];
  List<String> amphoes = [];
  List<String> tambons = [];
  String? AddressName;
  String? AddressPhone;
  String? AddressText;
  String? selectedProvince;
  String? selectedAmphoe;
  String? selectedTambon;
  String? selectedZipcode;
  int? selectedOption;

  Future<void> fetchProvinces() async {
    final response =
        await http.get(Uri.parse('https://ckartisan.com/api/provinces'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      provinces =
          data.map<String>((item) => item['province'].toString()).toList();
    } else {
      print('Failed to fetch provinces. Error: ${response.statusCode}');
    }
    notifyListeners();
  }

  Future<void> fetchAmphoes() async {
    final response = await http.get(Uri.parse(
        'https://ckartisan.com/api/amphoes?province=$selectedProvince'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      amphoes = data.map<String>((item) => item['amphoe'].toString()).toList();
    } else {
      print('Failed to fetch amphoes. Error: ${response.statusCode}');
    }
    notifyListeners();
  }

  Future<void> fetchTambons() async {
    final response = await http.get(Uri.parse(
        'https://ckartisan.com/api/tambons?province=$selectedProvince&amphoe=$selectedAmphoe'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      tambons = data.map<String>((item) => item['tambon'].toString()).toList();
    } else {
      print('Failed to fetch tambons. Error: ${response.statusCode}');
    }
    notifyListeners();
  }

  Future<void> fetchZipcode() async {
    final response = await http.get(Uri.parse(
        'https://ckartisan.com/api/zipcodes?province=$selectedProvince&amphoe=$selectedAmphoe&tambon=$selectedTambon'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      selectedZipcode = data[0]['zipcode'];
    } else {
      print('Failed to fetch zipcode. Error: ${response.statusCode}');
    }
    notifyListeners();
  }

  void addAddressButton() {
    AddressButton newAddressItem = AddressButton(
      addressName: AddressName,
      addressPhone: AddressPhone,
      addressText: AddressText,
      selectedProvince: selectedProvince,
      selectedAmphoe: selectedAmphoe,
      selectedTambon: selectedTambon,
      selectedZipcode: selectedZipcode,
    );
    AddressList.add(newAddressItem);
    notifyListeners();
  }

  void editAddressButton(int index, AddressButton updatedAddressItem) {
    if (index >= 0 && index < AddressList.length) {
      // แก้ไขข้อมูลใน AddressList ที่ตำแหน่งที่ระบุ
      AddressList[index] = updatedAddressItem;
      AddressName = updatedAddressItem.addressName;
      AddressPhone = updatedAddressItem.addressPhone;
      AddressText = updatedAddressItem.addressText;
      // แจ้งให้ฟังเกี่ยวกับการอัพเดทข้อมูล
      notifyListeners();
    }
  }

  void selectDelivery(
    int index,
  ) {
    selectedOption = index;
    notifyListeners();
  }
}

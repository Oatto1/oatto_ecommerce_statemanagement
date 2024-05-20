import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../provider/oattomodel.dart';
import '../style/colors.dart';
import '../style/textstyle.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController nameProductController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController productCountController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  XFile? _imageFile;
  final _formKey = GlobalKey<FormState>();
  bool? checkimage;

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8),
                  child: SizedBox(
                    child: Text(
                      "Add Product",
                      style: mainProductName,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name Product", style: mainProductText14),
                      TextFormField(
                        controller: nameProductController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a product name';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Description", style: mainProductText14),
                      TextFormField(
                        controller: descController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Product Count", style: mainProductText14),
                      TextFormField(
                        controller: productCountController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the product count';
                          } else if (int.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Product Price", style: mainProductText14),
                      TextFormField(
                        controller: productPriceController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the product price';
                          } else if (double.tryParse(value) == null) {
                            return 'Please enter a valid price';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    if (_imageFile == null)
                      InkWell(
                        onTap: () async {
                          if (_imageFile == null) {
                            final XFile? image = await _picker.pickImage(
                                source: ImageSource.gallery);
                            setState(() {
                              _imageFile = image!;
                              checkimage = true;
                            });
                          } else {}
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(top: 16.0),
                          child: Center(
                            child: Icon(
                              Icons.image,
                              size: 50,
                              color: deepPurple,
                            ),
                          ),
                        ),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          height: 150,
                          child: Image.file(
                            File(_imageFile!.path),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    if (checkimage == false)
                      Text("Please enter the picture", style: textAlert12)
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // ตรวจสอบว่า _imageFile เป็น null หรือไม่
                          if (_formKey.currentState!.validate() ||
                              checkimage == true) {
                            // ดำเนินการสร้างผลิตภัณฑ์เมื่อฟอร์มผ่านการตรวจสอบ
                            int productCount =
                                int.tryParse(productCountController.text) ?? 0;
                            Provider.of<OattoModel>(context, listen: false)
                                .createProduct(
                              productName: nameProductController.text,
                              desc: descController.text,
                              productCount: productCount,
                              productPrice:
                                  double.parse(productPriceController.text),
                              productImg: _imageFile!.path,
                            );

                            // ล้างข้อมูลในฟอร์ม
                            // nameProductController.clear();
                            // descController.clear();
                            // productCountController.clear();
                            // productPriceController.clear();

                            // ปิดหน้า context

                            QuickAlert.show(
                              context: context,
                              onConfirmBtnTap: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              type: QuickAlertType.success,
                              text: 'Create Product Completed Successfully!',
                              confirmBtnColor: Colors.deepPurple,
                              confirmBtnTextStyle: TextStyle(
                                fontSize: 14,
                                color: white,
                                fontWeight: FontWeight.w400,
                              ),
                            );
                          } else {
                            setState(() {
                              checkimage = false;
                            });
                          }
                        },
                        child: Text(
                          "Create",
                          style: text12white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Close",
                          style: text12white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

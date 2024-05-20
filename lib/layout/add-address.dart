import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../model/addressmodel.dart';
import '../provider/oattomodel.dart';
import '../style/colors.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController subdistrict = TextEditingController();
  final TextEditingController district = TextEditingController();
  final TextEditingController zipcode = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final oattoModel = Provider.of<OattoModel>(context, listen: false);
    name.text = oattoModel.AddressName ?? '';
    phone.text = oattoModel.AddressPhone ?? '';
    address.text = oattoModel.AddressText ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Consumer<OattoModel>(builder: (context, oattoModel, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 22.0, left: 22),
                  child: Text(
                    "เพิ่มที่อยู่จัดส่ง",
                    style: GoogleFonts.prompt(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: TextFormField(
                                    style: GoogleFonts.prompt(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade500,
                                            width: 1),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          15.0, 0, 15.0, 0),
                                      labelText: "ชื่อ - นามสกุลผู้รับ",
                                      labelStyle: const TextStyle(
                                        color: Color.fromRGBO(207, 205, 205, 1),
                                      ),
                                    ),
                                    controller: name,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.all(5)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: TextFormField(
                                    style: GoogleFonts.prompt(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade500,
                                            width: 1),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          15.0, 0, 15.0, 0),
                                      labelText: "เบอร์โทรศัพท์มือถือ",
                                      labelStyle: const TextStyle(
                                        color: Color.fromRGBO(207, 205, 205, 1),
                                      ),
                                    ),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    keyboardType: TextInputType.phone,
                                    controller: phone,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.all(5)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: TextFormField(
                                    style: GoogleFonts.prompt(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade500,
                                            width: 1),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          15.0, 0, 15.0, 0),
                                      labelText:
                                          "บ้านเลขที่ , ซอย , หมู่ , ถนน",
                                      labelStyle: const TextStyle(
                                        color: Color.fromRGBO(207, 205, 205, 1),
                                      ),
                                    ),
                                    controller: address,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.all(5)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DropdownButtonFormField<String>(
                                dropdownColor: white,
                                value: oattoModel.selectedProvince,
                                hint: Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    "จังหวัด",
                                    style: GoogleFonts.prompt(
                                      fontSize: 12,
                                      color: const Color.fromRGBO(
                                          207, 205, 205, 1),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                items: oattoModel.provinces
                                    .map<DropdownMenuItem<String>>((province) {
                                  final String provinceName = province;
                                  return DropdownMenuItem<String>(
                                    value: provinceName,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Text(
                                        provinceName,
                                        style: GoogleFonts.prompt(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    oattoModel.selectedProvince = value;
                                    oattoModel.selectedAmphoe = null;
                                    oattoModel.selectedTambon = null;
                                    oattoModel.selectedZipcode = null;
                                    oattoModel.amphoes.clear();
                                    oattoModel.tambons.clear();
                                    oattoModel.fetchAmphoes();
                                  });
                                },
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade500, width: 1),
                                  ),
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                ),
                                itemHeight: 48.0,
                              ),
                              const Padding(padding: EdgeInsets.all(5)),
                              DropdownButtonFormField<String>(
                                dropdownColor: white,
                                value: oattoModel.selectedAmphoe,
                                hint: Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    "เขต/อำเภอ",
                                    style: GoogleFonts.prompt(
                                        fontSize: 12,
                                        color: const Color.fromRGBO(
                                            207, 205, 205, 1),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                items: oattoModel.amphoes
                                    .map<DropdownMenuItem<String>>((amphoe) {
                                  return DropdownMenuItem<String>(
                                    value: amphoe,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Text(
                                        amphoe,
                                        style: GoogleFonts.prompt(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    oattoModel.selectedAmphoe = value;
                                    oattoModel.selectedTambon = null;
                                    oattoModel.selectedZipcode = null;
                                    oattoModel.tambons.clear();
                                    oattoModel.fetchTambons();
                                  });
                                },
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade500, width: 1),
                                  ),
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                ),
                                itemHeight: 48.0,
                              ),
                              const Padding(padding: EdgeInsets.all(5)),
                              DropdownButtonFormField<String>(
                                dropdownColor: white,
                                value: oattoModel.selectedTambon,
                                hint: Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    "แขวง/ตำบล",
                                    style: GoogleFonts.prompt(
                                        fontSize: 12,
                                        color: const Color.fromRGBO(
                                            207, 205, 205, 1),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                items: oattoModel.tambons
                                    .map<DropdownMenuItem<String>>((tambon) {
                                  return DropdownMenuItem<String>(
                                    value: tambon,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Text(
                                        tambon,
                                        style: GoogleFonts.prompt(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    oattoModel.selectedTambon = value;
                                    oattoModel.selectedZipcode = null;
                                    oattoModel.fetchZipcode();
                                    zipcode.clear();
                                  });
                                },
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade500, width: 1),
                                  ),
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                ),
                                itemHeight: 48.0,
                              ),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.all(5)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: TextFormField(
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    keyboardType: TextInputType.phone,
                                    style: GoogleFonts.prompt(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade500,
                                            width: 1),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          15.0, 0, 15.0, 0),
                                      labelText: oattoModel.selectedZipcode ??
                                          "รหัสไปรษณีย์",
                                      labelStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    controller: zipcode,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.all(5)),
                          SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (oattoModel.AddressList.isEmpty) {
                                  oattoModel.AddressName = name.text;
                                  oattoModel.AddressPhone = phone.text;
                                  oattoModel.AddressText = address.text;
                                  Provider.of<OattoModel>(context,
                                          listen: false)
                                      .addAddressButton();
                                } else {
                                  // ignore: non_constant_identifier_names
                                  AddressButton UpdateAddress = AddressButton(
                                    addressName: name.text,
                                    addressPhone: phone.text,
                                    addressText: address.text,
                                    selectedProvince:
                                        oattoModel.selectedProvince,
                                    selectedAmphoe: oattoModel.selectedAmphoe,
                                    selectedTambon: oattoModel.selectedTambon,
                                    selectedZipcode: oattoModel.selectedZipcode,
                                  );
                                  // Update Address ID ที่ 0
                                  Provider.of<OattoModel>(context,
                                          listen: false)
                                      .editAddressButton(0, UpdateAddress);
                                }

                                QuickAlert.show(
                                  context: context,
                                  onConfirmBtnTap: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  type: QuickAlertType.success,
                                  title: "สำเร็จ",
                                  text:
                                      'เพิ่มที่อยู่จัดส่งสำเร็จ',
                                  confirmBtnColor: Colors.deepPurple,
                                  confirmBtnTextStyle: TextStyle(
                                    fontSize: 14,
                                    color: white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Save",
                                    style: GoogleFonts.prompt(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

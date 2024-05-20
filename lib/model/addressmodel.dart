class AddressButton {
  String? addressName;
  String? addressPhone;
  String? addressText;
  String? selectedProvince;
  String? selectedAmphoe;
  String? selectedTambon;
  String? selectedZipcode;

  AddressButton(
      {this.addressName,
      this.addressPhone,
      this.addressText,
      this.selectedProvince,
      this.selectedAmphoe,
      this.selectedTambon,
      this.selectedZipcode,
    });

  AddressButton.fromJson(Map<String, dynamic> json) {
    addressName = json['addressName'];
    addressPhone = json['addressPhone'];
    addressText = json['addressText'];
    selectedProvince = json['selectedProvince'];
    selectedAmphoe = json['selectedAmphoe'];
    selectedTambon = json['selectedTambon'];
    selectedZipcode = json['selectedZipcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['addressName'] = addressName;
    data['addressPhone'] = addressPhone;
    data['addressText'] = addressText;
    data['selectedProvince'] = selectedProvince;
    data['selectedAmphoe'] = selectedAmphoe;
    data['selectedTambon'] = selectedTambon;
    data['selectedZipcode'] = selectedZipcode;
    return data;
  }
}
class OwnerDataModel {
  static const PHONE_NUMBER_OWNER = "phoneNumberOwner";
  static const KTP_IMAGE = "ktpImage";
  static const NIK = "nik";
  static const KTP_NAME = "ktpName";
  static const NPWP_IMAGE = "npwpImage";
  static const NPWP_NUMBER = "npwpNumber";
  static const NPWP_NAME = "npwpName";

  String _phoNumberOwner;
  String _ktpImage;
  int _nik;
  String _ktpName;
  String _npwpImage;
  int _npwpNumber;
  String _npwpName;

  //  getters
  String get phoNumberOwner => _phoNumberOwner;
  String get ktpImage => _ktpImage;
  int get nik => _nik;
  String get ktpName => _ktpName;
  String get npwpImage => _npwpImage;
  int get npwpNumber => _npwpNumber;
  String get npwpName => _npwpName;

  OwnerDataModel.fromMap(Map data) {
    _phoNumberOwner = data[PHONE_NUMBER_OWNER];
    _ktpImage = data[KTP_IMAGE];
    _nik = data[NIK];
    _ktpName = data[KTP_NAME];
    _npwpNumber = data[NPWP_NUMBER];
    _npwpImage = data[NPWP_IMAGE];
    _npwpName = data[NPWP_NAME];
  }

  Map toMap() => {
    PHONE_NUMBER_OWNER : _phoNumberOwner,
    KTP_IMAGE : _ktpImage,
    KTP_NAME : _ktpName,
    NIK : _nik,
    NPWP_NAME : _npwpName,
    NPWP_NUMBER : _npwpNumber,
    NPWP_IMAGE : _npwpImage
  };
}

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scrappy/controller/service/header.dart';
import 'package:scrappy/core/utils/appUrls.dart';
import 'package:scrappy/core/utils/color_const.dart';
import 'package:scrappy/core/utils/image_constant.dart';
import 'package:scrappy/views/screens/GradientBoxBorder.dart';
import 'package:scrappy/views/screens/GradientTextFieldBorder.dart';
import 'package:scrappy/views/widgets/DotLoadingIndicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormScreen extends StatefulWidget {
  final List<num> subCatIds;
  const FormScreen({super.key, required this.subCatIds});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  double? latitude;
  double? longitude;
  bool locationLoading = true;

  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _pincodeController = TextEditingController();

  final _nameFocus = FocusNode();
  final _addressFocus = FocusNode();
  final _pincodeFocus = FocusNode();

  bool isPickupSame = false;
  bool isSubmitting = false;

  final List<File> _images = [];
  final picker = ImagePicker();
  late SharedPreferences prefs;
  String? userId;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _pincodeController.dispose();
    _nameFocus.dispose();
    _addressFocus.dispose();
    _pincodeFocus.dispose();
    super.dispose();
  }

  Future<void> _getLocation() async {
      prefs = await SharedPreferences.getInstance();
      userId = prefs.getString('userId');
    try {
    
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        setState(() => locationLoading = false);
        return;
      }
      Position pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        latitude = pos.latitude;
        longitude = pos.longitude;
        locationLoading = false;
      });
    } catch (e) {
      setState(() => locationLoading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Location error: $e')));
    }
  }

  Future<void> _pickImages() async {
    if (_images.length >= 2) return;
    try {
      final picked = await picker.pickMultiImage(imageQuality: 80);
      if (picked.isNotEmpty) {
        setState(() {
          _images.addAll(picked.map((e) => File(e.path)));
          if (_images.length > 2) {
            _images.removeRange(2, _images.length);
          }
        });
      }
      FocusScope.of(context).unfocus();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Image pick error: $e')));
    }
  }

  Future<void> _pickImageFromCamera() async {
    if (_images.length >= 2) return;
    try {
      final picked =
          await picker.pickImage(source: ImageSource.camera, imageQuality: 80);
      if (picked != null) {
        setState(() {
          _images.add(File(picked.path));
          if (_images.length > 2) {
            _images.removeRange(2, _images.length);
          }
        });
      }
      FocusScope.of(context).unfocus();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Camera error: $e')));
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  bool _validateForm() {
    if (_nameController.text.trim().isEmpty) {
      _nameFocus.requestFocus();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product name is required')));
      return false;
    }
    if (_addressController.text.trim().isEmpty) {
      _addressFocus.requestFocus();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product description is required')));
      return false;
    }
    if (widget.subCatIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sub category is required')));
      return false;
    }
    if ((userId ?? "").toString().trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('User id is required')));
      return false;
    }
    if (latitude == null || longitude == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location not available')));
      return false;
    }
    if (_images.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please upload at least one image')));
      return false;
    }
    return true;
  }

  Future<void> _submitForm() async {
    if (!_validateForm()) return;
    setState(() => isSubmitting = true);
    try {
      final prefs = await SharedPreferences.getInstance();
      Map<String, String> headers = Header.header(prefs);
      final dio = Dio(BaseOptions(headers: headers));

      final formData = FormData.fromMap({
        'sub_cat_id': widget.subCatIds.join(','),
        'user_id': userId.toString(),
        'prod_name': _nameController.text.trim(),
        'prod_desc': _addressController.text.trim(),
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
      });

      for (int i = 0; i < _images.length; i++) {
        final file = _images[i];
        formData.files.add(MapEntry(
          'prod_image',
          await MultipartFile.fromFile(file.path,
              filename: file.path.split('/').last),
        ));
      }

      final response = await dio.post(AppApi.addSCrap, data: formData);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Product submitted successfully')));
        _nameController.clear();
        _addressController.clear();
        _pincodeController.clear();
        setState(() {
          _images.clear();
          isPickupSame = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'Failed to submit (${response.statusCode}): ${response.data}')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Submission error: $e')));
    } finally {
      setState(() => isSubmitting = false);
    }
  }

  void _showImageSourceSheet() {
    _nameFocus.unfocus();
    _addressFocus.unfocus();
    _pincodeFocus.unfocus();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) {
        return SafeArea(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const SizedBox(height: 10),
            Container(
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10)),
            ),
            const SizedBox(height: 15),
            const Text("Select Option",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            ListTile(
              leading: CircleAvatar(
                  backgroundColor: Colors.blue.shade50,
                  child: const Icon(Icons.photo_library, color: Colors.blue)),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImages();
              },
            ),
            ListTile(
              leading: CircleAvatar(
                  backgroundColor: Colors.green.shade50,
                  child: const Icon(Icons.camera_alt, color: Colors.green)),
              title: const Text('Camera'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImageFromCamera();
              },
            ),
            ListTile(
              leading: CircleAvatar(
                  backgroundColor: Colors.red.shade50,
                  child: const Icon(Icons.close, color: Colors.red)),
              title: const Text('Cancel'),
              onTap: () => Navigator.of(context).pop(),
            ),
          ]),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              ColorConst.appPrimaryColor,
              ColorConst.appSecondaryColor
            ])),
            child: SingleChildScrollView(child: bodySection(context))));
  }

  Column bodySection(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(left: 15, top: 60, bottom: 45),
        child: Align(
          alignment: Alignment.topLeft,
          child: CircleAvatar(
            radius: 15,
            backgroundColor: Colors.white,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios,
                  color: Colors.black, size: 14),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(60), topRight: Radius.circular(60))),
        child: locationLoading
            ? Center(
                child: DotLoadingIndicator(
                    height: MediaQuery.of(context).size.height / 1.5,
                    indicatorColor: ColorConst.appColor))
            : latitude == null || longitude == null
                ? const Center(child: Text("Location permission denied"))
                : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const SizedBox(height: 20),
                    const Text("Current Location",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 20),
                    Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              ColorConst.appSecondaryColor,
                              ColorConst.appPrimaryColor
                            ]),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(children: [
                          Text("Latitude: ${latitude!.toStringAsFixed(6)}",
                              style: const TextStyle(color: Colors.white)),
                          Text("Longitude: ${longitude!.toStringAsFixed(6)}",
                              style: const TextStyle(color: Colors.white)),
                        ])),
                    const SizedBox(height: 20),
                    Row(children: [
                      SizedBox(
                          height: 30,
                          width: 30,
                          child: Checkbox(
                              value: isPickupSame,
                              onChanged: (v) =>
                                  setState(() => isPickupSame = v ?? false),
                              activeColor: ColorConst.appSecondaryColor,
                              checkColor: Colors.white)),
                      const SizedBox(width: 10),
                      Expanded(
                          child: Text(
                              "Kindly click the box if your current location is the pickup point for your order",
                              style: const TextStyle(fontSize: 12)))
                    ]),
                    const SizedBox(height: 16),
                    const Text("Please enter your details",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    _buildTextField(_nameController, _nameFocus, "Product Name",
                        hint: "eg: Leather Jacket"),
                    _buildTextField(_addressController, _addressFocus,
                        "Product Description",
                        hint: "Short description", maxLines: 3),
                    _buildTextField(_pincodeController, _pincodeFocus,
                        "Pincode (optional)",
                        hint: "eg: 126637",
                        keyboardType: TextInputType.number),
                    const SizedBox(height: 16),
                    const Text("Upload Image",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const Text("Please upload photos of your items (max 2)",
                        style: TextStyle(fontSize: 12)),
                  isSubmitting?SizedBox(height: 10,):  SizedBox(
                        height: _images.isEmpty ? 10 : 90,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: List.generate(
                                _images.length,
                                (i) => Padding(
                                    padding: const EdgeInsets.only(right: 8,top: 10),
                                    child: Stack(children: [
                                      Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              image: DecorationImage(
                                                  image: FileImage(_images[i]),
                                                  fit: BoxFit.cover))),
                                      Positioned(
                                          top: 0,
                                          right: 0,
                                          child: GestureDetector(
                                              onTap: () => _removeImage(i),
                                              child: const CircleAvatar(
                                                  radius: 12,
                                                  backgroundColor: Colors.red,
                                                  child: Icon(Icons.close,
                                                      size: 14,
                                                      color: Colors.white))))
                                    ]))))),
                    if (_images.length < 2)
                      GestureDetector(
                          onTap: _showImageSourceSheet,
                          child: Container(
                              margin:
                                  EdgeInsets.only(top: _images.isEmpty ? 0 : 20),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: GradientBoxBorder(
                                      gradient: LinearGradient(colors: [
                                    ColorConst.appSecondaryColor,
                                    ColorConst.appColor
                                  ]))),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(ImageConstant.upoladImage)
                                  ]))),
                    const SizedBox(height: 20),
                   isSubmitting
                                ? Center(
                                  child:  SizedBox(
                                      height: 10,
                                      width: MediaQuery.of(context).size.width,
                                      child: Center(
                                          child: DotLoadingIndicator(indicatorColor: ColorConst.appColor,))),
                                )
                                : GestureDetector(
                        onTap: isSubmitting ? null : _submitForm,
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                gradient: LinearGradient(colors: [
                                  ColorConst.appSecondaryColor,
                                  ColorConst.appPrimaryColor
                                ])),
                            child: const Center(
                                    child: Text("Submit",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)))))
                  ]),
      )
    ]);
  }

  Widget _buildTextField(TextEditingController controller, FocusNode focus,
      String label,
      {String? hint,
      int maxLines = 1,
      TextInputType keyboardType = TextInputType.text}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label,
          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15)),
      const SizedBox(height: 10),
      Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: TextFormField(
              controller: controller,
              focusNode: focus,
              keyboardType: keyboardType,
              maxLines: maxLines,
              decoration: InputDecoration(
                  hintText: hint,
                  border: GradientOutlineInputBorder(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      width: 2,
                      gradient: LinearGradient(colors: [
                        ColorConst.appSecondaryColor,
                        ColorConst.appSecondaryColor
                      ])))))
    ]);
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/widgets/our_elevated_button.dart';
import 'package:myapp/widgets/our_flutter_toast.dart';
import 'package:myapp/widgets/our_shimmer_text.dart';
import 'package:myapp/widgets/our_sized_box.dart';
import 'package:myapp/widgets/our_text_field.dart';

class CheckOutScreen extends StatefulWidget {
  final Position userPosition;

  const CheckOutScreen({Key? key, required this.userPosition})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  Position? position;
  double? longitude = 0.69;
  double? latitude = 0.69;
  List<Placemark>? placeMarks;

  ValueNotifier<GeoPoint?> notifier = ValueNotifier(null);
  TextEditingController _name_controller = TextEditingController();
  TextEditingController _phone_controller = TextEditingController();
  TextEditingController _email_controller = TextEditingController();
  TextEditingController _country_controller = TextEditingController();
  TextEditingController _postal_code_controller = TextEditingController();
  TextEditingController _administrative_area_controller =
      TextEditingController();
  TextEditingController _subministrative_area_controller =
      TextEditingController();
  TextEditingController _locality_controller = TextEditingController();
  TextEditingController _sublocality_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: ScreenUtil().setSp(25),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Check Out",
          style: TextStyle(
            fontSize: ScreenUtil().setSp(25),
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: logoColor,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setSp(20),
            vertical: ScreenUtil().setSp(10),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomTextField(
                  controller: _name_controller,
                  validator: (value) {},
                  title: "Name",
                  type: TextInputType.name,
                  number: 1,
                ),
                OurSizedBox(),
                CustomTextField(
                  controller: _phone_controller,
                  validator: (value) {},
                  title: "Phone ",
                  type: TextInputType.number,
                  number: 1,
                ),
                OurSizedBox(),
                CustomTextField(
                  controller: _email_controller,
                  validator: (value) {},
                  title: "Email",
                  type: TextInputType.emailAddress,
                  number: 1,
                ),
                OurSizedBox(),
                CustomTextField(
                  readonly: true,
                  controller: _country_controller,
                  validator: (value) {},
                  title: "Country",
                  type: TextInputType.emailAddress,
                  number: 1,
                ),
                OurSizedBox(),
                CustomTextField(
                  readonly: true,
                  controller: _postal_code_controller,
                  validator: (value) {},
                  title: "Postal code",
                  type: TextInputType.name,
                  number: 1,
                ),
                OurSizedBox(),
                CustomTextField(
                  readonly: true,
                  controller: _administrative_area_controller,
                  validator: (value) {},
                  title: "Administrative area",
                  type: TextInputType.name,
                  number: 1,
                ),
                OurSizedBox(),
                CustomTextField(
                  readonly: true,
                  controller: _subministrative_area_controller,
                  validator: (value) {},
                  title: "Sub administrative area",
                  type: TextInputType.emailAddress,
                  number: 1,
                ),
                OurSizedBox(),
                CustomTextField(
                  readonly: true,
                  controller: _locality_controller,
                  validator: (value) {},
                  title: "Locality",
                  type: TextInputType.emailAddress,
                  number: 1,
                ),
                OurSizedBox(),
                CustomTextField(
                  readonly: true,
                  controller: _sublocality_controller,
                  validator: (value) {},
                  title: "Sub locality",
                  type: TextInputType.emailAddress,
                  number: 1,
                ),
                OurSizedBox(),
                OurElevatedButton(
                  title: "Select current location",
                  function: () async {
                    placeMarks = await placemarkFromCoordinates(
                      widget.userPosition.latitude,
                      widget.userPosition.longitude,
                    );

                    setState(() {
                      latitude = widget.userPosition.latitude;
                      longitude = widget.userPosition.longitude;
                      _country_controller.text = placeMarks![1].country ?? " ";
                      _postal_code_controller.text =
                          placeMarks![1].postalCode ?? " ";
                      _administrative_area_controller.text =
                          placeMarks![1].administrativeArea ?? " ";
                      _subministrative_area_controller.text =
                          placeMarks![1].subAdministrativeArea ?? " ";
                      _locality_controller.text =
                          placeMarks![1].locality ?? " ";
                      _sublocality_controller.text =
                          placeMarks![1].subLocality ?? " ";
                    });
                  },
                ),
                OurElevatedButton(
                  title: "Pick From Map",
                  function: () async {
                    var p = await showSimplePickerLocation(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setSp(5),
                      ),
                      context: context,
                      isDismissible: true,
                      titleWidget: OurShimmerText(
                        title: "Pick Location",
                      ),
                      textConfirmPicker: "pick",
                      initCurrentUserPosition: false,
                      initZoom: 10,
                      initPosition: GeoPoint(
                        latitude: widget.userPosition.latitude,
                        longitude: widget.userPosition.longitude,
                      ),
                      radius: 8.0,
                    );
                    if (p != null) {
                      notifier.value = p;
                      placeMarks = await placemarkFromCoordinates(
                        p.latitude,
                        p.longitude,
                      );
                      print(placeMarks![1]);
                      setState(() {
                        latitude = p.latitude;
                        longitude = p.longitude;
                        _country_controller.text =
                            placeMarks![1].country ?? " ";
                        _postal_code_controller.text =
                            placeMarks![1].postalCode ?? " ";
                        _administrative_area_controller.text =
                            placeMarks![1].administrativeArea ?? " ";
                        _subministrative_area_controller.text =
                            placeMarks![1].subAdministrativeArea ?? " ";
                        _locality_controller.text =
                            placeMarks![1].locality ?? " ";
                        _sublocality_controller.text =
                            placeMarks![1].subLocality ?? " ";
                      });
                    }
                  },
                ),
                OurElevatedButton(
                  title: "Submit",
                  function: () {
                    if (_name_controller.text.trim().isEmpty ||
                        _phone_controller.text.trim().isEmpty ||
                        _email_controller.text.trim().isEmpty ||
                        longitude == 0.69 ||
                        latitude == 0.69) {
                      OurToast().showErrorToast("Fields can't be empty");
                    } else {
                      OurToast().showSuccessToast("Submitted");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 
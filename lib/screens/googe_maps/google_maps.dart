//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:doctormobileapplication/components/custom_textfields.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/data/controller/google_maps_controller.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/helpers/values_manager.dart';
import 'package:doctormobileapplication/screens/family_screens/family_members.dart';
import 'package:flutter/material.dart';
//import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({super.key});

  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomAppBar(
            title: 'Select Address',
          )),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: Stack(
          children: [
            SizedBox(
              height: Get.height * 0.02,
            ),
            // SizedBox(
            //   height: Get.height * 0.8,
            //   child: GetBuilder<AddressController>(builder: (address) {
            //     return GoogleMap(
            //       onTap: (argument) async {
            //         setState(() {
            //           address.markers.clear();
            //           address.markers.add(Marker(
            //               infoWindow: const InfoWindow(
            //                   title: 'Current Location',
            //                   snippet: 'This is my current Location'),
            //               position:
            //                   LatLng(argument.latitude, argument.longitude),
            //               markerId: const MarkerId('1')));
            //           address.currentPlaceList.clear();
            //         });
            //         GoogleMapController controller =
            //             await AddressController.i.mapController.future;
            //
            //         controller.animateCamera(
            //                     CameraUpdate.newCameraPosition(CameraPosition(
            //                         zoom: 20,
            //                         target: LatLng(
            //                             argument.latitude,
            //                             argument.longitude))));
            //                 log(AddressController.i.currentLocation.toString());
            //
            //         List<Placemark>? placemark =
            //                     await placemarkFromCoordinates(
            //                         argument.latitude,
            //                         argument.longitude,);
            //
            //                 address.updateAddress(
            //                     '${placemark[0].subLocality} ${placemark[0].locality} ${placemark[0].country} ${placemark[0].street}');
            //                 log(address.address.toString());
            //       },
            //       initialCameraPosition: CameraPosition(
            //           target: LatLng(AddressController.i.latitude!,
            //               AddressController.i.longitude!),
            //           zoom: 10),
            //       mapType: MapType.normal,
            //       markers: Set.of(AddressController.i.markers),
            //       onMapCreated: (controller) {
            //         AddressController.i.mapController.complete(controller);
            //       },
            //     );
            //   }),
            // ),
            Column(
              children: [
                GetBuilder<AddressController>(builder: (cont) {
                  return Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          onchanged: (value) {
                            setState(() {
                              AddressController.i.getSuggestion(value);
                            });
                          },
                          hintText: 'Search',
                          prefixIcon: const Icon(
                            Icons.search,
                            color: ColorManager.kPrimaryColor,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                // GetBuilder<AddressController>(builder: (address) {
                //   return ListView.builder(
                //       itemCount: address.currentPlaceList.length,
                //       shrinkWrap: true,
                //       itemBuilder: (context, index) {
                //         return InkWell(
                //           onTap: () async {
                //             if (address.currentPlaceList.isNotEmpty) {
                //               address.currentLocation =
                //                   await locationFromAddress(address
                //                       .currentPlaceList[index]['description']);
                //             }
                //
                //             setState(() {
                //               address.markers.clear();
                //               address.markers.add(Marker(
                //                   infoWindow: const InfoWindow(
                //                       title: 'Current Location',
                //                       snippet: 'This is my current Location'),
                //                   position: LatLng(
                //                       address.currentLocation!.reversed.last
                //                           .latitude,
                //                       address.currentLocation!.reversed.last
                //                           .longitude),
                //                   markerId: const MarkerId('1')));
                //             });
                //
                //             GoogleMapController controller =
                //                 await AddressController.i.mapController.future;
                //             controller.animateCamera(
                //                 CameraUpdate.newCameraPosition(CameraPosition(
                //                     zoom: 10,
                //                     target: LatLng(
                //                         AddressController.i.currentLocation!
                //                             .reversed.last.latitude,
                //                         AddressController.i.currentLocation!
                //                             .reversed.last.longitude))));
                //             log(AddressController.i.currentLocation.toString());
                //
                //             List<Placemark>? placemark =
                //                 await placemarkFromCoordinates(
                //                     address.currentLocation!.last.latitude,
                //                     address.currentLocation!.last.longitude);
                //
                //             address.updateAddress(
                //                 '${placemark[0].subLocality} ${placemark[0].locality} ${placemark[0].country} ${placemark[0].street}');
                //             log(address.address.toString());
                //           },
                //           child: Container(
                //             color: Colors.white,
                //             child: Padding(
                //               padding: const EdgeInsets.all(8.0),
                //               child: Text(
                //                 AddressController.i.currentPlaceList[index]
                //                     ['description'],
                //                 style: const TextStyle(
                //                     color: Colors.black,
                //                     fontWeight: FontWeight.w500),
                //               ),
                //             ),
                //           ),
                //         );
                //       });
                // }),
                const Spacer(),
                PrimaryButton(
                    fontSize: 14,
                    title: 'Select Location',
                    onPressed: () {
                      // AddressController.i.markers.clear();
                      // Get.back();
                    },
                    color: ColorManager.kPrimaryColor,
                    textcolor: ColorManager.kWhiteColor)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_hub/constant.dart';
import 'package:travel_hub/navigation/maps/presentation/widgets/custom_search_bar.dart';
import 'package:travel_hub/navigation/maps/presentation/widgets/map_controller.dart';


class FullMapScreen extends StatefulWidget {
  const FullMapScreen({super.key});

  @override
  State<FullMapScreen> createState() => _FullMapScreenState();
}

class _FullMapScreenState extends State<FullMapScreen> {
  final FullMapController mapController = FullMapController();
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    mapController.setInitialLocation(() => setState(() {}));
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          mapController.cameraPosition == null
              ? const Center(child: CircularProgressIndicator())
              : GoogleMap(
                  initialCameraPosition: mapController.cameraPosition!,
                  myLocationEnabled: true,
                  onMapCreated: (c) =>
                      mapController.googleController.complete(c),
                  markers: mapController.myMarker != null
                      ? {mapController.myMarker!}
                      : {},
                ),

          CustomSearchBar(
            controller: searchController,
            onSearch: (value) async {
              try {
                await mapController.searchLocation(value, () => setState(() {}));
              } catch (e) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("$e")));
              }
            },
          ),
          Positioned(
            bottom: 30,
            left: 20,
            child: FloatingActionButton(
              onPressed: () =>
                  mapController.goToMyLocation(() => setState(() {})),
              heroTag: "locationBtn",
              backgroundColor: loginGradient.colors.first,
              foregroundColor: kWhite,
              child: const Icon(Icons.my_location),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/datasources/vendors/demo_vendor_data_source.dart';
import '../../../domain/entities/vendor_entity.dart';
import '../../../l10n/app_localizations.dart';

class NearbyVendorsScreen extends StatefulWidget {
  const NearbyVendorsScreen({super.key});

  @override
  State<NearbyVendorsScreen> createState() => _NearbyVendorsScreenState();
}

class _NearbyVendorsScreenState extends State<NearbyVendorsScreen> {
  final List<VendorEntity> vendors = const DemoVendorDataSource().getVendors();

  static const CameraPosition initialCamera = CameraPosition(
    target: LatLng(30.55, 30.75),
    zoom: 7,
  );

  late final Set<Marker> markers;

  @override
  void initState() {
    super.initState();

    markers = vendors.map((vendor) {
      return Marker(
        markerId: MarkerId(vendor.id),
        position: LatLng(vendor.latitude, vendor.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: InfoWindow(
          title: vendor.name,
          snippet: '${vendor.cuisine} • ★ ${vendor.rating.toStringAsFixed(1)}',
        ),
      );
    }).toSet();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: initialCamera,
            markers: markers,
            mapType: MapType.normal,
            zoomControlsEnabled: true,
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
            compassEnabled: true,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.topCenter,
                child: Material(
                  color: Theme.of(context).colorScheme.surface,
                  elevation: 3,
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          tooltip: l10n.back,
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            l10n.nearbyVendors,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        const Icon(Icons.location_on, color: AppColors.primary),
                        const SizedBox(width: 12),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

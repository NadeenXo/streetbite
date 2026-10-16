import '../../../domain/entities/vendor_entity.dart';

class DemoVendorDataSource {
  const DemoVendorDataSource();

  List<VendorEntity> getVendors() {
    return const [
      VendorEntity(
        id: '1',
        name: 'Cairo Street Bites',
        cuisine: 'Egyptian Street Food',
        rating: 4.8,
        latitude: 30.0444,
        longitude: 31.2357,
      ),
      VendorEntity(
        id: '2',
        name: 'Alexandria Seafood Spot',
        cuisine: 'Seafood',
        rating: 4.7,
        latitude: 31.2001,
        longitude: 29.9187,
      ),
      VendorEntity(
        id: '3',
        name: 'Giza Grill House',
        cuisine: 'Egyptian Grill',
        rating: 4.6,
        latitude: 30.0131,
        longitude: 31.2089,
      ),
      VendorEntity(
        id: '4',
        name: 'Mansoura Food Corner',
        cuisine: 'Sandwiches',
        rating: 4.5,
        latitude: 31.0409,
        longitude: 31.3785,
      ),
      VendorEntity(
        id: '5',
        name: 'Tanta Burger Stop',
        cuisine: 'Burgers',
        rating: 4.9,
        latitude: 30.7865,
        longitude: 31.0004,
      ),
    ];
  }
}

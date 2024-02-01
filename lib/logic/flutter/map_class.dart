class MapData {
  double latitude;
  double longitude;
  String placeName;

  MapData(this.latitude, this.longitude, this.placeName);

  @override
  String toString() {
    return 'MapData{placeName: $placeName, latitude: $latitude, longitude: $longitude}';
  }
}

import 'package:blabla/model/ride/locations.dart';
import 'package:blabla/service/locations_service.dart';
import 'package:blabla/ui/theme/theme.dart';
import 'package:blabla/ui/widgets/display/bla_divider.dart';
import 'package:flutter/material.dart';

class LocationPicker extends StatefulWidget {
  const LocationPicker({super.key, this.locationSearch});

  final String? locationSearch;

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  final TextEditingController _searchController = TextEditingController();

  List<Location> filterRide = [];

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.locationSearch ?? "";
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  void clearText() {
    setState(() {
      _searchController.text = "";
    });
  }

  void onSearch(String search) {
    List<Location> searchLocation = LocationsService.availableLocations
        .where(
          (l) => l.name.toLowerCase().contains(search.toLowerCase().trim()),
        )
        .toList();
    setState(() {
      filterRide = searchLocation;
    });
  }

  void onSelect(Location selectedLocation) {
    Navigator.pop(context, selectedLocation);
  }

  Widget get clearIconButton =>
      _searchController.text.isEmpty || _searchController.text == ""
      ? SizedBox.shrink()
      : IconButton(
          onPressed: clearText,
          icon: Icon(Icons.close, color: BlaColors.neutralLight),
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: SearchBar(
                controller: _searchController,
                onChanged: (value) => onSearch(value),
                hintText: "Search for location",
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: BlaColors.neutralLight,
                  ),
                ),
                trailing: [clearIconButton],
                elevation: WidgetStatePropertyAll(0),
                backgroundColor: WidgetStatePropertyAll(
                  BlaColors.backgroundAccent,
                ),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ListView.separated(
                  itemCount: filterRide.length,
                  itemBuilder: (context, index) => ListTile(
                    onTap: () => onSelect(filterRide[index]),
                    title: Text(
                      filterRide[index].name,
                      style: TextStyle(color: BlaColors.neutralDark),
                    ),
                    subtitle: Text(
                      filterRide[index].country.name,
                      style: TextStyle(color: BlaColors.neutralLighter),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: BlaColors.neutralLight,
                    ),
                  ),
                  separatorBuilder: (context, index) => BlaDivider(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

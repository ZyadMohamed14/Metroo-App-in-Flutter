/*
 Widget buildSelectedPlaceLocationBloc() {
    return BlocListener<MapsCubit, MapsState>(
      listener: (context, state) {
        if (state is PlaceLocationLoaded) {
          selectedPlace = (state).place;
        }
      },
      child: SizedBox(),
    );
  }
   Widget buildSuggestionsBloc() {
    return BlocBuilder<MapsCubit, MapsState>(
      builder: (context, state) {
        if (state is PlacesLoaded) {
          places = (state).places;
          if (places.length != 0) {
            return buildPlacesList();
          } else {
            return Text("No Places Found");
          }
        } else {
          return Text("Error Fetching Places");
        }
      },
    );
  }

  Widget buildPlacesList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () async {
            placeSuggestion = places[index];
          },
          child: PlaceItem(
            suggestion: places[index],
          ),
        );
      },
      itemCount: places.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
    );
  }

  void _showSearchBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the sheet to take full screen height
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 1.5,
            child: Column(
              mainAxisSize: MainAxisSize.min, // Adapts to the content's height
              children: [
                SizedBox(height: 10),
                // Search Text Field
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Find a place..',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (query) {
                    getPlacesSuggestions(query); // Trigger place suggestions
                  },
                  autofocus: true, // Automatically opens the keyboard
                ),
                SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () {}, child: Text("confirm Address")),
                SizedBox(height: 10),
                // Bloc Builder for showing suggestions
                buildSuggestionsBloc(),
                buildSelectedPlaceLocationBloc(),
              ],
            ),
          ),
        );
      },
    );
  }
  void getPlacesSuggestions(String query) {
    final sessionToken = Uuid().v4();
    BlocProvider.of<MapsCubit>(context)
        .getPlaceSuggestions(query, sessionToken);
  }
 */
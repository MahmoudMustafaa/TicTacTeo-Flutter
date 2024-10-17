import 'package:flutter/material.dart';
import 'package:gaming/widgets/custom_Appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MarketPlacePage extends StatefulWidget {
  const MarketPlacePage({super.key});

  @override
  _MarketPlacePageState createState() => _MarketPlacePageState();
}

class _MarketPlacePageState extends State<MarketPlacePage> {
  int trophies = 0;
  List<bool> purchasedItems = List.generate(6, (index) => false);

  @override
  void initState() {
    super.initState();
    _loadTrophies();
  }

  _loadTrophies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      trophies = prefs.getInt('trophies') ?? 0;
      purchasedItems =
          List.generate(6, (index) => prefs.getBool('item_$index') ?? false);
    });
  }

  _buyItem(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int itemCost = 20 + index;

    bool? confirmPurchase = await _showConfirmDialog(itemCost);
    if (confirmPurchase == true &&
        trophies >= itemCost &&
        !purchasedItems[index]) {
      setState(() {
        trophies -= itemCost;
        purchasedItems[index] = true;
      });

      prefs.setInt('trophies', trophies);
      prefs.setBool('item_$index', true);
    }
  }

  Future<bool?> _showConfirmDialog(int cost) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Purchase"),
          content: Text(
              "Are you sure you want to buy this item for $cost trophies?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("Buy"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        trophies: trophies,
        titleText: 'Market Place',
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "spiderman.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      bool isPurchased = purchasedItems[index];
                      return Card(
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: const BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    isPurchased
                                        ? Icons.check_circle
                                        : Icons.close,
                                    size: 40,
                                    color:
                                        isPurchased ? Colors.green : Colors.red,
                                  ),
                                  Icon(
                                    isPurchased
                                        ? Icons.circle
                                        : Icons.circle_outlined,
                                    size: 40,
                                    color: isPurchased
                                        ? Colors.yellow
                                        : Colors.cyan,
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                onPressed:
                                    isPurchased || trophies < (20 + index)
                                        ? null
                                        : () => _buyItem(index),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  backgroundColor: isPurchased
                                      ? Colors.green
                                      : Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side: BorderSide(
                                      color: isPurchased
                                          ? Colors.green
                                          : Colors.yellowAccent,
                                      width: 2.0,
                                    ),
                                  ),
                                  textStyle: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 50.0,
                                    vertical: 20.0,
                                  ),
                                  shadowColor: Colors.transparent,
                                ),
                                child: Text(
                                  isPurchased ? 'Purchased' : 'Buy',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(Icons.emoji_events,
                                      color: Colors.yellowAccent, size: 20),
                                  Text(
                                    '${20 + index} trophies',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

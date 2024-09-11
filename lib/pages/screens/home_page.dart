import 'package:animator/helper/json_helper.dart';
import 'package:animator/models/planet_model.dart';
import 'package:animator/provider/theme_provider.dart';
import 'package:animator/utils/gloabal_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int selectedIndex = 0;
  PageController pageController = PageController();
  @override
  void initState() {
    loadPrefs();
    super.initState();
  }

  loadPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedFavorites = prefs.getStringList('favorite');
    if (savedFavorites != null) {
      globalSet = savedFavorites.toSet();
      globalList = globalSet.toList();
    }
    setState(() {});
  }

  removePrefs(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    globalSet.remove(value);
    prefs.setStringList('favorite', globalSet.toList());

    globalList = globalSet.toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final themeToggle =
        Provider.of<ThemeProvider>(context).themeModel.toggleTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galaxy Planets (Animator)'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('settings_screen');
              },
              icon: const Icon(Icons.settings_outlined))
        ],
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (val) {
          selectedIndex = val;
          setState(() {});
        },
        children: [
          FutureBuilder(
            future: JsonHelper.jsonHelper.loadJson(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (snapshot.hasData) {
                List<PlanetModel>? planetListModel = snapshot.data;
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: planetListModel!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('detail_page',
                            arguments: planetListModel[index]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              top: 70,
                              child: Container(
                                height: 210,
                                width: 250,
                                decoration: BoxDecoration(
                                  color: (themeToggle == false)
                                      ? Colors.white
                                      : Colors.grey[200],
                                  boxShadow: [
                                    BoxShadow(
                                      color: (themeToggle == false)
                                          ? Colors.black.withOpacity(0.15)
                                          : Colors.black.withOpacity(0.5),
                                      spreadRadius: 0,
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 68.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        planetListModel[index].name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30.0, vertical: 20),
                                        child: Text(
                                          textAlign: TextAlign.justify,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          softWrap: false,
                                          planetListModel[index].description,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 160,
                              child: Hero(
                                tag: planetListModel[index].name,
                                transitionOnUserGestures: true,
                                child: Image.network(
                                  planetListModel[index].image,
                                  height: 150,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 150,
                              right: 185,
                              child: RotatedBox(
                                quarterTurns: 1,
                                child: Text(
                                  textAlign: TextAlign.center,
                                  planetListModel[index].position.toUpperCase(),
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
          (globalList.isEmpty)
              ? const Center(
                  child: Text('Add You Fav. Planet'),
                )
              : ListView.builder(
                  itemCount: globalList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(globalList[index]),
                      onTap: () {
                        Navigator.of(context).pushNamed('detail_page',
                            arguments: globalList[index]);
                      },
                      trailing: IconButton(
                          onPressed: () {
                            removePrefs(globalList[index]);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                    );
                  })
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (val) {
          pageController.animateToPage(val,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(
              icon: Icon(Icons.favorite_border_outlined), label: 'Favorite'),
        ],
      ),
    );
  }
}

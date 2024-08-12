import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_appp/models/categories_new_model.dart';
import 'package:news_appp/view/categories_screen.dart';
import 'package:news_appp/view/new_details_screen.dart';
import 'package:news_appp/view_model/news_view_model.dart';

import '../models/news_channel_headlines_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList {
  bbcNews,
  aryNews,
  bbsSupportNews,
  abcNews,
  cbsNews,
  aljazeera
}

class _HomeScreenState extends State<HomeScreen> {
  FilterList? selectedMenu;
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MMMM dd, yyyy');
  String name = 'bbc-news';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CategoriesScreen()));
          },
          icon: Image.asset(
            'assets/category_icon.png',
            height: 30,
            width: 30,
            fit: BoxFit.cover,
          ),
        ),
        centerTitle: true,
        title: Text(
          'News',
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        actions: [
          PopupMenuButton<FilterList>(
            initialValue: selectedMenu,
            onSelected: (FilterList item) {
              setState(() {
                selectedMenu = item;
                switch (item) {
                  case FilterList.bbcNews:
                    name = 'bbc-news';
                    break;
                  case FilterList.aryNews:
                    name = 'ary-news';
                    break;
                  case FilterList.bbsSupportNews:
                    name = 'bbc-sport';
                    break;
                  case FilterList.abcNews:
                    name = 'abc-news';
                    break;
                  case FilterList.cbsNews:
                    name = 'cbs-news';
                    break;
                  case FilterList.aljazeera:
                    name = 'al-jazeera-english';
                    break;
                }
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<FilterList>>[
              const PopupMenuItem<FilterList>(
                value: FilterList.bbcNews,
                child: Text('BBC News'),
              ),
              const PopupMenuItem<FilterList>(
                value: FilterList.aryNews,
                child: Text('ARY News'),
              ),
              const PopupMenuItem<FilterList>(
                value: FilterList.bbsSupportNews,
                child: Text('BBC Support News'),
              ),
              const PopupMenuItem<FilterList>(
                value: FilterList.abcNews,
                child: Text('ABC News'),
              ),
              const PopupMenuItem<FilterList>(
                value: FilterList.cbsNews,
                child: Text('CBS News'),
              ),
              const PopupMenuItem<FilterList>(
                value: FilterList.aljazeera,
                child: Text('Aljazeera News'),
              ),
            ],
          )
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * 0.55,
            width: width,
            child: FutureBuilder<NewsChannelHeadlinesModel>(
              future: newsViewModel.fetchNewsChannelsHeadlinesApi(name),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitCircle(
                      color: Colors.blue,
                      size: 50,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.articles!.length,
                    itemBuilder: (context, index) {
                      DateTime dateTime = DateTime.parse(
                        snapshot.data!.articles![index].publishedAt.toString(),
                      );
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewDetailsScreen(
                                      newsImage: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      newsTitle: snapshot.data!.articles![index].title
                                          .toString(),
                                      newsDate: snapshot
                                          .data!.articles![index].publishedAt
                                          .toString(),
                                      newsAuthor: snapshot
                                          .data!.articles![index].author
                                          .toString(),
                                      newsDesc: snapshot
                                          .data!.articles![index].description
                                          .toString(),
                                      newsContent: snapshot
                                          .data!.articles![index].content
                                          .toString(),
                                      newsSource: snapshot.data!.articles![index].source!.name.toString())));
                        },
                        child: SizedBox(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: height * 0.6,
                                width: width * 0.9,
                                padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.04,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot
                                        .data!.articles![index].urlToImage
                                        .toString(),
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      child: spinkit2,
                                    ),
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(15),
                                    height: height * 0.22,
                                    alignment: Alignment.bottomCenter,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: width * 0.7,
                                          child: Text(
                                            snapshot
                                                .data!.articles![index].title
                                                .toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          width: width * 0.7,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot.data!.articles![index]
                                                    .source!.name
                                                    .toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                format.format(dateTime),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
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
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: FutureBuilder<CategoriesNewModel>(
              future: newsViewModel.fetchCategoriesNewsApi('Entertainment'),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitCircle(
                      color: Colors.blue,
                      size: 50,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    // scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.articles!.length,
                    itemBuilder: (context, index) {
                      DateTime dateTime = DateTime.parse(
                        snapshot.data!.articles![index].publishedAt.toString(),
                      );
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                imageUrl: snapshot
                                    .data!.articles![index].urlToImage
                                    .toString(),
                                fit: BoxFit.cover,
                                height: height * 0.18,
                                width: width * 0.3,
                                placeholder: (context, url) => Container(
                                  child: spinkit2,
                                ),
                                errorWidget: (context, url, error) => Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            Expanded(
                                child: Container(
                              height: height * 0.18,
                              padding: EdgeInsets.only(left: 15),
                              child: Column(
                                children: [
                                  Text(
                                    snapshot.data!.articles![index].title
                                        .toString(),
                                    maxLines: 3,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                        color: Colors.black54),
                                  ),
                                  Spacer(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        snapshot
                                            .data!.articles![index].source!.name
                                            .toString(),
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: Colors.black54),
                                      ),
                                      Text(
                                        format.format(dateTime),
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ))
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

const spinkit2 = SpinKitFadingCircle(
  color: Colors.blue,
  size: 50,
);

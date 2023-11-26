import 'package:eco_city/data/repositories/profileApiClient.dart';
import 'package:eco_city/presentation/screens/administrator/moderationNewsCard.dart';
import 'package:eco_city/presentation/widgets/navigation/navigation.dart';
import 'package:eco_city/utils/constants/colors.dart';
import 'package:eco_city/utils/constants/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:eco_city/domain/models/user/userModel.dart' as userData;
import 'package:eco_city/domain/models/news/newsModeration.dart' as newsData;

class ModerationNewsScreen extends StatefulWidget {
  const ModerationNewsScreen({super.key});

  @override
  State<ModerationNewsScreen> createState() => ModerationNewsScreenState();
}

class ModerationNewsScreenState extends State<ModerationNewsScreen> {
  List<dynamic> listNews = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _afterBindWidget(context));
  }

  Future<void> _afterBindWidget(context) async {
    await profileApiClient().getUnconfirmedMarks(context);
    setState(() {
      listNews = newsData.newsModerationJSON;
    });
  }

  Widget getPage() {
    return Expanded(
      child: listNews.isNotEmpty
          ? ListView.builder(
              itemCount: listNews.length,
              itemBuilder: (BuildContext context, int index) {
                // Извлекаем информацию о машине из списка
                var newsInfo = listNews[index];
                print("Новость номер: $index: $newsInfo");
                int newsId = newsInfo['id'];
                String newstopic = newsInfo['topic'];
                String newsDesciption = newsInfo['description'];
                String newsAddress = newsInfo['address'];
                String newsCategory = newsInfo['category'];
                Image newsImage =
                    Image.network(newsInfo['pictures'][0], fit: BoxFit.cover);
                return ModerationNewsCard(
                  newsId: newsId.toString(),
                  newsTopic: newstopic,
                  newsImage: newsImage,
                  newsCategory: newsCategory,
                  newsDescription: newsDesciption,
                  newsAddress: newsAddress,
                  onTap: () {
                    print('test');
                  },
                );
              },
            )
          : const Center(
              child: Text(
                'Нет данных для модерации',
                style: TextStyles.greyCaptionTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Модерация новостей',
          style: TextStyles.greyCaptionTextStyle.copyWith(
              color: AppColors.darkColor, fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppColors.whiteColor,
        surfaceTintColor: AppColors.whiteColor,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Color.fromRGBO(232, 232, 232, 0.64),
            height: 2,
          ),
        ),
      ),
      drawer: NavigationWidget(
        role: userData.userRole,
      ),
      body: SafeArea(
        child: getPage(),
      ),
    );
  }
}

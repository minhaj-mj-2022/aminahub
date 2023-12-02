import 'package:aminahub/screens/bookmarks/bookmarks_body.dart';
import '../../imports.dart';

class FavouritesScreen extends StatelessWidget {
  static String routeName = "/FavouritesScreen";

  const FavouritesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BookmarkBody(barTitle: 'Bookmarks'),
      bottomNavigationBar:
          CustomBottomNavBar(selectedMenu: MenuState.favourite),
    );
  }
}

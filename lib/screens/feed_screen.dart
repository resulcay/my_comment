import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:my_comment/constants/color_constants.dart';
import 'package:my_comment/models/user_model.dart';
import 'package:my_comment/service/firebase_service.dart';
import 'package:my_comment/service/path_service.dart';
import 'package:my_comment/service/user_service.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserService>(context).user!;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: SvgPicture.asset(
                      alignment: Alignment.centerLeft,
                      PathService.imagePathProvider('welcome.svg')),
                ),
              ),
              Text(
                'Merhaba, ',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Flexible(
                child: Text(
                  user.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 25,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 200,
            width: double.infinity,
            child: Card(
                color: ColorConstants.secondaryColor,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Bu ay; 10 film, 5 dizi ve 12 kitap bitirdiniz.',
                      style: TextStyle(
                          color: ColorConstants.pureWhite,
                          fontSize: 25,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressBar(
                maxSteps: 100,
                progressType: LinearProgressBar.progressTypeLinear,
                currentStep: 25,
                minHeight: 15,
                progressColor: Colors.red,
                backgroundColor: Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressBar(
                maxSteps: 100,
                progressType: LinearProgressBar.progressTypeLinear,
                currentStep: 50,
                minHeight: 15,
                progressColor: Colors.red,
                backgroundColor: Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressBar(
                maxSteps: 100,
                progressType: LinearProgressBar.progressTypeLinear,
                currentStep: 70,
                minHeight: 15,
                progressColor: Colors.red,
                backgroundColor: Colors.grey,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              FirebaseService().addMovie();
            },
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                  height: 200,
                  fit: BoxFit.cover,
                  'https://tr.web.img4.acsta.net/c_310_420/pictures/14/10/09/15/52/150664.jpg'),
            ),
            trailing: const FlutterLogo(),
            title: const Text('data'),
            splashColor: Colors.red,
          ),
          Text(user.email),
          Text(user.id),
          ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: const Text('EXIT')),
        ],
      ),
    );
  }
}

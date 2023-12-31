import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/controller/auth_controller.dart';
import 'package:e_mart/controller/change_profile_controller.dart';
import 'package:e_mart/orders_screen/orders_screen.dart';
import 'package:e_mart/profile_screen/components/details_card.dart';
import 'package:e_mart/profile_screen/edit_profile_screen.dart';
import 'package:e_mart/services/firestore_services.dart';
import 'package:e_mart/views/auth_screen/login_screen.dart';
import 'package:e_mart/views/chat_screen/messaging_screen.dart';
import 'package:e_mart/widgets_common/bg_widget.dart';
import 'package:e_mart/widgets_common/loading_indicator.dart';
import 'package:e_mart/wishlist_screen/wishlist_screen.dart';
import 'package:get/get.dart';

import '../consts/list.dart';
import '../views/home_screen/home.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ProfileController());

    return bgWidget(
      child: Scaffold(
        //Streambuilder to collect all info about user form firestore
        body:StreamBuilder(
          stream: FirestoreServices.getUser(currentUser!.uid),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor),),
              );
            }
            else {
              //to fetch alll data od user from firestore
              var data_user = snapshot.data!.docs[0];



              return SafeArea(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          //changing image after updating
                          if(data_user['imageUrl']=='')Image.asset(imgProfile2,width: 80,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make()
                          else Image.network(data_user['imageUrl'],width: 80,fit: BoxFit.cover,).box.width(80).height(80).roundedFull.clip(Clip.antiAlias).make(),

                          10.widthBox,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "${data_user['name']}".text.white.fontFamily(bold).make(),
                                "${data_user['email']}".text.white.fontFamily(semibold).make(),
                              ],
                            ),
                          ),
                          10.widthBox,
                          OutlinedButton(
                              onPressed: ()async {
                                await Get.put(AuthController()).signoutMethod(context);
                                Get.offAll(()=>LoginScreen());
                              },
                              style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: Colors.white)
                              ),
                              child: "Logout".text.fontFamily(semibold).white.make()),

                          //edit profile button
                          10.widthBox,
                          Align(alignment:Alignment.centerRight, child: Icon(Icons.edit,color: Colors.white,)).onTap(() {
                            controller.nameController.text = data_user['name'];
                            Get.to(()=>EditProfileScreen(data: data_user));
                            print("edit profile");
                          }),
                        ],
                      ),

                      25.heightBox,

                      FutureBuilder(
                          future: FirestoreServices.getCounts(),
                          builder: (BuildContext context , AsyncSnapshot snapshot){
                            if(snapshot.hasData == false){
                              return Center(child: loadingIndicator(),);
                            }
                            else{
                              var countData = snapshot.data;
                              return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      detailsCard(title: "In your cart" , count: countData[0].toString() , width: context.screenWidth/3.5),
                                      detailsCard(title: "Your wishlist" , count: countData[1].toString() , width: context.screenWidth/3.5),
                                      detailsCard(title: "Your Orders" , count: countData[2].toString() , width: context.screenWidth/3.5),
                                    ],
                                  );
                            }
                          }),



                      30.heightBox,
                      ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context,index){
                            return ListTile(
                              ///---->>>> on tap
                              onTap: (){
                                if(index == 1)Get.to(()=>OrdersScreen());
                                if(index == 2)Get.to(()=>WishlistScreen());
                                if(index == 5)Get.to(()=>MessagingScreen());

                              },
                              leading: Image.asset(profileButtonImages[index],width: 22,),
                              title: profileButtonList[index].text.make(),
                            );
                          },
                          separatorBuilder: (context,index){
                            return Divider(color: lightGrey,thickness: 2,);
                          },
                          itemCount: profileButtonImages.length
                      ).box.white.rounded.shadowSm.margin(EdgeInsets.all(12)).padding(EdgeInsets.all(12)).make(),
                    ],
                  ).scrollVertical(physics: BouncingScrollPhysics()),
                ),
              );
            }

          },

        )
      )
    );
  }
}

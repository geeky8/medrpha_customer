// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_workout_ui/model/DayModel.dart';
// import 'package:flutter_workout_ui/model/WorkoutModel.dart';
// import 'package:flutter_workout_ui/model/IntroModel.dart';
// import 'package:flutter_workout_ui/model/ExerciseModel.dart';
//
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/model/IntroModel.dart';
import 'package:flutter_medical_ui/model/CategoryModel.dart';
import 'package:flutter_medical_ui/model/SubCategoryModel.dart';
import 'package:flutter_medical_ui/model/SliderModel.dart';
import 'package:flutter_medical_ui/model/ChatModel.dart';
import 'package:flutter_medical_ui/model/ReviewModel.dart';
import 'package:flutter_medical_ui/model/ProfileModel.dart';
import 'package:flutter_medical_ui/model/AddressModel.dart';
import 'package:flutter_medical_ui/model/CardModel.dart';
import 'package:flutter_medical_ui/model/PatientModel.dart';
import 'package:flutter_medical_ui/model/PaymentModel.dart';
import 'package:flutter_medical_ui/model/OrderDescModel.dart';
import 'package:flutter_medical_ui/model/OrderModel.dart';
import 'package:flutter_medical_ui/model/ArticleModel.dart';
import 'package:flutter_medical_ui/model/StepModel.dart';
import 'package:flutter_medical_ui/model/VouchersModel.dart';
import 'package:flutter_medical_ui/model/ModelNotification.dart';
import 'package:flutter_medical_ui/model/PaymentSelectModel.dart';
import 'package:flutter_medical_ui/model/PaymentCardModel.dart';
import 'package:flutter_medical_ui/model/PrescriptionModel.dart';
import 'package:image_picker/image_picker.dart';

class DataFile {
  static List<PrescriptionModel> getPrescriptionList() {
    List<PrescriptionModel> subCatList = [];

    PrescriptionModel mainModel = new PrescriptionModel();
    mainModel.image = "pre_1.png";
    mainModel.name = "Uploaded";
    mainModel.type = "Submitted";
    mainModel.date = "5 Mar 2020";
    mainModel.time = "6:30 PM";
    subCatList.add(mainModel);

    mainModel = new PrescriptionModel();
    mainModel.name = "Uploaded";
    mainModel.type = "Approved";
    mainModel.image = "pre_2.jpg";
    mainModel.date = "8 Mar 2020";
    mainModel.time = "5:00 PM";
    subCatList.add(mainModel);

    mainModel = new PrescriptionModel();
    mainModel.name = "Uploaded";
    mainModel.type = "Denied";
    mainModel.image = "pre_3.png";
    mainModel.date = "2 Mar 2020";
    mainModel.time = "10:30 AM";
    subCatList.add(mainModel);

    mainModel = new PrescriptionModel();
    mainModel.name = "Uploaded";
    mainModel.type = "Submitted";
    mainModel.image = "pre_4.jpg";
    mainModel.date = "1 Mar 2020";
    mainModel.time = "7:00 AM";
    subCatList.add(mainModel);

    return subCatList;
  }

  static List<VouchersModel> getVouchersList() {
    List<VouchersModel> subCatList = [];

    VouchersModel mainModel = new VouchersModel();
    mainModel.id = 1;
    mainModel.name = "Black Fries Day";
    mainModel.desc = "All black fries 50% off*";
    mainModel.code = "BKD65R";
    mainModel.date = "25";
    mainModel.month = "Mar";
    mainModel.image = "logo_1.png";
    subCatList.add(mainModel);

    mainModel = new VouchersModel();
    mainModel.id = 2;
    mainModel.name = "Weekend specials";
    mainModel.desc = "All black sale 35% off*";
    mainModel.code = "FEB32#JJ";
    mainModel.date = "28";
    mainModel.month = "Feb";
    mainModel.image = "logo_2.png";
    subCatList.add(mainModel);

    mainModel = new VouchersModel();
    mainModel.id = 3;
    mainModel.name = "Specials Sale.!";
    mainModel.desc = "All black sale 35% off*";
    mainModel.code = "BMK56E";
    mainModel.date = "26";
    mainModel.month = "Feb";
    mainModel.image = "logo_3.jpg";
    subCatList.add(mainModel);

    return subCatList;
  }

  static ProfileModel getProfileModel() {
    ProfileModel mainModel = new ProfileModel();
    mainModel.email = "chloe_bird@gamil.com";
    mainModel.name = "Chloe B Bird";
    mainModel.image = "user_blank.png";
    return mainModel;
  }

  static List<PaymentModel> getPaymentList() {
    List<PaymentModel> subCatList = [];

    PaymentModel mainModel = new PaymentModel();
    mainModel.id = 2;
    mainModel.name = "Credit Card";
    mainModel.image = "assets/images/credit-card.png";
    subCatList.add(mainModel);

    mainModel = new PaymentModel();
    mainModel.id = 3;
    mainModel.name = "Net Banking";
    mainModel.image = "assets/images/bank.png";
    subCatList.add(mainModel);

    return subCatList;
  }

  static List<ModelNotification> getNotificationList() {
    List<ModelNotification> introList = [];
    introList.add(ModelNotification("Notification1",
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."));
    introList.add(ModelNotification("Notification2",
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."));
    introList.add(ModelNotification("Notification3",
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."));
    introList.add(ModelNotification("Notification4",
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."));
    introList.add(ModelNotification("Notification5",
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."));

    return introList;
  }

  static List<PaymentCardModel> getPaymentCardList() {
    List<PaymentCardModel> subCatList = [];

    PaymentCardModel mainModel = new PaymentCardModel();
    mainModel.id = 1;
    mainModel.name = "Credit Card";
    mainModel.image = "assets/images/visa.png";
    mainModel.desc = "XXXX XXXX XXXX 1234";
    subCatList.add(mainModel);

    mainModel = new PaymentCardModel();
    mainModel.id = 2;
    mainModel.name = "Bank Account";
    mainModel.desc = "Ending in 9457";
    mainModel.image = "assets/images/bank-building.png";
    subCatList.add(mainModel);

    mainModel = new PaymentCardModel();
    mainModel.id = 3;
    mainModel.name = "PayPal";
    mainModel.desc = "paypal@gmail.com";
    mainModel.image = "assets/images/paypal.png";
    subCatList.add(mainModel);

    return subCatList;
  }

  static List<String> getFilterPage() {
    List<String> subCatList = [];

    for (int i = 0; i < getCategoryModel().length; i++) {
      subCatList.add(getCategoryModel()[i].name);
    }

    return subCatList;
  }

  static List<CardModel> getCardList() {
    List<CardModel> subCatList = [];

    CardModel mainModel = new CardModel();
    mainModel.id = 1;
    mainModel.email = "chloe_bird@gmail.com";
    mainModel.cardNo = "2342 22** **** **00";
    mainModel.cVV = "***";
    mainModel.expDate = "06/23";
    mainModel.name = "Claudla T.Reyes";
    mainModel.image = "assets/images/visa.png";

    subCatList.add(mainModel);

    mainModel = new CardModel();
    mainModel.id = 2;
    mainModel.email = "chloe_bird@gmail.com";
    mainModel.cardNo = "2342 22** **** **00";
    mainModel.name = "Claudla T.Reyes";
    mainModel.cVV = "***";
    mainModel.expDate = "06/23";
    mainModel.image = "assets/images/mastercard.png";
    subCatList.add(mainModel);

    return subCatList;
  }

  static List<AddressModel> getAddressList() {
    List<AddressModel> subCatList = [];

    AddressModel mainModel = new AddressModel();
    mainModel.id = 1;
    mainModel.name = "Chloe B Bird";
    mainModel.phoneNumber = "+1(368)68 000 068";
    mainModel.location = "87  Great North Road,ALTON";
    mainModel.type = "Home";
    subCatList.add(mainModel);

    mainModel = new AddressModel();
    mainModel.id = 2;
    mainModel.name = "Rich P. Jeffery";
    mainModel.phoneNumber = "+1(368)68 000 068";
    mainModel.location = "4310 Clover Drive Colorado Springs, CO 80903";
    mainModel.type = "Company";
    subCatList.add(mainModel);

    return subCatList;
  }

  static List<AddressModel> getHomeAddressList() {
    List<AddressModel> subCatList = [];

    AddressModel mainModel = new AddressModel();
    mainModel.name = "Add\nAddress";
    subCatList.add(mainModel);

    mainModel = new AddressModel();
    mainModel.id = 1;
    mainModel.name = "Chloe B Bird";
    mainModel.phoneNumber = "+1(368)68 000 068";
    mainModel.location = "87  Great North Road,ALTON";
    mainModel.type = "Home";
    subCatList.add(mainModel);

    mainModel = new AddressModel();
    mainModel.id = 2;
    mainModel.name = "Rich P. Jeffery";
    mainModel.phoneNumber = "+1(368)68 000 068";
    mainModel.location = "4310 Clover Drive Colorado Springs, CO 80903";
    mainModel.type = "Company";
    subCatList.add(mainModel);

    return subCatList;
  }

  static List<ReviewModel> getReviewList() {
    List<ReviewModel> subCatList = [];

    ReviewModel mainModel = new ReviewModel();
    mainModel.id = 1;
    mainModel.name = "Soedirman";
    mainModel.image = "hugh.png";
    mainModel.desc =
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.";
    mainModel.review = 4;
    subCatList.add(mainModel);

    mainModel = new ReviewModel();
    mainModel.id = 2;
    mainModel.name = "Aisyah";
    mainModel.image = "hugh.png";
    mainModel.desc =
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.";
    mainModel.review = 3;
    subCatList.add(mainModel);

    mainModel = new ReviewModel();
    mainModel.id = 3;
    mainModel.image = "hugh.png";
    mainModel.name = "Jock Boerden";
    mainModel.desc =
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.";
    mainModel.review = 2;
    subCatList.add(mainModel);
    return subCatList;
  }

  static List<IntroModel> getIntroModel(BuildContext context) {
    List<IntroModel> introList = [];

    IntroModel mainModel = new IntroModel();
    mainModel.id = 1;
    mainModel.name = "Welcome!";
    mainModel.image = "intro_1.jpg";
    mainModel.desc =
        "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.";
    introList.add(mainModel);

    mainModel = new IntroModel();
    mainModel.id = 2;
    mainModel.name = "Choose us,Choose health";
    mainModel.image = "intro_2.jpg";
    mainModel.desc =
        "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.";
    introList.add(mainModel);

    mainModel = new IntroModel();
    mainModel.id = 3;
    mainModel.name = "Medical From Home";

    mainModel.image = "intro_3.jpg";
    mainModel.desc =
        "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.";
    introList.add(mainModel);

    return introList;
  }

  static List<CategoryModel> getCategoryModel() {
    List<CategoryModel> introList = [];

    CategoryModel mainModel = new CategoryModel();

    mainModel.id = 1;
    mainModel.name = "NewWellness";
    mainModel.icon = "wellness.png";
    mainModel.desc = "5 Items";
    mainModel.image = "wellness.jpg";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 2;
    mainModel.name = "Ayurveda";
    mainModel.icon = "ayurveda.png";
    mainModel.image = "ayurveda.jpg";
    mainModel.desc = "4 Items";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 3;
    mainModel.name = "Diabetes";
    mainModel.icon = "blood-test.png";
    mainModel.desc = "5 Items";
    mainModel.image = "dibetes.jpg";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 4;
    mainModel.name = "Vitamins";
    mainModel.icon = "vitamins.png";
    mainModel.desc = "5 Items";
    mainModel.image = "vitamins.jpg";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 5;
    mainModel.name = "Injury";
    mainModel.icon = "bandage.png";
    mainModel.desc = "5 Items";
    mainModel.image = "injury.jpg";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 6;
    mainModel.name = "Asthma";
    mainModel.icon = "inhaler.png";
    mainModel.desc = "5 Items";
    mainModel.image = "asthama.jpg";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 7;
    mainModel.name = "Heartburn";
    mainModel.icon = "heart.png";
    mainModel.desc = "5 Items";
    mainModel.image = "hurtburn.jpg";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 9;
    mainModel.name = "Arthritis";
    mainModel.icon = "joint.png";
    mainModel.desc = "5 Items";
    mainModel.image = "arthritis.jpg";
    introList.add(mainModel);

    return introList;
  }

  static List<PatientModel> getPatientList() {
    List<PatientModel> introList = [];

    PatientModel mainModel = new PatientModel();
    mainModel.name = "Add\nPatient";
    introList.add(mainModel);

    mainModel = new PatientModel();
    mainModel.name = "Jessika";
    mainModel.type = "GrandParent";
    introList.add(mainModel);

    mainModel = new PatientModel();
    mainModel.name = "Jessika";
    mainModel.type = "Children";
    introList.add(mainModel);
    mainModel = new PatientModel();
    mainModel.name = "Jessika";
    mainModel.type = "Children";
    introList.add(mainModel);

    return introList;
  }

  static List<CategoryModel> getAllCategoryModel() {
    List<CategoryModel> introList = [];

    CategoryModel mainModel = new CategoryModel();

    mainModel.id = 1;
    mainModel.name = "Wellness";
    mainModel.icon = "wellness.png";
    mainModel.desc = "5 Items";
    mainModel.image = "wellness.jpg";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 2;
    mainModel.name = "Ayurveda";
    mainModel.icon = "ayurveda.png";
    mainModel.image = "ayurveda.jpg";
    mainModel.desc = "4 Items";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 3;
    mainModel.name = "Diabetes";
    mainModel.icon = "blood-test.png";
    mainModel.desc = "5 Items";
    mainModel.image = "dibetes.jpg";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 4;
    mainModel.name = "Vitamins";
    mainModel.icon = "vitamins.png";
    mainModel.desc = "5 Items";
    mainModel.image = "vitamins.jpg";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 5;
    mainModel.name = "Injury";
    mainModel.icon = "bandage.png";
    mainModel.desc = "5 Items";
    mainModel.image = "injury.jpg";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 6;
    mainModel.name = "Asthma";
    mainModel.icon = "inhaler.png";
    mainModel.desc = "5 Items";
    mainModel.image = "asthama.jpg";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 7;
    mainModel.name = "Heartburn";
    mainModel.icon = "heart.png";
    mainModel.desc = "5 Items";
    mainModel.image = "hurtburn.jpg";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 9;
    mainModel.name = "Arthritis";
    mainModel.icon = "joint.png";
    mainModel.desc = "5 Items";
    mainModel.image = "arthritis.jpg";
    introList.add(mainModel);

    mainModel = new CategoryModel();

    mainModel.id = 1;
    mainModel.name = "Wellness";
    mainModel.icon = "wellness.png";
    mainModel.desc = "5 Items";
    mainModel.image = "wellness.jpg";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 2;
    mainModel.name = "Ayurveda";
    mainModel.icon = "ayurveda.png";
    mainModel.image = "ayurveda.jpg";
    mainModel.desc = "4 Items";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 3;
    mainModel.name = "Diabetes";
    mainModel.icon = "blood-test.png";
    mainModel.desc = "5 Items";
    mainModel.image = "dibetes.jpg";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 4;
    mainModel.name = "Vitamins";
    mainModel.icon = "vitamins.png";
    mainModel.desc = "5 Items";
    mainModel.image = "vitamins.jpg";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 5;
    mainModel.name = "Injury";
    mainModel.icon = "bandage.png";
    mainModel.desc = "5 Items";
    mainModel.image = "injury.jpg";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 6;
    mainModel.name = "Asthma";
    mainModel.icon = "inhaler.png";
    mainModel.desc = "5 Items";
    mainModel.image = "asthama.jpg";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 7;
    mainModel.name = "Heartburn";
    mainModel.icon = "heart.png";
    mainModel.desc = "5 Items";
    mainModel.image = "hurtburn.jpg";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 9;
    mainModel.name = "Arthritis";
    mainModel.icon = "joint.png";
    mainModel.desc = "5 Items";
    mainModel.image = "arthritis.jpg";
    introList.add(mainModel);
    mainModel = new CategoryModel();

    mainModel.id = 1;
    mainModel.name = "Wellness";
    mainModel.icon = "wellness.png";
    mainModel.desc = "5 Items";
    mainModel.image = "wellness.jpg";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 2;
    mainModel.name = "Ayurveda";
    mainModel.icon = "ayurveda.png";
    mainModel.image = "ayurveda.jpg";
    mainModel.desc = "4 Items";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 3;
    mainModel.name = "Diabetes";
    mainModel.icon = "blood-test.png";
    mainModel.desc = "5 Items";
    mainModel.image = "dibetes.jpg";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 4;
    mainModel.name = "Vitamins";
    mainModel.icon = "vitamins.png";
    mainModel.desc = "5 Items";
    mainModel.image = "vitamins.jpg";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 5;
    mainModel.name = "Injury";
    mainModel.icon = "bandage.png";
    mainModel.desc = "5 Items";
    mainModel.image = "injury.jpg";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 6;
    mainModel.name = "Asthma";
    mainModel.icon = "inhaler.png";
    mainModel.desc = "5 Items";
    mainModel.image = "asthama.jpg";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 7;
    mainModel.name = "Heartburn";
    mainModel.icon = "heart.png";
    mainModel.desc = "5 Items";
    mainModel.image = "hurtburn.jpg";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 9;
    mainModel.name = "Arthritis";
    mainModel.icon = "joint.png";
    mainModel.desc = "5 Items";
    mainModel.image = "arthritis.jpg";
    introList.add(mainModel);

    return introList;
  }

  static List<ArticleModel> getArticleModel() {
    List<ArticleModel> introList = [];

    ArticleModel mainModel = new ArticleModel();

    mainModel.id = 1;
    mainModel.image = "article_1.jpg";
    mainModel.type = "Healthy Eating";
    mainModel.doctorName = "Muriel Prosacco";
    mainModel.doctorImage = "hugh.png";
    mainModel.question = "10 Smart Diet Tips for the healthy human.";
    introList.add(mainModel);

    mainModel = new ArticleModel();
    mainModel.id = 2;
    mainModel.image = "article_2.jpg";
    mainModel.type = "Cardiologists";
    mainModel.question = "10 Smart Diet Tips for the healthy human.";
    mainModel.doctorName = "Muriel Prosacco";
    mainModel.doctorImage = "hugh.png";
    introList.add(mainModel);

    mainModel = new ArticleModel();
    mainModel.id = 3;
    mainModel.image = "article_3.jpg";
    mainModel.type = "Dentist";
    mainModel.question = "10 Smart Diet Tips for the healthy human.";
    mainModel.doctorName = "Muriel Prosacco";
    mainModel.doctorImage = "hugh.png";
    introList.add(mainModel);

    mainModel = new ArticleModel();
    mainModel.id = 4;
    mainModel.image = "article_4.jpg";
    mainModel.doctorName = "Dietitian/NutritionList";
    mainModel.type = "Muriel Prosacco";
    mainModel.question = "10 Smart Diet Tips for the healthy human.";
    mainModel.doctorImage = "hugh.png";
    introList.add(mainModel);

    mainModel = new ArticleModel();
    mainModel.id = 5;
    mainModel.question = "10 Smart Diet Tips for the healthy human.";
    mainModel.image = "article_5.jpg";
    mainModel.doctorName = "Muriel Prosacco";
    mainModel.type = "Endocrinologists";
    mainModel.doctorImage = "hugh.png";
    introList.add(mainModel);

    return introList;
  }

  static List<StepModel> getStepsModel() {
    List<StepModel> introList = [];

    StepModel mainModel = new StepModel();
    mainModel.image = "checklist.png";
    mainModel.name = "STEP 1";
    mainModel.desc = "Upload\nPrescription";
    introList.add(mainModel);

    mainModel = new StepModel();
    mainModel.image = "medicine.png";
    mainModel.name = "STEP 2";
    mainModel.desc = "Pharmacist Packs\nthe Medicines.";
    introList.add(mainModel);

    mainModel = new StepModel();
    mainModel.image = "shipped.png";
    mainModel.name = "STEP 3";
    mainModel.desc = "Delivered to\nyour doorstep";
    introList.add(mainModel);

    return introList;
  }

  static List<SubCategoryModel> getSubCategoryModel() {
    List<SubCategoryModel> subList = [];

    SubCategoryModel mainModel = new SubCategoryModel();
    mainModel.catId = 5;
    mainModel.id = 1;
    mainModel.review = 3;
    mainModel.isFav = 1;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Natural jasmin";
    mainModel.image = "medicine_1.jpg";
    mainModel.price = "\$80.50";
    mainModel.offPrice = "MRP \$120";
    mainModel.offer = "20% off";
    mainModel.desc = "Bottle of 100 capsule";
    mainModel.companyName = "Derma PVT ltd";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 5;
    mainModel.id = 2;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Syrup";
    mainModel.image = "medicine_2.jpg";
    mainModel.price = "\$120.50";
    mainModel.offPrice = "MRP \$220";
    mainModel.offer = "15% off";
    mainModel.price = "\$5.95";
    mainModel.desc = "Bottle of 200 ml";
    mainModel.companyName = "AstraZeneca";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 5;
    mainModel.id = 3;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.isFav = 1;
    mainModel.name = "Hand sanitizer";
    mainModel.image = "medicine_3.jpg";
    mainModel.price = "\$220.25";
    mainModel.offPrice = "";
    mainModel.offer = "";
    mainModel.desc = "Liquid (200 ml)";
    mainModel.companyName = "GlaxoSmithKline";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 5;
    mainModel.isFav = 1;
    mainModel.id = 5;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Pearls";
    mainModel.image = "medicine_5.jpg";
    mainModel.price = "\$220.25";
    mainModel.offPrice = "";
    mainModel.offer = "";
    mainModel.companyName = "GlaxoSmithKline";
    mainModel.desc = "Bottle of 150 ml";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 5;
    mainModel.id = 6;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.isFav = 1;
    mainModel.name = "Pearls";
    mainModel.companyName = "GlaxoSmithKline";
    mainModel.image = "medicine_6.jpg";
    mainModel.price = "\$80.50";
    mainModel.offPrice = "MRP \$120";
    mainModel.offer = "20% off";
    mainModel.desc = "Bottle of 150 ml";
    subList.add(mainModel);

    return subList;
  }

  static List<OrderDescModel> getOrderDescList() {
    List<OrderDescModel> subCatList = [];

    OrderDescModel mainModel = new OrderDescModel();
    mainModel.name = "Order Placed";
    mainModel.desc = "January 19th,12:02 AM";
    mainModel.completed = 1;
    subCatList.add(mainModel);

    mainModel = new OrderDescModel();
    mainModel.name = "Order Confirmed";
    mainModel.desc = "January 19th,12:02 AM";
    mainModel.completed = 1;
    subCatList.add(mainModel);

    mainModel = new OrderDescModel();
    mainModel.name = "Your Order On Delivery by Courier";
    mainModel.desc = "January 19th,12:02 AM";
    mainModel.completed = 1;
    subCatList.add(mainModel);

    mainModel = new OrderDescModel();
    mainModel.name = "Order Delivered";
    mainModel.desc = "January 19th,12:02 AM";
    mainModel.completed = 0;
    subCatList.add(mainModel);

    return subCatList;
  }

  static List<SubCategoryModel> getMyOrderList() {
    List<SubCategoryModel> subList = [];

    SubCategoryModel mainModel = new SubCategoryModel();
    mainModel.catId = 5;
    mainModel.id = 1;
    mainModel.review = 3;
    mainModel.isFav = 1;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Natural jasmin";
    mainModel.image = "medicine_1.jpg";
    mainModel.price = "\$80.50";
    mainModel.offPrice = "MRP \$120";
    mainModel.offer = "20% off";
    mainModel.desc = "Bottle of 100 capsule";
    mainModel.companyName = "Derma PVT ltd";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 5;
    mainModel.id = 2;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Syrup";
    mainModel.image = "medicine_2.jpg";
    mainModel.price = "\$120.50";
    mainModel.offPrice = "MRP \$220";
    mainModel.offer = "15% off";
    mainModel.price = "\$5.95";
    mainModel.desc = "Bottle of 200 ml";
    mainModel.companyName = "AstraZeneca";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 5;
    mainModel.id = 3;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.isFav = 1;
    mainModel.name = "Hand sanitizer";
    mainModel.image = "medicine_3.jpg";
    mainModel.price = "\$220.25";
    mainModel.offPrice = "";
    mainModel.offer = "";
    mainModel.desc = "Liquid (200 ml)";
    mainModel.companyName = "GlaxoSmithKline";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 5;
    mainModel.isFav = 1;
    mainModel.id = 5;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Pearls";
    mainModel.image = "medicine_5.jpg";
    mainModel.price = "\$220.25";
    mainModel.offPrice = "";
    mainModel.offer = "";
    mainModel.companyName = "GlaxoSmithKline";
    mainModel.desc = "Bottle of 150 ml";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 5;
    mainModel.id = 6;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.isFav = 1;
    mainModel.name = "Pearls";
    mainModel.companyName = "GlaxoSmithKline";
    mainModel.image = "medicine_6.jpg";
    mainModel.price = "\$80.50";
    mainModel.offPrice = "MRP \$120";
    mainModel.offer = "20% off";
    mainModel.desc = "Bottle of 150 ml";
    subList.add(mainModel);

    return subList;
  }

  static List<SliderModel> getSliderList() {
    List<SliderModel> list = [];

    SliderModel sliderModel = new SliderModel();
    sliderModel.title = "Wellness";
    sliderModel.desc = "Best-in-class safety measures";
    sliderModel.image = "sli_1_1.png";
    sliderModel.offerText = "60% off";
    list.add(sliderModel);

    sliderModel = new SliderModel();
    sliderModel.title = "Asthma";
    sliderModel.desc = "Best-in-class safety measures";
    sliderModel.image = "sli_2_2.png";
    sliderModel.offerText = "20% off";
    list.add(sliderModel);

    sliderModel = new SliderModel();
    sliderModel.title = "Ayurveda";
    sliderModel.desc = "Best-in-class safety measures";
    sliderModel.image = "sli_3_3.png";
    sliderModel.offerText = "10% off";
    list.add(sliderModel);

    return list;
  }

  static List<ChatModel> getChatUserList() {
    List<ChatModel> introList = [];
    introList.add(ChatModel("John", "hugh.png", 1, "Hi", "02:00", "15-4-2021"));
    introList.add(
        ChatModel("Soedirman", "hugh.png", 0, "Hello", "14:25", "12-3-2021"));
    introList
        .add(ChatModel("Aisyah", "hugh.png", 0, "Hy", "03:21", "02-3-2021"));
    introList.add(
        ChatModel("Jock Boerden", "hugh.png", 1, "Hi", "18:36", "02-3-2021"));
    introList
        .add(ChatModel("Sophia", "hugh.png", 0, "Hello", "22:45", "25-2-2021"));
    introList.add(ChatModel("Ava", "hugh.png", 1, "Hi", "06:00", "16-2-2021"));
    introList
        .add(ChatModel("James", "hugh.png", 0, "Hi", "02:15", "15-2-2021"));

    return introList;
  }

  static List<SubCategoryModel> getCartModel() {
    List<SubCategoryModel> subList = [];

    SubCategoryModel mainModel = new SubCategoryModel();
    mainModel.catId = 5;
    mainModel.id = 1;
    mainModel.review = 3;
    mainModel.isFav = 1;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Natural jasmin";
    mainModel.image = "medicine_1.jpg";
    mainModel.price = "\$80.50";
    mainModel.offPrice = "MRP \$120";
    mainModel.offer = "20% off";
    mainModel.desc = "Bottle of 100 capsule";
    mainModel.companyName = "Derma PVT ltd";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 5;
    mainModel.id = 2;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Syrup";
    mainModel.image = "medicine_2.jpg";
    mainModel.price = "\$120.50";
    mainModel.offPrice = "MRP \$220";
    mainModel.offer = "15% off";
    mainModel.price = "\$5.95";
    mainModel.desc = "Bottle of 200 ml";
    mainModel.companyName = "AstraZeneca";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 5;
    mainModel.id = 3;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.isFav = 1;
    mainModel.name = "Hand sanitizer";
    mainModel.image = "medicine_3.jpg";
    mainModel.price = "\$220.25";
    mainModel.offPrice = "";
    mainModel.offer = "";
    mainModel.desc = "Liquid (200 ml)";
    mainModel.companyName = "GlaxoSmithKline";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 5;
    mainModel.isFav = 1;
    mainModel.id = 5;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Pearls";
    mainModel.image = "medicine_5.jpg";
    mainModel.price = "\$220.25";
    mainModel.offPrice = "";
    mainModel.offer = "";
    mainModel.companyName = "GlaxoSmithKline";
    mainModel.desc = "Bottle of 150 ml";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 5;
    mainModel.id = 6;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.isFav = 1;
    mainModel.name = "Pearls";
    mainModel.companyName = "GlaxoSmithKline";
    mainModel.image = "medicine_6.jpg";
    mainModel.price = "\$80.50";
    mainModel.offPrice = "MRP \$120";
    mainModel.offer = "20% off";
    mainModel.desc = "Bottle of 150 ml";
    subList.add(mainModel);

    return subList;
  }

  static List<OrderModel> getOrderList() {
    List<OrderModel> subCatList = [];

    OrderModel mainModel = new OrderModel();
    mainModel.id = 1;
    mainModel.orderId = "#0012345";
    mainModel.items = "12 Items";
    mainModel.type = "On Delivery";
    subCatList.add(mainModel);

    mainModel = new OrderModel();
    mainModel.id = 2;
    mainModel.orderId = "#0012346";
    mainModel.items = "5 Items";
    mainModel.type = "Completed";
    subCatList.add(mainModel);

    mainModel = new OrderModel();
    mainModel.id = 3;
    mainModel.orderId = "#0012347";
    mainModel.items = "10 Items";
    mainModel.type = "Canceled";
    subCatList.add(mainModel);

    mainModel = new OrderModel();
    mainModel.id = 4;
    mainModel.orderId = "#0012348";
    mainModel.items = "8 Items";
    mainModel.type = "Completed";
    subCatList.add(mainModel);

    return subCatList;
  }

  static List<PaymentSelectModel> getPaymentSelect() {
    List<PaymentSelectModel> introList = [];
    introList.add(PaymentSelectModel("Cash", Icons.attach_money, 1));
    introList
        .add(PaymentSelectModel("Pay via Card", Icons.credit_card_outlined, 0));

    return introList;
  }

  static List<PickedFile> getImageList() {
    List<PickedFile> introList = [];
    introList.add(null);
    return introList;
  }
}

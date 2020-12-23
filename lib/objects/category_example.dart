import 'package:gimig_gastro_application/classes/category_class.dart';
import 'package:gimig_gastro_application/objects/items_example.dart';
import 'package:gimig_gastro_application/screens/category_screen.dart';
import 'package:gimig_gastro_application/screens/daily_menu_screen_beta.dart';
import 'package:gimig_gastro_application/screens/small_card_screen.dart';

//
//
// SPEISEN //
//
//

// GÄNGE
Category courses = Category(
  title: "Speisen",
  items: [
    daily,
    starter,
    mainCourse,
    dessert,
    specials,
  ],
);

// TAGESKARTE
Category daily = Category(
  title: "Tageskarte",
  coverImage: "images/Hauptspeise3c.png",
  pushScreen: DailyMenuBetaScreen.id,
  items: [],
);

// VORSPEISEN
Category starter = Category(
  title: "Vorspeisen",
  coverImage: "images/Vorspeise2.png",
  pushScreen: SmallCardScreen.id,
  items: [
    meal1,
    meal2,
    meal3,
    meal4,
    meal5,
    meal6,
    meal7,
    meal8,
    meal9,
    meal10,
    meal11
  ],
);

// HAUPTSPEISEN KATEGORIEN
Category mainCourse = Category(
  title: "Hauptspeisen",
  coverImage: "images/Hauptspeise1.png",
  pushScreen: CategoryScreen.id,
  items: [
    pasta,
    pizza,
    alforno,
    carne,
    pesce,
  ],
);

// DESSERT
Category dessert = Category(
  title: "Dessert",
  coverImage: "images/IMG_7573_M.jpg",
  pushScreen: SmallCardScreen.id,
  items: [
    meal65,
    meal66,
    meal67,
  ],
);

// SPEZIALITÄTEN
Category specials = Category(
  title: "Spezialitäten",
  coverImage: "images/Hauptspeise4b.png",
  pushScreen: SmallCardScreen.id,
  items: [
    meal62,
    meal63,
    meal64,
  ],
);

// PASTA
Category pasta = Category(
  title: "Pasta",
  coverImage: "images/Spaghetti-Marinara-Frutti-di-Mare.jpg",
  pushScreen: SmallCardScreen.id,
  items: [
    meal12,
    meal13,
    meal14,
    meal15,
    meal16,
    meal17,
    meal18,
    meal19,
    meal20,
    meal21,
    meal22,
    meal23,
  ],
);

// PIZZA
Category pizza = Category(
  title: "Pizza",
  coverImage: "images/Hauptspeise1.png",
  pushScreen: SmallCardScreen.id,
  items: [
    meal24,
    meal25,
    meal26,
    meal27,
    meal28,
    meal29,
    meal30,
    meal31,
    meal32,
    meal33,
    meal34,
    meal35,
    meal36,
    meal37,
    meal38,
    meal39,
    meal40,
  ],
);

// AL FORNO
Category alforno = Category(
  title: "Al Forno",
  coverImage: "images/Hauptspeise4c.png",
  pushScreen: SmallCardScreen.id,
  items: [
    meal41,
    meal42,
    meal43,
    meal44,
    meal45,
  ],
);

// CARNE
Category carne = Category(
  title: "Carne",
  coverImage: "images/Hauptspeise3c.png",
  pushScreen: SmallCardScreen.id,
  items: [
    meal46,
    meal47,
    meal48,
    meal49,
    meal50,
    meal51,
    meal52,
    meal53,
    meal54,
    meal55,
  ],
);

// PESCE
Category pesce = Category(
  title: "Pesce",
  coverImage: "images/Hauptspeise5c.png",
  pushScreen: SmallCardScreen.id,
  items: [
    meal56,
    meal57,
    meal58,
    meal59,
    meal60,
    meal61,
  ],
);

//
//
// GETRÄNKE //
//
//

// GETRÄNKE KATEGORIEN
Category beverages = Category(
  title: "Getränke",
  pushScreen: SmallCardScreen.id,
  items: [
    softgetraenke,
    biere,
    weine,
    schnaps,
    cocktails,
  ],
);

// SOFTGETRÄNKE
Category softgetraenke = Category(
  coverImage: "images/unnamed.jpg",
  title: "Softgetränke",
  pushScreen: SmallCardScreen.id,
  items: [
    beverage1,
    beverage12,
    beverage3,
  ],
);

// BIERE
Category biere = Category(
  coverImage: "images/bierglas-tisch.jpg",
  title: "Biere",
  pushScreen: SmallCardScreen.id,
  items: [
    beverage1,
    beverage12,
    beverage3,
  ],
);

// WEINE
Category weine = Category(
  coverImage: "images/ABC.jpg",
  title: "Weine",
  pushScreen: SmallCardScreen.id,
  items: [
    beverage1,
    beverage12,
    beverage3,
  ],
);

// SCHNAPS
Category schnaps = Category(
  coverImage: "images/FdW_Schnaps-Verdauung_iStock-Sanny11.jpg",
  title: "Schnaps",
  pushScreen: SmallCardScreen.id,
  items: [
    beverage1,
    beverage12,
    beverage3,
  ],
);

// COCKTAILS
Category cocktails = Category(
  coverImage: "images/sex-on-the-beach-rezept.jpg",
  title: "Cocktails",
  pushScreen: SmallCardScreen.id,
  items: [
    beverage1,
    beverage12,
    beverage3,
  ],
);

// Sadfiesch's Hotel system

#include <a_samp>
#include <zcmd>
#include <Dini>

//Constants
#define MAX_HOTEL_SUITES 500 //todo change this to whatever it needs to be
#define MAX_ROOMS 10 //5 cheap rooms(type 1) 5 fancy rooms(type2)
//Colors
#define COLOR_GREEN 0x33AA33AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_RED 0xAA3333AA

//Variables
new totalSuites = 0;

//Dialoges
#define DIALOG_RENTROOM 9991
#define DIALOG_HOTEL_MIETER 9992


//Forwards


//------------------------------------------------------------------------------
enum hotelSuiteInfo
{
	suiteId,
	suiteRented,
	suitePrice,
 	Float:suiteEnterX,
	Float:suiteEnterY,
	Float:suiteEnterZ,
	Float:suiteX,
 	Float:suiteY,
 	Float:suiteZ,
 	suiteInterior,
 	suiteOwner[MAX_PLAYER_NAME + 1],
 	//Todo add more stuff that might be usefull
};

new HotelSuiteInfos[MAX_HOTEL_SUITES][hotelSuiteInfo]; //todo rename this?

//todo this is absolute shit. are nested enum's possible in pawn?
enum roomInfo
{
	Float:roomX,
 	Float:roomY,
 	Float:roomZ,
 	roomInterior,
 	roomPrice,
 	roomType,
};

new niceRooms[MAX_ROOMS][roomInfo];
new shitRooms[MAX_ROOMS][roomInfo];

//------------------------------------------------------------------------------
//Create game objects:
stock createRooms(){
CreateObject(19379, 1254.93457, -958.11609, 1082.98340,   0.00000, 90.00000, 0.00000);
CreateObject(2298, 1256.46875, -957.36908, 1083.02844,   0.00000, 0.00000, 0.00000);
CreateObject(19448, 1252.00000, -958.06439, 1084.81995,   0.00000, 0.00000, 0.00000);
CreateObject(19448, 1259.74243, -958.01746, 1084.81995,   0.00000, 0.00000, 0.00000);
CreateObject(19448, 1254.86377, -953.27661, 1084.81995,   0.00000, 0.00000, 90.00000);
CreateObject(19448, 1254.91064, -962.84882, 1084.81995,   0.00000, 0.00000, 90.00000);
CreateObject(19379, 1254.62061, -957.98071, 1086.56335,   0.00000, 90.00000, 0.00000);
CreateObject(2196, 1259.68396, -954.05286, 1083.57996,   0.00000, 0.00000, 280.00000);
CreateObject(2196, 1256.67822, -954.24127, 1083.57996,   0.00000, 0.00000, 250.00000);
CreateObject(1755, 1258.29382, -958.92700, 1083.07104,   0.00000, 0.00000, 320.00000);
CreateObject(1755, 1256.57666, -958.64661, 1083.07104,   0.00000, 0.00000, 0.00000);
CreateObject(1755, 1255.23486, -960.18164, 1083.07104,   0.00000, 0.00000, 50.00000);
CreateObject(2323, 1257.75110, -961.23755, 1083.07080,   0.00000, 0.00000, 180.00000);
CreateObject(19787, 1257.28613, -962.41736, 1084.49805,   0.00000, 0.00000, 180.00000);
CreateObject(1827, 1257.45935, -960.45520, 1083.07056,   0.00000, 0.00000, 0.00000);
//CreateObject(2196, 1253.40076, -961.16138, 1085.00000,   0.00000, 0.00000, 250.00000);
CreateObject(1742, 1254.86731, -953.25378, 1083.07019,   0.00000, 0.00000, 0.00000);
CreateObject(1742, 1253.42615, -953.21918, 1083.07019,   0.00000, 0.00000, 0.00000);
CreateObject(2631, 1254.33569, -955.51929, 1083.07043,   0.00000, 0.00000, 0.00000);
CreateObject(2631, 1254.33569, -957.00000, 1083.07043,   0.00000, 0.00000, 0.00000);
CreateObject(19802, 1252.06641, -961.43781, 1083.07019,   0.00000, 0.00000, 90.00000);
CreateObject(2267, 1259.63196, -960.63489, 1084.99707,   0.00000, 0.00000, 270.00000);
CreateObject(2258, 1257.76282, -953.38849, 1084.62415,   0.00000, 0.00000, 0.00000);
CreateObject(19379, 1254.93457, -958.11609, 1072.98340,   0.00000, 90.00000, 0.00000);
CreateObject(2298, 1256.46875, -957.36908, 1073.02844,   0.00000, 0.00000, 0.00000);
CreateObject(19448, 1252.00000, -958.06439, 1074.81995,   0.00000, 0.00000, 0.00000);
CreateObject(19448, 1259.74243, -958.01746, 1074.81995,   0.00000, 0.00000, 0.00000);
CreateObject(19448, 1254.86377, -953.27661, 1074.81995,   0.00000, 0.00000, 90.00000);
CreateObject(19448, 1254.91064, -962.84882, 1074.81995,   0.00000, 0.00000, 90.00000);
CreateObject(19379, 1254.62061, -957.98071, 1076.56335,   0.00000, 90.00000, 0.00000);
CreateObject(2196, 1259.68396, -954.05286, 1073.57996,   0.00000, 0.00000, 280.00000);
CreateObject(2196, 1256.67822, -954.24127, 1073.57996,   0.00000, 0.00000, 250.00000);
CreateObject(1755, 1258.29382, -958.92700, 1073.07104,   0.00000, 0.00000, 320.00000);
CreateObject(1755, 1256.57666, -958.64661, 1073.07104,   0.00000, 0.00000, 0.00000);
CreateObject(1755, 1255.23486, -960.18164, 1073.07104,   0.00000, 0.00000, 50.00000);
CreateObject(2323, 1257.75110, -961.23755, 1073.07080,   0.00000, 0.00000, 180.00000);
CreateObject(19787, 1257.28613, -962.41736, 1074.49805,   0.00000, 0.00000, 180.00000);
CreateObject(1827, 1257.45935, -960.45520, 1073.07056,   0.00000, 0.00000, 0.00000);
//CreateObject(2196, 1253.40076, -961.16138, 1075.00000,   0.00000, 0.00000, 250.00000);
CreateObject(1742, 1254.86731, -953.25378, 1073.07019,   0.00000, 0.00000, 0.00000);
CreateObject(1742, 1253.42615, -953.21918, 1073.07019,   0.00000, 0.00000, 0.00000);
CreateObject(2631, 1254.33569, -955.51929, 1073.07043,   0.00000, 0.00000, 0.00000);
CreateObject(2631, 1254.33569, -957.00000, 1073.07043,   0.00000, 0.00000, 0.00000);
CreateObject(19802, 1252.06641, -961.43781, 1073.07019,   0.00000, 0.00000, 90.00000);
CreateObject(2267, 1259.63196, -960.63489, 1074.99707,   0.00000, 0.00000, 270.00000);
CreateObject(2258, 1257.76282, -953.38849, 1074.62415,   0.00000, 0.00000, 0.00000);
CreateObject(19379, 1254.93457, -958.11609, 1062.98340,   0.00000, 90.00000, 0.00000);
CreateObject(2298, 1256.46875, -957.36908, 1063.02844,   0.00000, 0.00000, 0.00000);
CreateObject(19448, 1252.00000, -958.06439, 1064.81995,   0.00000, 0.00000, 0.00000);
CreateObject(19448, 1259.74243, -958.01746, 1064.81995,   0.00000, 0.00000, 0.00000);
CreateObject(19448, 1254.86377, -953.27661, 1064.81995,   0.00000, 0.00000, 90.00000);
CreateObject(19448, 1254.91064, -962.84882, 1064.81995,   0.00000, 0.00000, 90.00000);
CreateObject(19379, 1254.62061, -957.98071, 1066.56335,   0.00000, 90.00000, 0.00000);
CreateObject(2196, 1259.68396, -954.05286, 1063.57996,   0.00000, 0.00000, 280.00000);
CreateObject(2196, 1256.67822, -954.24127, 1063.57996,   0.00000, 0.00000, 250.00000);
CreateObject(1755, 1258.29382, -958.92700, 1063.07104,   0.00000, 0.00000, 320.00000);
CreateObject(1755, 1256.57666, -958.64661, 1063.07104,   0.00000, 0.00000, 0.00000);
CreateObject(1755, 1255.23486, -960.18164, 1063.07104,   0.00000, 0.00000, 50.00000);
CreateObject(2323, 1257.75110, -961.23755, 1063.07080,   0.00000, 0.00000, 180.00000);
CreateObject(19787, 1257.28613, -962.41736, 1064.49805,   0.00000, 0.00000, 180.00000);
CreateObject(1827, 1257.45935, -960.45520, 1063.07056,   0.00000, 0.00000, 0.00000);
//CreateObject(2196, 1253.40076, -961.16138, 1065.00000,   0.00000, 0.00000, 250.00000);
CreateObject(1742, 1254.86731, -953.25378, 1063.07019,   0.00000, 0.00000, 0.00000);
CreateObject(1742, 1253.42615, -953.21918, 1063.07019,   0.00000, 0.00000, 0.00000);
CreateObject(2631, 1254.33569, -955.51929, 1063.07043,   0.00000, 0.00000, 0.00000);
CreateObject(2631, 1254.33569, -957.00000, 1063.07043,   0.00000, 0.00000, 0.00000);
CreateObject(19802, 1252.06641, -961.43781, 1063.07019,   0.00000, 0.00000, 90.00000);
CreateObject(2267, 1259.63196, -960.63489, 1064.99707,   0.00000, 0.00000, 270.00000);
CreateObject(2258, 1257.76282, -953.38849, 1064.62415,   0.00000, 0.00000, 0.00000);
CreateObject(19379, 1254.93457, -958.11609, 1052.98340,   0.00000, 90.00000, 0.00000);
CreateObject(2298, 1256.46875, -957.36908, 1053.02844,   0.00000, 0.00000, 0.00000);
CreateObject(19448, 1252.00000, -958.06439, 1054.81995,   0.00000, 0.00000, 0.00000);
CreateObject(19448, 1259.74243, -958.01746, 1054.81995,   0.00000, 0.00000, 0.00000);
CreateObject(19448, 1254.86377, -953.27661, 1054.81995,   0.00000, 0.00000, 90.00000);
CreateObject(19448, 1254.91064, -962.84882, 1054.81995,   0.00000, 0.00000, 90.00000);
CreateObject(19379, 1254.62061, -957.98071, 1056.56335,   0.00000, 90.00000, 0.00000);
CreateObject(2196, 1259.68396, -954.05286, 1053.57996,   0.00000, 0.00000, 280.00000);
CreateObject(2196, 1256.67822, -954.24127, 1053.57996,   0.00000, 0.00000, 250.00000);
CreateObject(1755, 1258.29382, -958.92700, 1053.07104,   0.00000, 0.00000, 320.00000);
CreateObject(1755, 1256.57666, -958.64661, 1053.07104,   0.00000, 0.00000, 0.00000);
CreateObject(1755, 1255.23486, -960.18164, 1053.07104,   0.00000, 0.00000, 50.00000);
CreateObject(2323, 1257.75110, -961.23755, 1053.07080,   0.00000, 0.00000, 180.00000);
CreateObject(19787, 1257.28613, -962.41736, 1054.49805,   0.00000, 0.00000, 180.00000);
CreateObject(1827, 1257.45935, -960.45520, 1053.07056,   0.00000, 0.00000, 0.00000);
//CreateObject(2196, 1253.40076, -961.16138, 1055.00000,   0.00000, 0.00000, 250.00000);
CreateObject(1742, 1254.86731, -953.25378, 1053.07019,   0.00000, 0.00000, 0.00000);
CreateObject(1742, 1253.42615, -953.21918, 1053.07019,   0.00000, 0.00000, 0.00000);
CreateObject(2631, 1254.33569, -955.51929, 1053.07043,   0.00000, 0.00000, 0.00000);
CreateObject(2631, 1254.33569, -957.00000, 1053.07043,   0.00000, 0.00000, 0.00000);
CreateObject(19802, 1252.06641, -961.43781, 1053.07019,   0.00000, 0.00000, 90.00000);
CreateObject(2267, 1259.63196, -960.63489, 1054.99707,   0.00000, 0.00000, 270.00000);
CreateObject(2258, 1257.76282, -953.38849, 1054.62415,   0.00000, 0.00000, 0.00000);
CreateObject(19379, 1254.93457, -958.11609, 1042.98340,   0.00000, 90.00000, 0.00000);
CreateObject(2298, 1256.46875, -957.36908, 1043.02844,   0.00000, 0.00000, 0.00000);
CreateObject(19448, 1252.00000, -958.06439, 1044.81995,   0.00000, 0.00000, 0.00000);
CreateObject(19448, 1259.74243, -958.01746, 1044.81995,   0.00000, 0.00000, 0.00000);
CreateObject(19448, 1254.86377, -953.27661, 1044.81995,   0.00000, 0.00000, 90.00000);
CreateObject(19448, 1254.91064, -962.84882, 1044.81995,   0.00000, 0.00000, 90.00000);
CreateObject(19379, 1254.62061, -957.98071, 1046.56335,   0.00000, 90.00000, 0.00000);
CreateObject(2196, 1259.68396, -954.05286, 1043.57996,   0.00000, 0.00000, 280.00000);
CreateObject(2196, 1256.67822, -954.24127, 1043.57996,   0.00000, 0.00000, 250.00000);
CreateObject(1755, 1258.29382, -958.92700, 1043.07104,   0.00000, 0.00000, 320.00000);
CreateObject(1755, 1256.57666, -958.64661, 1043.07104,   0.00000, 0.00000, 0.00000);
CreateObject(1755, 1255.23486, -960.18164, 1043.07104,   0.00000, 0.00000, 50.00000);
CreateObject(2323, 1257.75110, -961.23755, 1043.07080,   0.00000, 0.00000, 180.00000);
CreateObject(19787, 1257.28613, -962.41736, 1044.49805,   0.00000, 0.00000, 180.00000);
CreateObject(1827, 1257.45935, -960.45520, 1043.07056,   0.00000, 0.00000, 0.00000);
//CreateObject(2196, 1253.40076, -961.16138, 1045.00000,   0.00000, 0.00000, 250.00000);
CreateObject(1742, 1254.86731, -953.25378, 1043.07019,   0.00000, 0.00000, 0.00000);
CreateObject(1742, 1253.42615, -953.21918, 1043.07019,   0.00000, 0.00000, 0.00000);
CreateObject(2631, 1254.33569, -955.51929, 1043.07043,   0.00000, 0.00000, 0.00000);
CreateObject(2631, 1254.33569, -957.00000, 1043.07043,   0.00000, 0.00000, 0.00000);
CreateObject(19802, 1252.06641, -961.43781, 1043.07019,   0.00000, 0.00000, 90.00000);
CreateObject(2267, 1259.63196, -960.63489, 1044.99707,   0.00000, 0.00000, 270.00000);
CreateObject(2258, 1257.76282, -953.38849, 1044.62415,   0.00000, 0.00000, 0.00000);

//shit houses
CreateObject(19379, 1240.79517, -957.33234, 1082.98340,   0.00000, 90.00000, 0.00000);
CreateObject(19360, 1245.20068, -954.44354, 1084.80005,   0.00000, 0.00000, 0.00000);
CreateObject(19360, 1245.20068, -957.64478, 1084.80005,   0.00000, 0.00000, 0.00000);
CreateObject(19360, 1243.62024, -952.92035, 1084.80005,   0.00000, 0.00000, 90.00000);
CreateObject(19360, 1240.45996, -952.92029, 1084.80005,   0.00000, 0.00000, 90.00000);
CreateObject(19360, 1243.66016, -952.92029, 1084.80005,   0.00000, 0.00000, 90.00000);
CreateObject(19360, 1243.62024, -959.17999, 1084.80005,   0.00000, 0.00000, 90.00000);
CreateObject(19360, 1240.45996, -959.17999, 1084.80005,   0.00000, 0.00000, 90.00000);
CreateObject(19360, 1239.00000, -954.44348, 1084.80005,   0.00000, 0.00000, 0.00000);
CreateObject(19360, 1239.00000, -957.64478, 1084.80005,   0.00000, 0.00000, 0.00000);
CreateObject(2565, 1239.53650, -955.52209, 1083.49060,   0.00000, 0.00000, 0.00000);
CreateObject(19802, 1245.13440, -958.68323, 1083.07019,   0.00000, 0.00000, 90.00000);
CreateObject(2631, 1241.82312, -957.37988, 1083.07104,   0.00000, 0.00000, 0.00000);
CreateObject(19379, 1240.79517, -957.33228, 1086.56335,   0.00000, 90.00000, 0.00000);
//CreateObject(2196, 1244.59595, -958.44623, 1085.00000,   0.00000, 0.00000, 250.00000);

CreateObject(19379, 1240.79517, -957.33234, 1072.98340,   0.00000, 90.00000, 0.00000);
CreateObject(19360, 1245.20068, -954.44354, 1074.80005,   0.00000, 0.00000, 0.00000);
CreateObject(19360, 1245.20068, -957.64478, 1074.80005,   0.00000, 0.00000, 0.00000);
CreateObject(19360, 1243.62024, -952.92035, 1074.80005,   0.00000, 0.00000, 90.00000);
CreateObject(19360, 1240.45996, -952.92029, 1074.80005,   0.00000, 0.00000, 90.00000);
CreateObject(19360, 1243.66016, -952.92029, 1074.80005,   0.00000, 0.00000, 90.00000);
CreateObject(19360, 1243.62024, -959.17999, 1074.80005,   0.00000, 0.00000, 90.00000);
CreateObject(19360, 1240.45996, -959.17999, 1074.80005,   0.00000, 0.00000, 90.00000);
CreateObject(19360, 1239.00000, -954.44348, 1074.80005,   0.00000, 0.00000, 0.00000);
CreateObject(19360, 1239.00000, -957.64478, 1074.80005,   0.00000, 0.00000, 0.00000);
CreateObject(2565, 1239.53650, -955.52209, 1073.49060,   0.00000, 0.00000, 0.00000);
CreateObject(19802, 1245.13440, -958.68323, 1073.07019,   0.00000, 0.00000, 90.00000);
CreateObject(19379, 1240.79517, -957.33228, 1076.56335,   0.00000, 90.00000, 0.00000);
CreateObject(2323, 1241.73572, -960.00244, 1073.07092,   0.00000, 0.00000, 0.00000);
CreateObject(19787, 1242.23157, -958.84778, 1074.69995,   0.00000, 0.00000, 180.00000);


//CreateObject(2196, 1244.59595, -958.44623,  1075.00000,   0.00000, 0.00000, 250.00000);

CreateObject(19379, 1240.79517, -957.33234, 1062.98340,   0.00000, 90.00000, 0.00000);
CreateObject(19360, 1245.20068, -954.44354, 1064.80005,   0.00000, 0.00000, 0.00000);
CreateObject(19360, 1245.20068, -957.64478, 1064.80005,   0.00000, 0.00000, 0.00000);
CreateObject(19360, 1243.62024, -952.92035, 1064.80005,   0.00000, 0.00000, 90.00000);
CreateObject(19360, 1240.45996, -952.92029, 1064.80005,   0.00000, 0.00000, 90.00000);
CreateObject(19360, 1243.66016, -952.92029, 1064.80005,   0.00000, 0.00000, 90.00000);
CreateObject(19360, 1243.62024, -959.17999, 1064.80005,   0.00000, 0.00000, 90.00000);
CreateObject(19360, 1240.45996, -959.17999, 1064.80005,   0.00000, 0.00000, 90.00000);
CreateObject(19360, 1239.00000, -954.44348, 1064.80005,   0.00000, 0.00000, 0.00000);
CreateObject(19360, 1239.00000, -957.64478, 1064.80005,   0.00000, 0.00000, 0.00000);
CreateObject(19802, 1245.13440, -958.68323, 1063.07019,   0.00000, 0.00000, 90.00000);
CreateObject(2631, 1241.82312, -957.37988, 1063.07104,   0.00000, 0.00000, 0.00000);
CreateObject(19379, 1240.79517, -957.33228, 1066.56335,   0.00000, 90.00000, 0.00000);
CreateObject(1796, 1240.68335, -956.46674, 1063.12354,   0.00000, 0.00000, 0.00000);
CreateObject(1796, 1241.98328, -956.46667, 1063.12354,   0.00000, 0.00000, 0.00000);
CreateObject(2830, 1243.42676, -953.68884, 1063.07117,   0.00000, 0.00000, 0.00000);
CreateObject(2830, 1242.33594, -955.05646, 1063.82166,   0.00000, 0.00000, 0.00000);

//CreateObject(2196, 1244.59595, -958.44623,  1065.00000,   0.00000, 0.00000, 250.00000);

CreateObject(19379, 1240.79517, -957.33234, 1052.98340,   0.00000, 90.00000, 0.00000);
CreateObject(19360, 1245.20068, -954.44354, 1054.80005,   0.00000, 0.00000, 0.00000);
CreateObject(19360, 1245.20068, -957.64478, 1054.80005,   0.00000, 0.00000, 0.00000);
CreateObject(19360, 1243.62024, -952.92035, 1054.80005,   0.00000, 0.00000, 90.00000);
CreateObject(19360, 1240.45996, -952.92029, 1054.80005,   0.00000, 0.00000, 90.00000);
CreateObject(19360, 1243.66016, -952.92029, 1054.80005,   0.00000, 0.00000, 90.00000);
CreateObject(19360, 1243.62024, -959.17999, 1054.80005,   0.00000, 0.00000, 90.00000);
CreateObject(19360, 1240.45996, -959.17999, 1054.80005,   0.00000, 0.00000, 90.00000);
CreateObject(19360, 1239.00000, -954.44348, 1054.80005,   0.00000, 0.00000, 0.00000);
CreateObject(19360, 1239.00000, -957.64478, 1054.80005,   0.00000, 0.00000, 0.00000);
CreateObject(2565, 1241.58582, -958.63397, 1053.49060,   0.00000, 0.00000, 90.00000);
CreateObject(19802, 1245.13440, -958.68323, 1053.07019,   0.00000, 0.00000, 90.00000);
CreateObject(2631, 1241.82312, -957.37988, 1053.07104,   0.00000, 0.00000, 0.00000);
CreateObject(19379, 1240.79517, -957.33228, 1056.56335,   0.00000, 90.00000, 0.00000);
CreateObject(2850, 1244.61230, -953.46667, 1053.07178,   0.00000, 0.00000, 0.00000);
//CreateObject(2196, 1244.59595, -958.44623,  1055.00000,   0.00000, 0.00000, 250.00000);

CreateObject(19379, 1240.79517, -957.33234, 1042.98340,   0.00000, 90.00000, 0.00000);
CreateObject(19360, 1245.20068, -954.44354, 1044.80005,   0.00000, 0.00000, 0.00000);
CreateObject(19360, 1245.20068, -957.64478, 1044.80005,   0.00000, 0.00000, 0.00000);
CreateObject(19360, 1243.62024, -952.92035, 1044.80005,   0.00000, 0.00000, 90.00000);
CreateObject(19360, 1240.45996, -952.92029, 1044.80005,   0.00000, 0.00000, 90.00000);
CreateObject(19360, 1243.66016, -952.92029, 1044.80005,   0.00000, 0.00000, 90.00000);
CreateObject(19360, 1243.62024, -959.17999, 1044.80005,   0.00000, 0.00000, 90.00000);
CreateObject(19360, 1240.45996, -959.17999, 1044.80005,   0.00000, 0.00000, 90.00000);
CreateObject(19360, 1239.00000, -954.44348, 1044.80005,   0.00000, 0.00000, 0.00000);
CreateObject(19360, 1239.00000, -957.64478, 1044.80005,   0.00000, 0.00000, 0.00000);
CreateObject(19802, 1245.13440, -958.68323, 1043.07019,   0.00000, 0.00000, 90.00000);
CreateObject(2631, 1241.82312, -957.37988, 1043.07104,   0.00000, 0.00000, 0.00000);
CreateObject(19379, 1240.79517, -957.33228, 1046.56335,   0.00000, 90.00000, 0.00000);
CreateObject(1795, 1239.63916, -956.61292, 1043.07080,   0.00000, 0.00000, 0.00000);
CreateObject(1757, 1242.56824, -955.57495, 1043.07056,   0.00000, 0.00000, 90.00000);
CreateObject(1786, 1244.99316, -954.41882, 1043.07056,   0.00000, 0.00000, 270.00000);
CreateObject(2829, 1240.85974, -953.64661, 1043.07043,   0.00000, 0.00000, 0.00000);
CreateObject(2829, 1244.69470, -953.36499, 1043.07031,   0.00000, 0.00000, 0.00000);
//CreateObject(2196, 1244.59595, -958.44623,  1045.00000,   0.00000, 0.00000, 250.00000);

}

//Helper functions
stock split(const strsrc[], strdest[][], delimiter)
{
	new i, li;
	new aNum;
	new len;
	while(i <= strlen(strsrc)){
	    if(strsrc[i]==delimiter || i==strlen(strsrc)){
	        len = strmid(strdest[aNum], strsrc, li, i, 128);
	        strdest[aNum][len] = 0;
	        li = i+1;
	        aNum++;
		}
		i++;
	}
	return 1;
}

//Todo Change this
stock createHotel()
{
	//for some reason this gives a ak lul check if needs fix?
    AddStaticPickup(1273, 1, -1438.0657, -281.0099, 14); //Hotel Label
    Create3DTextLabel("Flughafen Hotel /rentroom um eine Suite zu buchen!", COLOR_YELLOW, -1438.0657, -281.0099, 14.5,9.0,0); // Hotel
    
	//todo put this in file or database
    niceRooms[0][roomX] = 1254.92603; niceRooms[0][roomY] = -957.71057; niceRooms[0][roomZ] = 1084.06; niceRooms[0][roomInterior] = 0;
    niceRooms[0][roomPrice] = 500; niceRooms[0][roomType] = 1;
    
    niceRooms[1][roomX] = 1254.92603; niceRooms[1][roomY] = -957.71057; niceRooms[1][roomZ] = 1074.06; niceRooms[1][roomInterior] = 1;
    niceRooms[1][roomPrice] = 500; niceRooms[1][roomType] = 1;
    
    niceRooms[2][roomX] = 1254.92603; niceRooms[2][roomY] = -957.71057; niceRooms[2][roomZ] = 1064.06; niceRooms[2][roomInterior] = 2;
    niceRooms[2][roomPrice] = 500; niceRooms[2][roomType] = 1;
    
    niceRooms[3][roomX] = 1254.92603; niceRooms[3][roomY] = -957.71057; niceRooms[3][roomZ] = 1054.06; niceRooms[3][roomInterior] = 3;
    niceRooms[3][roomPrice] = 500; niceRooms[3][roomType] = 1;
    
    niceRooms[4][roomX] = 1254.92603; niceRooms[4][roomY] = -957.71057; niceRooms[4][roomZ] = 1044.06; niceRooms[4][roomInterior] = 4;
    niceRooms[4][roomPrice] = 500; niceRooms[4][roomType] = 1;
    
    shitRooms[0][roomX] = 1244.021972; shitRooms[0][roomY] = -957.933105; shitRooms[0][roomZ] = 1084.06; shitRooms[0][roomInterior] = 5;
    shitRooms[0][roomPrice] = 500; shitRooms[0][roomType] = 0;
    
    shitRooms[1][roomX] = 1244.021972; shitRooms[1][roomY] = -957.933105; shitRooms[1][roomZ] = 1074.06; shitRooms[1][roomInterior] = 6;
    shitRooms[1][roomPrice] = 500; shitRooms[1][roomType] = 0;
    
    shitRooms[2][roomX] = 1244.021972; shitRooms[2][roomY] = -957.933105; shitRooms[2][roomZ] = 1064.06; shitRooms[2][roomInterior] = 7;
    shitRooms[2][roomPrice] = 500; shitRooms[2][roomType] = 0;
    
    shitRooms[3][roomX] = 1244.021972; shitRooms[3][roomY] = -957.933105; shitRooms[3][roomZ] = 1054.06; shitRooms[3][roomInterior] = 8;
    shitRooms[3][roomPrice] = 500; shitRooms[3][roomType] = 0;
    
    shitRooms[4][roomX] = 1244.021972; shitRooms[4][roomY] =-957.933105; shitRooms[4][roomZ] = 1044.06; shitRooms[4][roomInterior] = 9;
    shitRooms[4][roomPrice] = 500; shitRooms[4][roomType] = 0;
    
    //1244.59595;-958.44623
}

//Gets an unused Suite ID
stock getFreeSuiteId()
{
	for(new i=0;i<MAX_HOTEL_SUITES;i++)
	{
		if(HotelSuiteInfos[i][suiteRented] == 0){
			return i;
		}
	}
	return MAX_HOTEL_SUITES;
}

//Gets a random room by type
stock getRoomByInterior(t)
{
	return random(t);
}

//Gets suiteId of player. or returns 0 if he does not have one
stock getSuiteId(playerid){
	new payerName[MAX_PLAYER_NAME + 1];
    GetPlayerName(playerid, payerName, sizeof(payerName));
   	for(new i=0;i<MAX_HOTEL_SUITES;i++)
	{
	    if(HotelSuiteInfos[i][suiteRented] == 1){
	        if(!isnull(HotelSuiteInfos[i][suiteOwner])){
				if(strcmp(HotelSuiteInfos[i][suiteOwner], payerName, true) == 0){
					return HotelSuiteInfos[i][suiteId];
				}
	        }
	    }
	}
	return MAX_HOTEL_SUITES;
}

stock teleport(playerid, Float:x, Float:y, Float:z, interior, virtualworld){
	SetPlayerPos(playerid, x, y, z);
	SetPlayerInterior(playerid, interior);
	SetPlayerVirtualWorld(playerid, virtualworld);
	return 1;
}

//Public functions
//todo add mysql
public loadHotelSuites(){
	new arrCoords[11][64];
	new strFromFile2[256];
	new File: file = fopen("hotelSuites.cfg", io_read);
	if (file)
	{
		new idx;
		while (idx < sizeof(HotelSuiteInfos))
		{
			fread(file, strFromFile2);
			split(strFromFile2, arrCoords, ',');
            HotelSuiteInfos[idx][suiteId] = strval(arrCoords[0]);
            HotelSuiteInfos[idx][suiteRented] = strval(arrCoords[1]);
            HotelSuiteInfos[idx][suitePrice] = strval(arrCoords[2]);
            HotelSuiteInfos[idx][suiteEnterX] = floatstr(arrCoords[3]);
            HotelSuiteInfos[idx][suiteEnterY] = floatstr(arrCoords[4]);
            HotelSuiteInfos[idx][suiteEnterZ] = floatstr(arrCoords[5]);
            HotelSuiteInfos[idx][suiteX] = floatstr(arrCoords[6]);
            HotelSuiteInfos[idx][suiteY] = floatstr(arrCoords[7]);
            HotelSuiteInfos[idx][suiteZ] = floatstr(arrCoords[8]);
            HotelSuiteInfos[idx][suiteInterior] = strval(arrCoords[9]);
			strcat(HotelSuiteInfos[idx][suiteOwner], arrCoords[10], MAX_PLAYER_NAME + 1);
			idx++;
		}
		fclose(file);
	}
	return 1;
}

//todo add mysql
public saveHotelSuites(){
	new idx;
	new File: hotelFile;
	while (idx < sizeof(HotelSuiteInfos))
	{
		new coordsstring[256];
		format(coordsstring, sizeof(coordsstring), "%d,%d,%d,%f,%f,%f,%f,%f,%f,%d,%s,\n", //todo evt am ende noch ein komma adden, mal schauen..
		
        HotelSuiteInfos[idx][suiteId],
        HotelSuiteInfos[idx][suiteRented],
        HotelSuiteInfos[idx][suitePrice],

        HotelSuiteInfos[idx][suiteEnterX],
        HotelSuiteInfos[idx][suiteEnterY],
        HotelSuiteInfos[idx][suiteEnterZ],

        HotelSuiteInfos[idx][suiteX],
        HotelSuiteInfos[idx][suiteY],
        HotelSuiteInfos[idx][suiteZ],

        HotelSuiteInfos[idx][suiteInterior],
        HotelSuiteInfos[idx][suiteOwner]
		);

		if(idx == 0)
		{
			hotelFile = fopen("hotelSuites.cfg", io_write);
		}
		else
		{
			hotelFile = fopen("hotelSuites.cfg", io_append);
		}
		fwrite(hotelFile, coordsstring);
		idx++;
		fclose(hotelFile);
	}
	return 1;

}

//todo add mysql
public addHotelSuite(playerid, sId, suiteType)
{
    totalSuites++;
    new temp = getRoomByInterior(5);
    HotelSuiteInfos[sId][suiteId] = sId;
    HotelSuiteInfos[sId][suiteRented] = 1;
    
    if(suiteType == 1)
	{
	    HotelSuiteInfos[sId][suitePrice] = niceRooms[temp][roomPrice];
	    HotelSuiteInfos[sId][suiteX] = niceRooms[temp][roomX];
	    HotelSuiteInfos[sId][suiteY] = niceRooms[temp][roomY];
	    HotelSuiteInfos[sId][suiteZ] = niceRooms[temp][roomZ];
	    HotelSuiteInfos[sId][suiteInterior] = niceRooms[temp][roomInterior];
    }
	else if(suiteType == 0)
	{
	    HotelSuiteInfos[sId][suitePrice] = shitRooms[temp][roomPrice];
	    HotelSuiteInfos[sId][suiteX] = shitRooms[temp][roomX];
	    HotelSuiteInfos[sId][suiteY] = shitRooms[temp][roomY];
	    HotelSuiteInfos[sId][suiteZ] = shitRooms[temp][roomZ];
	    HotelSuiteInfos[sId][suiteInterior] = shitRooms[temp][roomInterior];
    }
    
    //todo change this to be variable of hotel
	HotelSuiteInfos[sId][suiteEnterX] = -1438.0657;
    HotelSuiteInfos[sId][suiteEnterY] = -281.0099;
    HotelSuiteInfos[sId][suiteEnterZ] = 14;

    
	new payerName[MAX_PLAYER_NAME + 1];
    GetPlayerName(playerid, payerName, sizeof(payerName));
    HotelSuiteInfos[sId][suiteOwner] = payerName;
	return 1;
}

//todo add mysql
public removeHotelSuite(playerid, sId){
    totalSuites--;
    HotelSuiteInfos[sId][suiteId] = 0;
    HotelSuiteInfos[sId][suiteRented] = 0;

    HotelSuiteInfos[sId][suitePrice] = 0;


    HotelSuiteInfos[sId][suiteX] = 0;
    HotelSuiteInfos[sId][suiteY] = 0;
    HotelSuiteInfos[sId][suiteZ] = 0;
    HotelSuiteInfos[sId][suiteInterior] = 0;

	HotelSuiteInfos[sId][suiteEnterX] = 0;
    HotelSuiteInfos[sId][suiteEnterY] = 0;
    HotelSuiteInfos[sId][suiteEnterZ] = 0;

	//toto is there no better way?
	new nullString[MAX_PLAYER_NAME + 1] = "";
    HotelSuiteInfos[sId][suiteOwner] = nullString;
	return 1;
}

//Commands

CMD:rentroom(playerid, params[])
{
    if(IsPlayerConnected(playerid))
    {
	    if(IsPlayerInRangeOfPoint(playerid,5.0,-1438.0657, -281.0099, 14))
		{
			if(getSuiteId(playerid) == MAX_HOTEL_SUITES)
			{
			    if(getFreeSuiteId() != MAX_HOTEL_SUITES)
				{
					ShowPlayerDialog(playerid, DIALOG_RENTROOM, DIALOG_STYLE_LIST, "{FFFFFF}Hotel Checkin", "Schmutz Zimmer\nMittleres Zimmer\nHigh End Zimmer", "Auswählen", "Abbrechen");
			    }
				else
				{
			        SendClientMessage(playerid, COLOR_RED, "Das Hotel ist leider ausgebucht.");
					return 1;
			    }
			}
   			else
   			{
   			    SendClientMessage(playerid, COLOR_RED, "Du besitzt bereits eine Suite hier, verwende /SuiteEnter um sie zu betreten.");
   			    return 1;
   			}
	    }
	}
	return 1;
}

CMD:unrentroom(playerid, params[])
{
    if(IsPlayerConnected(playerid))
    {
	    if(IsPlayerInRangeOfPoint(playerid,5.0,-1438.0657, -281.0099, 14))
		{
		    new unrentSuiteId = getSuiteId(playerid);
	        if(unrentSuiteId != MAX_HOTEL_SUITES)
			{
				SendClientMessage(playerid, COLOR_GREEN, "Schade dass Sie uns verlassen, auf wiedersehen.");
				//GivePlayerMoney(playerid, (hotelPrice * -1 *0.5)); //todo use correct price -> * -1 *0.5 macht den preis positiv und halbiert ihn
				removeHotelSuite(playerid, unrentSuiteId);
				saveHotelSuites();
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, "Du besitzt keine Suite hier.");
				return 1;
			}
	    }
	}
	return 1;
}


CMD:enterroom(playerid, params[])
{
    if(IsPlayerConnected(playerid))
    {
	    if(IsPlayerInRangeOfPoint(playerid,5.0,-1438.0657, -281.0099, 14))
		{
		    new enterRoomSuiteId = getSuiteId(playerid);
		    if(enterRoomSuiteId == MAX_HOTEL_SUITES)
			{
				SendClientMessage(playerid, COLOR_RED, "Du hast hier keine Suite, verwende /rentroom.");
				return 1;
		    }
			else
			{
		        SendClientMessage(playerid, COLOR_GREEN, "Willkommen in deiner Suite.");
                teleport(playerid, HotelSuiteInfos[enterRoomSuiteId][suiteX], HotelSuiteInfos[enterRoomSuiteId][suiteY],HotelSuiteInfos[enterRoomSuiteId][suiteZ], HotelSuiteInfos[enterRoomSuiteId][suiteInterior], playerid); //todo change virtual world away from player id? idk
		    }
    	}
		else
		{
		 	SendClientMessage(playerid, COLOR_RED, "Du bist nicht am Hoteleingang.");
			return 1;
		}
	}
	return 1;
}

CMD:exitroom(playerid, params[])
{
    if(IsPlayerConnected(playerid))
    {
    	new exitSuiteId = getSuiteId(playerid);
	    if(IsPlayerInRangeOfPoint(playerid,9.0,HotelSuiteInfos[exitSuiteId][suiteX], HotelSuiteInfos[exitSuiteId][suiteY],HotelSuiteInfos[exitSuiteId][suiteZ]))
		{
		    if(exitSuiteId != MAX_HOTEL_SUITES)
			{
		        SendClientMessage(playerid, COLOR_GREEN, "Auf wiedersehen.");
                teleport(playerid, HotelSuiteInfos[exitSuiteId][suiteEnterX], HotelSuiteInfos[exitSuiteId][suiteEnterY],HotelSuiteInfos[exitSuiteId][suiteEnterZ], 0, 0);
		    }
			else
			{
		        SendClientMessage(playerid, COLOR_RED, "Du hast hier keine Suite, verwende /rentroom.");
				return 1;
		    }
		}
		else
		{
		 	SendClientMessage(playerid, COLOR_RED, "Du bist nicht am Hotelausgang.");
			return 1;
		}
	}
	return 1;
}

//todo remove
CMD:showpos(playerid, params[])
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	new debugstring[256];
	format(debugstring, sizeof(debugstring), "X: %f Y: %f Z: %f \n",
	x,y,z
	);
	SendClientMessage(playerid, COLOR_RED, debugstring);
	return 1;
}

CMD:showrenters(playerid, params[])
{
	new string[1024];
   	for(new i=0;i<MAX_HOTEL_SUITES;i++)
	{
	    if(HotelSuiteInfos[i][suiteRented] == 1)
		{
	        if(!isnull(HotelSuiteInfos[i][suiteOwner]))
			{
				new teststring[256];
				format(teststring, sizeof(teststring), "SuiteId: %d, By: %s, Interior: %d X: %f, Y: %f, Z: %f \n",

		        HotelSuiteInfos[i][suiteId],
				HotelSuiteInfos[i][suiteOwner],
		        HotelSuiteInfos[i][suiteInterior],
		        HotelSuiteInfos[i][suiteX],
		        HotelSuiteInfos[i][suiteY],
		        HotelSuiteInfos[i][suiteZ]
		        
				);
				strcat(string, teststring);
	        }
	    }
	}
	ShowPlayerDialog(playerid, DIALOG_HOTEL_MIETER, DIALOG_STYLE_LIST, "Hotel Mieter", string, "Auswählen", "Zurück");
	return 1;
}

//------------------------------------------------------------------------------

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_RENTROOM)
	{
	    if(response)
	    {
	        if(listitem == 0)
	        {
		        if(GetPlayerMoney(playerid) >= 500)
				{
					SendClientMessage(playerid, COLOR_GREEN, "Suite gemieted.");
					GivePlayerMoney(playerid, 500); //fix hardcoding
					addHotelSuite(playerid, getFreeSuiteId(), 0);
					saveHotelSuites();
		        }
				else
				{
			        SendClientMessage(playerid, COLOR_RED, "Du kannst dir diese Suite nicht leisten.");
					return 1;
		        }
	        }
	        if(listitem == 1)
			{
		        if(GetPlayerMoney(playerid) >= 1000)
				{
					SendClientMessage(playerid, COLOR_GREEN, "Suite gemieted.");
					GivePlayerMoney(playerid, 1000); //fix hardcoding
					addHotelSuite(playerid, getFreeSuiteId(), 1);
					saveHotelSuites();
		        }
				else
				{
			        SendClientMessage(playerid, COLOR_RED, "Du kannst dir diese Suite nicht leisten.");
					return 1;
		        }
			}
			if(listitem == 2)
			{
				SendClientMessage(playerid, COLOR_GREEN, "High end zimmer: Du verwöhnter hurensohn");
			}
		}
	}
	
	return 1;
}

//------------------------------------------------------------------------------

public OnFilterScriptInit()
{
	print("\nSadfiesch's Hotel Script loading biatch.");
	createRooms();
	createHotel();
	loadHotelSuites();
	print("\nSadfiesch's Hotel Script done loading biatch.");
	return 1;
}

//------------------------------------------------------------------------------

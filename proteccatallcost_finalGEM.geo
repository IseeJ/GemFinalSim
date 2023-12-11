// Gmsh project created on Sun Dec 10 22:49:49 2023
SetFactory("OpenCASCADE");


r0 = 0.0035;     // the hole radius
tC = 0.0005;     // copper thickness
tD = 0.005;     // dielectric thickness
lE = 5.2;     // distance from GEM plates to upper exterior electrode
lP = 0.02;     // distance from lower GEM plate to pad (readout) plane
a = 0.014;     // the "pitch", or distance between GEM holes
b = 0.001; //how far in the hourglass narrow part 

//Characteristic lengths
lcDielectricHole = 0.0025;
lcEtchingHole = 0.0025;
lcCopperPlateBdry = 0.005;
lcExtElectrodeBdry = 0.03;
lcGEMHole = 0.005;



// ------------------------------------------------------------
// Hole 1 (quarter hole)
// ------------------------------------------------------------

// *******************************
// Center
// *******************************
pc1_1 = newp; Point(pc1_1) = {0, 0, tD/2,lcGEMHole};
pc2_1 = newp; Point(pc2_1) = {0, 0, -1*tD/2,lcGEMHole};
pc3_1 = newp; Point(pc3_1) = {0, 0, (2*tC+tD)/2,lcGEMHole};
pc4_1 = newp; Point(pc4_1) = {0, 0, -1*(2*tC+tD)/2,lcGEMHole};
pc5_1 = newp; Point(pc5_1) = {0, 0, 0,lcGEMHole};


// *******************************
// Dielectric hole
// *******************************
// Top
pth1_1 = newp; Point(pth1_1) = {r0, 0, tD/2,lcDielectricHole};
pth2_1 = newp; Point(pth2_1) = {0, r0, tD/2,lcDielectricHole};

// Bottom
pbh1_1 = newp; Point(pbh1_1) = {r0, 0, -1*tD/2,lcDielectricHole};
pbh2_1 = newp; Point(pbh2_1) = {0, r0, -1*tD/2,lcDielectricHole};

// Middle for hourglass GEM
pme1_1 = newp; Point(pme1_1) = {r0-b, 0, 0,lcEtchingHole};
pme2_1 = newp; Point(pme2_1) = {0, r0-b, 0,lcEtchingHole};

Circle(1) = {6, 1, 7};
Circle(2) = {10, 5, 11};
Circle(3) = {8, 2, 9};
Line(4) = {6, 10};
Line(5) = {10, 8};
Line(6) = {7, 11};
Line(7) = {11, 9};


// ------------------------------------------------------------
// Hole 2 (half hole)
// ------------------------------------------------------------

// *******************************
// Center
// *******************************
// pt20-23
pc1_2 = newp; Point(pc1_2) = {a/2, a*Sqrt(3)/2, tD/2,lcGEMHole};
pc2_2 = newp; Point(pc2_2) = {a/2, a*Sqrt(3)/2, -1*tD/2,lcGEMHole};
pc3_2 = newp; Point(pc3_2) = {a/2, a*Sqrt(3)/2, (2*tC+tD)/2,lcGEMHole};
pc4_2 = newp; Point(pc4_2) = {a/2, a*Sqrt(3)/2, -1*(2*tC+tD)/2,lcGEMHole};
pc5_2 = newp; Point(pc5_2) = {a/2, a*Sqrt(3)/2, 0,lcGEMHole};

// *******************************
// Dielectric hole
// *******************************
// Top
pth1_2 = newp; Point(pth1_2) = {a/2-1*r0, a*Sqrt(3)/2, tD/2,lcDielectricHole};
pth2_2 = newp; Point(pth2_2) = {a/2+r0, a*Sqrt(3)/2, tD/2,lcDielectricHole};
pth3_2 = newp; Point(pth3_2) = {a/2, a*Sqrt(3)/2-1*r0, tD/2,lcDielectricHole};


// Bottom
// pt 28-30
pbh1_2 = newp; Point(pbh1_2) = {a/2-1*r0, a*Sqrt(3)/2, -1*tD/2,lcDielectricHole};
pbh2_2 = newp; Point(pbh2_2) = {a/2+r0, a*Sqrt(3)/2, -1*tD/2,lcDielectricHole};
pbh3_2 = newp; Point(pbh3_2) = {a/2, a*Sqrt(3)/2-1*r0, -1*tD/2,lcDielectricHole};

// Middle for hourglass GEM
pme2_1 = newp; Point(pme2_1) = {a/2+r0-b, a*Sqrt(3)/2, 0,lcDielectricHole};
pme2_2 = newp; Point(pme2_2) = {a/2-1*r0+b, a*Sqrt(3)/2,0,lcDielectricHole};
pme2_3 = newp; Point(pme2_3) = {a/2,(a*Sqrt(3)/2-1*(r0))+0.001,0,lcEtchingHole};


Circle(8) = {18, 12, 19};
Circle(9) = {17, 12, 19};
Circle(10) = {23, 16, 25};
Circle(11) = {24, 16, 25};
Circle(12) = {21, 13, 22};
Circle(13) = {20, 13, 22};
Line(14) = {18, 23};
Line(15) = {23, 21};
Line(16) = {17, 24};
Line(17) = {24, 20};


// ------------------------------------------------------------
// Hole 3 (quarter hole)
// ------------------------------------------------------------



// *******************************
// Center
// *******************************
pc1_3 = newp; Point(pc1_3) = {a, 0, tD/2,lcGEMHole};
pc2_3 = newp; Point(pc2_3) = {a, 0, -1*tD/2,lcGEMHole};
pc3_3 = newp; Point(pc3_3) = {a, 0, (2*tC+tD)/2,lcGEMHole};
pc4_3 = newp; Point(pc4_3) = {a, 0, -1*(2*tC+tD)/2,lcGEMHole};
pc5_3 = newp; Point(pc5_3) = {a, 0, 0,lcGEMHole};


// *******************************
// Dielectric hole
// *******************************
// Top
pth1_3 = newp; Point(pth1_3) = {a-r0, 0, tD/2,lcDielectricHole};
pth2_3 = newp; Point(pth2_3) = {a, r0, tD/2,lcDielectricHole};

// Bottom
pbh1_3 = newp; Point(pbh1_3) = {a-r0, 0, -1*tD/2,lcDielectricHole};
pbh2_3 = newp; Point(pbh2_3) = {a, r0, -1*tD/2,lcDielectricHole};

//*****
// Middle for hourglass GEM
pme3_1 = newp; Point(pme3_1) = {a, r0-b, 0,lcEtchingHole};
pme3_2 = newp; Point(pme3_2) = {a-r0+b, 0, 0,lcEtchingHole};

Circle(18) = {31, 26, 32};
Circle(19) = {36, 30, 35};
Circle(20) = {33, 27, 34};
Line(21) = {31, 36};
Line(22) = {36, 33};
Line(23) = {32, 35};
Line(24) = {35, 34};


// *******************************************************
// Copper planes
// *******************************************************

// Points between two half holes on upper LEM
ptmc = newp; Point(ptmc) = {a/2, 0, (2*tC+tD)/2, lcCopperPlateBdry};
ptmd = newp; Point(ptmd) = {a/2, 0, tD/2, lcCopperPlateBdry};


// Top lower boundary
pcptl1 = newp; Point(pcptl1) = {0, 0, tD/2,lcCopperPlateBdry};
pcptl2 = newp; Point(pcptl2) = {a, a*Sqrt(3)/2, tD/2,lcCopperPlateBdry};
pcptl3 = newp; Point(pcptl3) = {0, a*Sqrt(3)/2, tD/2,lcCopperPlateBdry};

// Top upper boundary
pcptu2 = newp; Point(pcptu2) = {a, a*Sqrt(3)/2, (tD+2*tC)/2,lcCopperPlateBdry};
pcptu3 = newp; Point(pcptu3) = {0, a*Sqrt(3)/2, (tD+2*tC)/2,lcCopperPlateBdry};

//Top
Line(25) = {6, 38};
Line(26) = {38, 31};
Line(27) = {32, 40};
Line(28) = {40, 18};
Line(29) = {17, 41};
Line(30) = {41, 7};


// Points between two half holes on lower LEM
pbmd = newp; Point(pbmd) = {a/2, 0, -1*tD/2, lcCopperPlateBdry};
pbmc = newp; Point(pbmc) = {a/2, 0, -1*(2*tC+tD)/2, lcCopperPlateBdry};

// Bottom lower boundary
pcpbl2 = newp; Point(pcpbl2) = {a, a*Sqrt(3)/2, -1*(tD+2*tC)/2,lcCopperPlateBdry};
pcpbl3 = newp; Point(pcpbl3) = {0, a*Sqrt(3)/2, -1*(tD+2*tC)/2,lcCopperPlateBdry};

// Bottom upper boundary
pcpbu2 = newp; Point(pcpbu2) = {a, a*Sqrt(3)/2, -1*tD/2,lcCopperPlateBdry};
pcpbu3 = newp; Point(pcpbu3) = {0, a*Sqrt(3)/2, -1*tD/2,lcCopperPlateBdry};


//Bottom
Line(31) = {34, 48};
Line(32) = {48, 21};
Line(33) = {20, 49};
Line(34) = {49, 9};
Line(35) = {8, 44};



//TOP COPPER
Point(50) = {r0, 0, tD/2+tC,lcDielectricHole};
Point(51) = {a-r0, 0, tD/2+tC,lcDielectricHole};
Point(52) = {a, r0, tD/2+tC,lcDielectricHole};
Point(53) = {a/2+r0, a*Sqrt(3)/2, tD/2+tC,lcDielectricHole};
Point(54) = {a/2, a*Sqrt(3)/2-1*r0, tD/2+tC,lcDielectricHole};
Point(55) = {a/2-1*r0, a*Sqrt(3)/2, tD/2+tC,lcDielectricHole};
Point(56) = {0, r0, tD/2+tC,lcDielectricHole};
Circle(36) = {50, 3, 56};
Circle(37) = {51, 28, 52};
Circle(38) = {53, 14, 54};
Circle(39) = {55, 14, 54};
Line(40) = {56, 7};
Line(41) = {50, 6};
Line(42) = {31, 51};
Line(43) = {32, 52};
Line(44) = {40, 42};
Line(45) = {18, 53};
Line(46) = {17, 55};
Line(47) = {41, 43};
Line(48) = {50, 37};
Line(49) = {52, 42};
Line(50) = {42, 53};
Line(51) = {55, 43};
Line(52) = {43, 56};


//BOTTOM COPPER
Point(57) = {a, r0, -1*tD/2-tC,lcDielectricHole};
Point(58) = {a-r0, 0, -1*tD/2-tC,lcDielectricHole};
Point(59) = {r0, 0, -1*tD/2-tC,lcDielectricHole};
Point(60) = {0, r0, -1*tD/2-tC,lcDielectricHole};
Point(61) = {a/2-1*r0, a*Sqrt(3)/2, -1*tD/2-tC,lcDielectricHole};
Point(62) = {a/2, a*Sqrt(3)/2-1*r0, -1*tD/2-tC,lcDielectricHole};
Point(63) = {a/2+r0, a*Sqrt(3)/2, -1*tD/2-tC,lcDielectricHole};
Circle(53) = {60, 4, 59};
Circle(54) = {58, 29, 57};
Circle(55) = {61, 15, 62};
Circle(56) = {63, 15, 62};
Line(57) = {61, 47};
Line(58) = {47, 60};
Line(59) = {59, 45};
Line(60) = {45, 58};
Line(61) = {57, 46};
Line(62) = {46, 63};
Line(63) = {47, 49};
Line(64) = {61, 20};
Line(65) = {63, 21};
Line(66) = {46, 48};
Line(67) = {57, 34};
Line(68) = {58, 33};
Line(69) = {59, 8};
Line(70) = {60, 9};
Line(71) = {62, 22};
Line(72) = {19, 54};
Line(73) = {49, 41};
Line(74) = {22, 25};
Line(75) = {25, 19};
Line(76) = {48, 40};

//*
Recursive Delete {
  Point{1}; 
}


// **********************************************
// External Electrodes
// **********************************************

// Top electrode
pexet1 = newp; Point(pexet1) = {a, a*Sqrt(3)/2, (tD+2*tC)/2+lE,lcExtElectrodeBdry};
pexet2 = newp; Point(pexet2) = {a/2, a*Sqrt(3)/2, (tD+2*tC)/2+lE,lcExtElectrodeBdry};
pexet3 = newp; Point(pexet3) = {0, a*Sqrt(3)/2, (tD+2*tC)/2+lE,lcExtElectrodeBdry};
pexet4 = newp; Point(pexet4) = {0, 0, (tD+2*tC)/2+lE,lcExtElectrodeBdry};
pexet5 = newp; Point(pexet5) = {a/2, 0, (tD+2*tC)/2+lE,lcExtElectrodeBdry};
pexet6 = newp; Point(pexet6) = {a, 0, (tD+2*tC)/2+lE,lcExtElectrodeBdry};

// Top electrode lines
lexet1 = newc; Line(lexet1) = {pexet1, pexet2};
lexet2 = newc; Line(lexet2) = {pexet2, pexet3};
lexet3 = newc; Line(lexet3) = {pexet3, pexet4};
lexet4 = newc; Line(lexet4) = {pexet4, pexet5};
lexet5 = newc; Line(lexet5) = {pexet5, pexet6};
lexet6 = newc; Line(lexet6) = {pexet6, pexet1};

// Connect the top electrode to the LEM.
lexetc1 = newc; Line(lexetc1) = {pexet1, pcptu2};
lexetc2 = newc; Line(lexetc2) = {pexet2, pc3_2};
lexetc3 = newc; Line(lexetc3) = {pexet3, pcptu3};
lexetc4 = newc; Line(lexetc4) = {pexet4, pc3_1};
lexetc5 = newc; Line(lexetc5) = {pexet5, ptmc};
lexetc6 = newc; Line(lexetc6) = {pexet6, pc3_3};

// Bottom electrode
pexeb1 = newp; Point(pexeb1) = {a, a*Sqrt(3)/2, -1*(tD+2*tC)/2-lP,lcExtElectrodeBdry};
pexeb2 = newp; Point(pexeb2) = {a/2, a*Sqrt(3)/2, -1*(tD+2*tC)/2-lP,lcExtElectrodeBdry};
pexeb3 = newp; Point(pexeb3) = {0, a*Sqrt(3)/2, -1*(tD+2*tC)/2-lP,lcExtElectrodeBdry};
pexeb4 = newp; Point(pexeb4) = {0, 0, -1*(tD+2*tC)/2-lP,lcExtElectrodeBdry};
pexeb5 = newp; Point(pexeb5) = {a/2, 0, -1*(tD+2*tC)/2-lP,lcExtElectrodeBdry};
pexeb6 = newp; Point(pexeb6) = {a, 0, -1*(tD+2*tC)/2-lP,lcExtElectrodeBdry};

// Bottom electrode lines
lexeb1 = newc; Line(lexeb1) = {pexeb1, pexeb2};
lexeb2 = newc; Line(lexeb2) = {pexeb2, pexeb3};
lexeb3 = newc; Line(lexeb3) = {pexeb3, pexeb4};
lexeb4 = newc; Line(lexeb4) = {pexeb4, pexeb5};
lexeb5 = newc; Line(lexeb5) = {pexeb5, pexeb6};
lexeb6 = newc; Line(lexeb6) = {pexeb6, pexeb1};

// Connect the bottom electrode to the LEM.
lexebc1 = newc; Line(lexebc1) = {pexeb1, pcpbl2};
lexebc2 = newc; Line(lexebc2) = {pexeb2, pc4_2};
lexebc3 = newc; Line(lexebc3) = {pexeb3, pcpbl3};
lexebc4 = newc; Line(lexebc4) = {pexeb4, pc4_1};
lexebc5 = newc; Line(lexebc5) = {pexeb5, pbmc};
lexebc6 = newc; Line(lexebc6) = {pexeb6, pc4_3};


Line(101) = {15, 13};
Line(102) = {13, 16};
Line(103) = {16, 12};
Line(104) = {12, 14};
Line(105) = {29, 27};
Line(106) = {27, 30};
Line(107) = {30, 26};
Line(108) = {26, 28};
Line(109) = {4, 2};
Line(110) = {2, 5};
Line(111) = {5, 39};
Line(112) = {39, 3};

Line(113) = {9, 2};
Line(114) = {8, 2};
Line(115) = {33, 27};
Line(116) = {34, 27};
Line(117) = {31, 26};
Line(118) = {32, 26};
Line(119) = {18, 12};
Line(120) = {12, 17};
Line(122) = {21, 13};
Line(123) = {13, 20};
Line(124) = {7, 39};
Line(125) = {39, 6};

Line(126) = {37, 51};
Line(127) = {37, 38};
Line(128) = {38, 44};
Line(129) = {44, 45};

Line(130) = {44, 33};


// *************************************************
// Define surfaces
// *************************************************


//Upper Copper
llcp_up_rim1_2 = newreg; Line Loop(llcp_up_rim1_2) = {45,38,72,8};
rscp_up_rim1_2 = newreg; Surface(rscp_up_rim1_2) = {llcp_up_rim1_2};
llcp_up_rim2_2 = newreg; Line Loop(llcp_up_rim2_2) = {72,9,46,39};
rscp_up_rim2_2 = newreg; Surface(rscp_up_rim2_2) = {llcp_up_rim2_2};

llcp_up_rim_1 = newreg; Line Loop(llcp_up_rim_1) = {40,36,41,1};
rscp_up_rim_1 = newreg; Surface(rscp_up_rim_1) = {llcp_up_rim_1};
llcp_up_rim_3 = newreg; Line Loop(llcp_up_rim_3) = {43,37,42,18};
rscp_up_rim_3 = newreg; Surface(rscp_up_rim_3) = {llcp_up_rim_3};

llcp_up_border1 = newreg; Line Loop(llcp_up_border1) = {43,27,44,49};
pscp_up_border1 = newreg; Plane Surface(pscp_up_border1) = {llcp_up_border1};
llcp_up_border2 = newreg; Line Loop(llcp_up_border2) = {40,30,47,52};
pscp_up_border2 = newreg; Plane Surface(pscp_up_border2) = {llcp_up_border2};
llcp_up_border3 = newreg; Line Loop(llcp_up_border3) = {46,51,47,29};
pscp_up_border3 = newreg; Plane Surface(pscp_up_border3) = {llcp_up_border3};
llcp_up_border4a = newreg; Line Loop(llcp_up_border4a) = {41,48,127,25};
pscp_up_border4a = newreg; Plane Surface(pscp_up_border4a) = {llcp_up_border4a};
llcp_up_border4b = newreg; Line Loop(llcp_up_border4b) = {127,126,42,26};
pscp_up_border4b = newreg; Plane Surface(pscp_up_border4b) = {llcp_up_border4b};
llcp_up_border5 = newreg; Line Loop(llcp_up_border5) = {44,50,45,28};
pscp_up_border5 = newreg; Plane Surface(pscp_up_border5) = {llcp_up_border5};

llcp_face1 = newreg; Line Loop(llcp_face1) = {51,39,38,50,49,37,126,48,36,52};
pscp_face1 = newreg; Plane Surface(pscp_face1) = {llcp_face1};

//Lower Copper
llcp_low_rim1_2 = newreg; Line Loop(llcp_low_rim1_2) = {65,12,71,56};
rscp_low_rim1_2 = newreg; Surface(rscp_low_rim1_2) = {llcp_low_rim1_2};
llcp_low_rim2_2 = newreg; Line Loop(llcp_low_rim2_2) = {71,13,64,55};
rscp_low_rim2_2 = newreg; Surface(rscp_low_rim2_2) = {llcp_low_rim2_2};

llcp_low_rim_1 = newreg; Line Loop(llcp_low_rim_1) = {70,53,69,3};
rscp_low_rim_1 = newreg; Surface(rscp_low_rim_1) = {llcp_low_rim_1};
llcp_low_rim_3 = newreg; Line Loop(llcp_low_rim_3) = {67,54,68,20};
rscp_low_rim_3 = newreg; Surface(rscp_low_rim_3) = {llcp_low_rim_3};

llcp_low_border1 = newreg; Line Loop(llcp_low_border1) = {67,61,66,31};
pscp_low_border1 = newreg; Plane Surface(pscp_low_border1) = {llcp_low_border1};
llcp_low_border2 = newreg; Line Loop(llcp_low_border2) = {70,58,63,34};
pscp_low_border2 = newreg; Plane Surface(pscp_low_border2) = {llcp_low_border2};
llcp_low_border3 = newreg; Line Loop(llcp_low_border3) = {64,57,63,33};
pscp_low_border3 = newreg; Plane Surface(pscp_low_border3) = {llcp_low_border3};
llcp_low_border4a = newreg; Line Loop(llcp_low_border4a) = {69,59,129,35};
pscp_low_border4a = newreg; Plane Surface(pscp_low_border4a) = {llcp_low_border4a};
llcp_low_border4b = newreg; Line Loop(llcp_low_border4b) = {129,130,68,60};
pscp_low_border4b = newreg; Plane Surface(pscp_low_border4b) = {llcp_low_border4b};
llcp_low_border5 = newreg; Line Loop(llcp_low_border5) = {66,62,65,32};
pscp_low_border5 = newreg; Plane Surface(pscp_low_border5) = {llcp_low_border5};

llcp_face2 = newreg; Line Loop(llcp_face2) = {57,55,56,62,61,54,60,59,53,58};
pscp_face2 = newreg; Plane Surface(pscp_face2) = {llcp_face2};


ll_top_dielectric = newreg; Line Loop(ll_top_dielectric) = {29,9,8,28,27,18,26,25,1,30};
ps_top_dielectric = newreg; Plane Surface(ps_top_dielectric) = {ll_top_dielectric};
ll_bottom_dielectric = newreg; Line Loop(ll_bottom_dielectric) = {32, 12, -13, 33, 34, -3, 35, 130, 20, 31};
ps_bottom_dielectric = newreg; Plane Surface(ps_bottom_dielectric) = {ll_bottom_dielectric};

// Volumes

sl_upper_cp = newreg; Surface Loop(sl_upper_cp) = {pscp_face1, rscp_up_rim_1, rscp_up_rim_3, rscp_up_rim2_2, rscp_up_rim1_2, ps_top_dielectric, pscp_up_border4a, pscp_up_border4b, pscp_up_border3, pscp_up_border2, pscp_up_border5, pscp_up_border1};
vol_upper_cp = newreg; Volume(vol_upper_cp) = {sl_upper_cp};

sl_lower_cp = newreg; Surface Loop(sl_lower_cp) = {pscp_face2, ps_bottom_dielectric, rscp_low_rim_1, rscp_low_rim_3, rscp_low_rim2_2, rscp_low_rim1_2, pscp_low_border3, pscp_low_border2, pscp_low_border4a, pscp_low_border4b, pscp_low_border1, pscp_low_border5};
vol_lower_cp = newreg; Volume(vol_lower_cp) = {sl_lower_cp};
physvol_upper_cp = newreg; Physical Volume(physvol_upper_cp) = {vol_upper_cp};
physvol_lower_cp = newreg; Physical Volume(physvol_lower_cp) = {vol_lower_cp};




// Physical surfaces

// Surfaces to which voltages will be applied
physsurf_upper_cp = newreg; Physical Surface(physsurf_upper_cp) = {pscp_face1, rscp_up_rim_1, rscp_up_rim_3, rscp_up_rim2_2, rscp_up_rim1_2, ps_top_dielectric, pscp_up_border4a, pscp_up_border4b, pscp_up_border3, pscp_up_border2, pscp_up_border5, pscp_up_border1};
physsurf_lower_cp = newreg; Physical Surface(physsurf_lower_cp) = {pscp_face2, ps_bottom_dielectric, rscp_low_rim_1, rscp_low_rim_3, rscp_low_rim2_2, rscp_low_rim1_2, pscp_low_border3, pscp_low_border2, pscp_low_border4a, pscp_low_border4b, pscp_low_border1, pscp_low_border5};




// Dielectric surfaces

Line(131) = {6, 8};
Line(132) = {31, 33};
Line(133) = {7, 9};
Line(134) = {17, 20};
Line(135) = {18, 21};
Line(136) = {32, 34};

ll_cyl_dielectric1_1 = newreg; Line Loop(ll_cyl_dielectric1_1) = {4, 2, -6, -1};
rs_cyl_dielectric1_1 = newreg; Surface(rs_cyl_dielectric1_1) = {ll_cyl_dielectric1_1};
ll_cyl_dielectric1_2 = newreg; Line Loop(ll_cyl_dielectric1_2) = {5, 3, -7, -2};
rs_cyl_dielectric1_2 = newreg; Surface(rs_cyl_dielectric1_2) = {ll_cyl_dielectric1_2};

ll_cyl_dielectric3_1 = newreg; Line Loop(ll_cyl_dielectric3_1) = {23, -19, -21, 18};
rs_cyl_dielectric3_1 = newreg; Surface(rs_cyl_dielectric3_1) = {ll_cyl_dielectric3_1};
ll_cyl_dielectric3_2 = newreg; Line Loop(ll_cyl_dielectric3_2) = {24, -20, -22, 19};
rs_cyl_dielectric3_2 = newreg; Surface(rs_cyl_dielectric3_2) = {ll_cyl_dielectric3_2};

ll_cyl_dielectric2_1 = newreg; Line Loop(ll_cyl_dielectric2_1) = {14, 10, 75, -8};
rs_cyl_dielectric2_1 = newreg; Surface(rs_cyl_dielectric2_1) = {ll_cyl_dielectric2_1};
ll_cyl_dielectric2_2 = newreg; Line Loop(ll_cyl_dielectric2_2) = {9, -75, -11, -16};
rs_cyl_dielectric2_2 = newreg; Surface(rs_cyl_dielectric2_2) = {ll_cyl_dielectric2_2};
ll_cyl_dielectric2_3 = newreg; Line Loop(ll_cyl_dielectric2_3) = {15, 12, 74, -10};
rs_cyl_dielectric2_3 = newreg; Surface(rs_cyl_dielectric2_3) = {ll_cyl_dielectric2_3};
ll_cyl_dielectric2_4 = newreg; Line Loop(ll_cyl_dielectric2_4) = {17, 13, 74, -11};
rs_cyl_dielectric2_4 = newreg; Surface(rs_cyl_dielectric2_4) = {ll_cyl_dielectric2_4};

//sides
ll_side_dielectric1a = newreg; Line Loop(ll_side_dielectric1a) = {131, -5, -4};
ps_side_dielectric1a = newreg; Plane Surface(ps_side_dielectric1a) = {ll_side_dielectric1a};
ll_side_dielectric1b = newreg; Line Loop(ll_side_dielectric1b) = {131, 35, -128, -25};
ps_side_dielectric1b = newreg; Plane Surface(ps_side_dielectric1b) = {ll_side_dielectric1b};
ll_side_dielectric1c = newreg; Line Loop(ll_side_dielectric1c) = {21, 22, -132};
ps_side_dielectric1c = newreg; Plane Surface(ps_side_dielectric1c) = {ll_side_dielectric1c};
ll_side_dielectric1d = newreg; Line Loop(ll_side_dielectric1d) = {128, 130, -132, -26};
ps_side_dielectric1d = newreg; Plane Surface(ps_side_dielectric1d) = {ll_side_dielectric1d};

ll_side_dielectric2a = newreg; Line Loop(ll_side_dielectric2a) = {27, -76, -31, -136};
ps_side_dielectric2a = newreg; Plane Surface(ps_side_dielectric2a) = {ll_side_dielectric2a};
ll_side_dielectric2b = newreg; Line Loop(ll_side_dielectric2b) = {23, 24, -136};
ps_side_dielectric2b = newreg; Plane Surface(ps_side_dielectric2b) = {ll_side_dielectric2b};
ll_side_dielectric3a = newreg; Line Loop(ll_side_dielectric3a) = {76, 28, 135, -32};
ps_side_dielectric3a = newreg; Plane Surface(ps_side_dielectric3a) = {ll_side_dielectric3a};
ll_side_dielectric3b = newreg; Line Loop(ll_side_dielectric3b) = {135, -15, -14};
ps_side_dielectric3b = newreg; Plane Surface(ps_side_dielectric3b) = {ll_side_dielectric3b};


ll_side_dielectric4a = newreg; Line Loop(ll_side_dielectric4a) = {16, 17, -134};
ps_side_dielectric4a = newreg; Plane Surface(ps_side_dielectric4a) = {ll_side_dielectric4a};
ll_side_dielectric4b = newreg; Line Loop(ll_side_dielectric4b) = {33, 73, -29, 134};
ps_side_dielectric4b = newreg; Plane Surface(ps_side_dielectric4b) = {ll_side_dielectric4b};
ll_side_dielectric5a = newreg; Line Loop(ll_side_dielectric5a) = {30, 133, -34, 73};
ps_side_dielectric5a = newreg; Plane Surface(ps_side_dielectric5a) = {ll_side_dielectric5a};
ll_side_dielectric5b = newreg; Line Loop(ll_side_dielectric5b) = {6, 7, -133};
ps_side_dielectric5b = newreg; Plane Surface(ps_side_dielectric5b) = {ll_side_dielectric5b};

// Bounding surfaces 
ll_bsurf1 = newreg; Line Loop(ll_bsurf1) = {21, 22, 115, 106, 107, -117};
ps_bsurf1 = newreg; Plane Surface(ps_bsurf1) = {ll_bsurf1};
ll_bsurf2 = newreg; Line Loop(ll_bsurf2) = {24, 116, 106, 107, -118, 23};
ps_bsurf2 = newreg; Plane Surface(ps_bsurf2) = {ll_bsurf2};
ll_bsurf3a = newreg; Line Loop(ll_bsurf3a) = {16, 17, -123, 102, 103, 120};
ps_bsurf3a = newreg; Plane Surface(ps_bsurf3a) = {ll_bsurf3a};
ll_bsurf3b = newreg; Line Loop(ll_bsurf3b) = {103, -119, 14, 15, 122, 102};
ps_bsurf3b = newreg; Plane Surface(ps_bsurf3b) = {ll_bsurf3b};
ll_bsurf4 = newreg; Line Loop(ll_bsurf4) = {6, 7, 113, 110, 111, -124};
ps_bsurf4 = newreg; Plane Surface(ps_bsurf4) = {ll_bsurf4};
ll_bsurf5 = newreg; Line Loop(ll_bsurf5) = {4, 5, 114, 110, 111, 125};
ps_bsurf5 = newreg; Plane Surface(ps_bsurf5) = {ll_bsurf5};


ll_bsurf6a = newreg; Line Loop(ll_bsurf6a) = {83, 50, -45, 119, 104, -84, -77};
ps_bsurf6a = newreg; Plane Surface(ps_bsurf6a) = {ll_bsurf6a};
ll_bsurf6b = newreg; Line Loop(ll_bsurf6b) = {104, -84, 78, 85, -51, -46, -120};
ps_bsurf6b = newreg; Plane Surface(ps_bsurf6b) = {ll_bsurf6b};

ll_bsurf7a = newreg; Line Loop(ll_bsurf7a) = {88, -108, -117, 42, -126, -87, 81};
ps_bsurf7a = newreg; Plane Surface(ps_bsurf7a) = {ll_bsurf7a};
ll_bsurf7b = newreg; Line Loop(ll_bsurf7b) = {80, 87, -48, 41, -125, 112, -86};
ps_bsurf7b = newreg; Plane Surface(ps_bsurf7b) = {ll_bsurf7b};
ll_bsurf8 = newreg; Line Loop(ll_bsurf8) = {79, 86, -112, -124, -40, -52, -85};
ps_bsurf8 = newreg; Plane Surface(ps_bsurf8) = {ll_bsurf8};
ll_bsurf9 = newreg; Line Loop(ll_bsurf9) = {80, 81, 82, 77, 78, 79};
ps_bsurf9 = newreg; Plane Surface(ps_bsurf9) = {ll_bsurf9};

ll_bsurf10 = newreg; Line Loop(ll_bsurf10) = {95, -61, 67, 116, -105, -100, 94};
ps_bsurf10 = newreg; Plane Surface(ps_bsurf10) = {ll_bsurf10};
ll_bsurf11a = newreg; Line Loop(ll_bsurf11a) = {99, 60, 68, 115, -105, -100, -93};
ps_bsurf11a = newreg; Plane Surface(ps_bsurf11a) = {ll_bsurf11a};
ll_bsurf11b = newreg; Line Loop(ll_bsurf11b) = {98, 109, -114, -69, 59, -99, -92};
ps_bsurf11b = newreg; Plane Surface(ps_bsurf11b) = {ll_bsurf11b};

ll_bsurf12 = newreg; Line Loop(ll_bsurf12) = {97, 58, 70, 113, -109, -98, -91};
ps_bsurf12 = newreg; Plane Surface(ps_bsurf12) = {ll_bsurf12};
ll_bsurf13a = newreg; Line Loop(ll_bsurf13a) = {95, 62, 65, 122, -101, -96, -89};
ps_bsurf13a = newreg; Plane Surface(ps_bsurf13a) = {ll_bsurf13a};
ll_bsurf13b = newreg; Line Loop(ll_bsurf13b) = {96, 101, 123, -64, 57, -97, -90};
ps_bsurf13b = newreg; Plane Surface(ps_bsurf13b) = {ll_bsurf13b};
ll_bsurf14 = newreg; Line Loop(ll_bsurf14) = {91, 92, 93, 94, 89, 90};
ps_bsurf14 = newreg; Plane Surface(ps_bsurf14) = {ll_bsurf14};
ll_bsurf15 = newreg; Line Loop(ll_bsurf15) = {82, 83, -49, -43, 118, 108, -88};
ps_bsurf15 = newreg; Plane Surface(ps_bsurf15) = {ll_bsurf15};


// Dielectric volume
sl_dielectric = newreg; Surface Loop(sl_dielectric) = {216, 212, 214, 192, 208, 194, 210, 206, 204, 190, 226, 188, 224, 222, 220, 198, 202, 200, 196, 218, 176, 178};
vol_dielectric = newreg; Volume(vol_dielectric) = {sl_dielectric};
physvol_dielectric = newreg; Physical Volume(physvol_dielectric) = {vol_dielectric};


//phys_surf
physsurf_upper_el = newreg; Physical Surface(physsurf_upper_el) = {ps_bsurf9};
physsurf_lower_el = newreg; Physical Surface(physsurf_lower_el) = {ps_bsurf14};

// Surfaces for periodic boundary conditions
physsurf_bd1h1 = newreg; Physical Surface(physsurf_bd1h1) = {ps_bsurf5, ps_bsurf7b, ps_side_dielectric1a, ps_bsurf11b, ps_side_dielectric1b};
physsurf_bd1h2 = newreg; Physical Surface(physsurf_bd1h2) = {ps_side_dielectric3a, ps_side_dielectric3b, ps_bsurf6a, ps_bsurf13a, ps_bsurf3b};

physsurf_bd2h3 = newreg; Physical Surface(physsurf_bd2h3) = {ps_bsurf1, ps_bsurf7a, ps_side_dielectric1c, ps_bsurf11a, ps_side_dielectric1d};
physsurf_bd2h2 = newreg; Physical Surface(physsurf_bd2h2) = {ps_side_dielectric4b, ps_side_dielectric4a, ps_bsurf6b, ps_bsurf13b, ps_bsurf3a};

physsurf_bd3h1 = newreg; Physical Surface(physsurf_bd3h1) = {ps_bsurf8, ps_side_dielectric5a, ps_side_dielectric5b, ps_bsurf4, ps_bsurf12};
physsurf_bd3h3 = newreg; Physical Surface(physsurf_bd3h3) = {ps_bsurf15, ps_side_dielectric2a, ps_side_dielectric2b, ps_bsurf2, ps_bsurf10};



// Gas volume
sl_gas = newreg; Surface Loop(sl_gas) = {ps_bsurf9, ps_bsurf6a, ps_bsurf6b, ps_bsurf15, ps_bsurf7a, ps_bsurf7b, ps_bsurf8, ps_bsurf4, ps_bsurf12, ps_bsurf14, ps_bsurf11a, ps_bsurf11b, ps_bsurf5, ps_bsurf1, ps_bsurf2, ps_bsurf10, ps_bsurf13a, ps_bsurf13b, ps_bsurf3a, ps_bsurf3b, rs_cyl_dielectric2_1, rs_cyl_dielectric2_2, rs_cyl_dielectric2_3, rs_cyl_dielectric2_4, rscp_low_rim2_2, rscp_low_rim_1, rscp_low_rim_3, rscp_low_rim1_2, rscp_up_rim2_2, rscp_up_rim1_2, pscp_face1, pscp_face2, rscp_up_rim_1, rs_cyl_dielectric3_1,rs_cyl_dielectric3_2, rscp_up_rim_3, rs_cyl_dielectric1_1,rs_cyl_dielectric1_2};
vol_gas = newreg; Volume(vol_gas) = {sl_gas};

physvol_gas = newreg; Physical Volume(physvol_gas) = {vol_gas};

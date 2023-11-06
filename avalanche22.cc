/**
 * avalanche.cc
 * General program flow based on example code from the Garfield++ website.
 *
 * Demonstrates electron avalanche and induced signal readout with
 * 2D finite-element visualization in Garfield++ with a LEM. 
 * LEM parameters are from:
 * C. Shalem et. al. Nucl. Instr. Meth. A, 558, 475 (2006).
 *
*/
#include <iostream>
#include <cmath>

#include <TCanvas.h>
#include <TApplication.h>
#include <TFile.h>

#include "Garfield/MediumMagboltz.hh"
#include "Garfield/ComponentElmer.hh"
#include "Garfield/Sensor.hh"
#include "Garfield/ViewField.hh"
#include "Garfield/Plotting.hh"
#include "Garfield/ViewFEMesh.hh"
#include "Garfield/ViewSignal.hh"
#include "Garfield/GarfieldConstants.hh"
#include "Garfield/Random.hh"
#include "Garfield/AvalancheMicroscopic.hh"

using namespace Garfield;

int main(int argc, char* argv[]) {

  TApplication app("app", &argc, argv);

  // Set relevant LEM parameters.
  // LEM thickness in cm
  //const double lem_th = 0.05;      
  // Copper thickness
  //const double lem_cpth = 0.0035;  
  // LEM pitch in cm
  //const double lem_pitch = 0.014;   
  // X-width of drift simulation will cover between +/- axis_x
  //const double axis_x = 0.1;  
  // Y-width of drift simulation will cover between +/- axis_y
  //const double axis_y = 0.1;  
  //const double axis_z = 0.25 + lem_th / 2 + lem_cpth;


  // Define the medium.
  MediumMagboltz* gas = new MediumMagboltz();
  // Set the temperature (K)
  gas->SetTemperature(293.15);  
  // Set the pressure (Torr)
  gas->SetPressure(760.);       
  // Specify the gas mixture (Ar/CO2 70:30)
  gas->SetComposition("ar", 90., "ch4", 10.);  

  // Import an Elmer-created field map.
  ComponentElmer* elm = new ComponentElmer(
      "/home/wjaidee/Programs/garfieldpp/Examples/Elmer/newgem/gemcell/mesh.header", "/home/wjaidee/Programs/garfieldpp/Examples/Elmer/newgem/gemcell/mesh.elements", "/home/wjaidee/Programs/garfieldpp/Examples/Elmer/newgem/gemcell/mesh.nodes",
      "/home/wjaidee/Programs/garfieldpp/Examples/Elmer/newgem/gemcell/dielectrics.dat", "/home/wjaidee/Programs/garfieldpp/Examples/Elmer/newgem/gemcell/gemcell.result", "cm");
  elm->EnablePeriodicityX();
  elm->EnableMirrorPeriodicityY();
  elm->SetGas(gas);
  // Import the weighting field for the readout electrode.
  // elm->SetWeightingField("gemcell/gemcell_WTlel.result", "wtlel");


  
  const double pitch = 0.014;
  // old
  // Set up a sensor object.
  Sensor* sensor = new Sensor();
  sensor->AddComponent(elm);

  //sensor->SetArea(-axis_x, -axis_y, -axis_z, axis_x, axis_y, axis_z);
  sensor->SetArea(-5 * pitch, -5 * pitch, -0.01, 5 * pitch,  5 * pitch,  0.025);
  //sensor->AddElectrode(elm, "wtlel");
  // Set the signal binning.
  //const double tEnd = 500.0;
  //const int nsBins = 500;
  // sensor->SetTimeWindow(0., tEnd / nsBins, nsBins);

  // Create an avalanche object
  AvalancheMicroscopic* aval = new AvalancheMicroscopic();
  aval->SetSensor(sensor);
  aval->SetCollisionSteps(100);

  // Set up the object for drift line visualization.
  ViewDrift* viewDrift = new ViewDrift();
  // viewDrift->SetArea(-axis_x, -axis_y, -axis_z, axis_x, axis_y, axis_z);
  viewDrift->SetArea( -2 * pitch, -0.02, 2 * pitch, 0.02);
  aval->EnablePlotting(viewDrift);
  
  
  ViewField* vf = new ViewField();
  ViewFEMesh* vFE = new ViewFEMesh();
  const bool plotField = true;
  if (plotField) {
    TCanvas* cGeom = new TCanvas("geom", "Geometry/Avalanche/Fields");
    cGeom->SetLeftMargin(0.14);
    vf->SetSensor(sensor);
    vf->SetCanvas(cGeom);
    vf->SetArea(-2 *pitch, -0.02, 2 * pitch, 0.02);
    //vf->SetVoltageRange(-160.,160.);
    vf->SetNumberOfContours(40);
    vf->SetNumberOfSamples2d(30, 30);
    vf->SetPlane(0, -1, 0, 0, 0, 0);
    vf->PlotContour("v");
    
    TCanvas* cd = new TCanvas("drift", "Geometry/Avalanche/Fields");
    vFE->SetArea(-2 *pitch, -0.02, 2 * pitch, 0.02);
    vFE->SetCanvas(cd);
    vFE->SetComponent(elm);
    vFE->SetPlane(0, -1, 0, 0, 0, 0);
    vFE->SetFillMesh(true);
    vFE->SetColor(1, kGray);
    vFE->SetColor(2, kYellow + 3);
    vFE->SetColor(3, kYellow + 3);
    vFE->SetColor(4, kYellow + 3);
    vFE->EnableAxes();
    vFE->SetXaxisTitle("x (cm)");
    vFE->SetYaxisTitle("z (cm)");
    vFE->SetViewDrift(viewDrift);
    vFE->Plot();  
  }
  // above plot 2 windows: gem geom and potential contour

  // Count the total number of ions produced the back-flowing ions.
  const nTotal = 0;
  const nBF = 0;
  const nEvents = 10;
  for (const i = 0; i < nEvents; ++i) { 
    std::cout << i << "/" << nEvents << "\n";
    // Randomize the initial position. 
    const double x0 = -0.5 * pitch + RndmUniform() * pitch;
    const double y0 = -0.5 * pitch + RndmUniform() * pitch;
    const double z0 = 0.02; 
    const double t0 = 0.;
    const double e0 = 0.1;
    aval->AvalancheElectron(x0, y0, z0, t0, e0, 0., 0., 0.);
    int ne = 0, ni = 0;
    aval.GetAvalancheSize(ne, ni);
    for (const auto& electron : aval->GetElectrons()) {
      const auto& p0 = electron.path[0];
      drift->DriftIon(p0.x, p0.y, p0.z, p0.t);
      ++nTotal;
      const auto& endpoint = drift->GetIons().front().path.back();
      if (endpoint.z > 0.005) ++nBF;
    }
  }
  app.Run(kTRUE);
  return 0;
}

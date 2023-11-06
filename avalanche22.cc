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


  

  // old
  // Set up a sensor object.
  Sensor* sensor = new Sensor();
  sensor->AddComponent(elm);

  //sensor->SetArea(-axis_x, -axis_y, -axis_z, axis_x, axis_y, axis_z);
  sensor->SetArea(-5 * lem_pitch, -5 * lem_pitch, -0.01, 5 * lem_pitch,  5 * lem_pitch,  0.025);
  sensor->AddElectrode(elm, "wtlel");
  // Set the signal binning.
  const double tEnd = 500.0;
  const int nsBins = 500;
  // sensor->SetTimeWindow(0., tEnd / nsBins, nsBins);

  // Create an avalanche object
  AvalancheMicroscopic* aval = new AvalancheMicroscopic();
  aval->SetSensor(sensor);
  aval->SetCollisionSteps(100);

  // Set up the object for drift line visualization.
  ViewDrift* viewDrift = new ViewDrift();
  // viewDrift->SetArea(-axis_x, -axis_y, -axis_z, axis_x, axis_y, axis_z);
  viewDrift->SetArea( -2 * lem_pitch, -0.02, 2 * lem_pitch, 0.02)
  aval->EnablePlotting(viewDrift);

  const double pitch = 0.014;
  ViewField* vf = new ViewField();
  ViewFEMesh* vFE = new ViewFEMesh();
  const bool plotField = true;
  if (plotField) {
    vf->SetSensor(sensor);
    vf->SetCanvas(cGeom);
    vf->SetArea(-0.5 * pitch, -0.02, 0.5 * pitch, 0.02);
    //vf->SetVoltageRange(-160.,160.);
    vf->SetNumberOfContours(40);
    vf->SetNumberOfSamples2d(30, 30);
    vf->SetPlane(0, -1, 0, 0, 0, 0);
    vf->PlotContour("v");
    
    vFE->SetArea(-2 *lem_pitch, -0.02, 2 * lem_pitch, 0.02);
    vFE->SetCanvas(cGeom);
    vFE->SetComponent(elm);
    vFE->SetPlane(0, -1, 0, 0, 0, 0);
    vFE->SetFillMesh(true);
    vFE->SetColor(1, kGray);
    vFE->SetColor(2, kYellow + 3);
    vFE->SetColor(3, kYellow + 3);
    vFE->EnableAxes();
    vFE->SetXaxisTitle("x (cm)");
    vFE->SetYaxisTitle("z (cm)");
    vFE->SetViewDrift(viewDrift);
    vFE->Plot();
  }
  app.Run(kTRUE);
  return 0;
}

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

int main(int argc, char * argv[]) {
  TApplication app("app", &argc, argv);
    // Define the medium.
  MediumMagboltz* gas = new MediumMagboltz();
  // Set the temperature (K)
  gas->SetTemperature(293.15);  
  // Set the pressure (Torr)
  gas->SetPressure(740.);       
  // Specify the gas mixture (Ar/CO2 70:30)
  gas->SetComposition("ar", 70., "co2", 30.); 
  ComponentElmer* elm = new ComponentElmer(
      "gemcell/mesh.header", "gemcell/mesh.elements", "gemcell/mesh.nodes",
      "gemcell/dielectrics.dat", "gemcell/gemcell.result", "cm");
  elm->EnablePeriodicityX();
  elm->EnableMirrorPeriodicityY();

    // Dimensions of the GEM [cm]
  constexpr double pitch = 0.014;
  ViewField fieldView;
  fieldView.SetComponent(&fm);
  fieldView.SetPlaneXZ();
  // Set the plot limits in the current viewing plane.
  const double xmin = -0.5 * pitch;
  const double xmax =  0.5 * pitch;
  const double zmin = -0.02;
  const double zmax =  0.02;
  fieldView.SetArea(xmin, zmin, xmax, zmax);
  fieldView.SetVoltageRange(-160., 160.);
  fieldView.GetCanvas()->SetLeftMargin(0.16);
  fieldView.Plot("v", "CONT1");

  std::vector<double> xf;
  std::vector<double> yf;
  std::vector<double> zf;
  fieldView.EqualFluxIntervals(xmin, 0, 0.99 * zmax, xmax, 0, 0.99 * zmax,
                               xf, yf, zf, 20);
  fieldView.PlotFieldLines(xf, yf, zf, true, false);
  app.Run(true);
}

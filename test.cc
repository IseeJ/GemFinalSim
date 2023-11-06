#include <iostream>
#include <TApplication.h>
#include <TCanvas.h>
#include <Garfield/MediumMagboltz.hh>
#include <Garfield/ComponentElmer.hh>
#include <Garfield/Sensor.hh>
#include <Garfield/AvalancheMicroscopic.hh>
#include <Garfield/ViewDrift.hh>
#include <Garfield/ViewFEMesh.hh>

int main(int argc, char* argv[]) {
  TApplication app("app", &argc, argv);

  // Create a Garfield++ medium
  Garfield::MediumMagboltz* gas = new Garfield::MediumMagboltz();
  gas->SetTemperature(293.15);
  gas->SetPressure(760.);
  gas->SetComposition("ar", 90., "ch4", 10.);

  // Import an Elmer field map
  Garfield::ComponentElmer* elm = new Garfield::ComponentElmer("/home/wjaidee/Programs/garfieldpp/Examples/Elmer/newgem/gemcell/mesh.header", "/home/wjaidee/Programs/garfieldpp/Examples/Elmer/newgem/gemcell/mesh.elements", "/home/wjaidee/Programs/garfieldpp/Examples/Elmer/newgem/gemcell/mesh.nodes","/home/wjaidee/Programs/garfieldpp/Examples/Elmer/newgem/gemcell/dielectrics.dat", "/home/wjaidee/Programs/garfieldpp/Examples/Elmer/newgem/gemcell/gemcell.result", "cm");
    
  elm->EnablePeriodicityX();
  elm->EnableMirrorPeriodicityY();
  elm->SetGas(gas);

  // Set up the sensor
  Garfield::Sensor* sensor = new Garfield::Sensor();
  sensor->AddComponent(elm);
  sensor->SetArea(-0.1, -0.1, 0.0, 0.1, 0.1, 0.2);
  
  // Create an avalanche object
  Garfield::AvalancheMicroscopic* aval = new Garfield::AvalancheMicroscopic();
  aval->SetSensor(sensor);
  aval->SetCollisionSteps(100);

  // Set up object for drift line visualization
  Garfield::ViewDrift* viewDrift = new Garfield::ViewDrift();
  viewDrift->SetArea(-0.1, -0.1, 0.0, 0.1, 0.1, 0.2);
  aval->EnablePlotting(viewDrift);

  // Perform an avalanche (example starting point)
  const double x0 = 0.0, y0 = 0.0, z0 = 0.05; // Define starting point within the sensor area
  const double t0 = 0.;
  const double e0 = 0.1; // Energy (arbitrary)
  aval->AvalancheElectron(x0, y0, z0, t0, e0, 0., 0., 0.);

  // Plot the drift lines
  TCanvas* c = new TCanvas("c", "c", 800, 800);
  viewDrift->SetCanvas(c);
  viewDrift->Plot();
  
  app.Run();

  return 0;
}

#include <iostream>
#include <TApplication.h>
#include <TCanvas.h>
#include <Garfield/MediumMagboltz.hh>
#include <Garfield/ComponentElmer.hh>
#include <Garfield/Sensor.hh>
#include <Garfield/AvalancheMicroscopic.hh>
#include <Garfield/ViewFEMesh.hh>
#include <Garfield/ViewDrift.hh>

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
  sensor->SetArea(-0.1, -0.1, 0.0, 0.1, 0.1, 0.2); // Adjust as per your sensor area

  // Create an avalanche object
  Garfield::AvalancheMicroscopic* aval = new Garfield::AvalancheMicroscopic();
  aval->SetSensor(sensor);
  aval->SetCollisionSteps(100);

  // Set up view for GEM mesh
  Garfield::ViewFEMesh* viewMesh = new Garfield::ViewFEMesh();
  viewMesh->SetComponent(elm);
  viewMesh->SetPlane(0, -1, 0, 0, 0, 0); // Adjust plane as needed
  viewMesh->SetFillMesh(true);
  viewMesh->SetColor(1, kGray);
  viewMesh->SetColor(2, kYellow + 3);
  viewMesh->EnableAxes();

  // Set up view for electron drift lines
  Garfield::ViewDrift* viewDrift = new Garfield::ViewDrift();
  viewDrift->SetArea(-0.1, -0.1, 0.0, 0.1, 0.1, 0.2); // Adjust as per your sensor area
  aval->EnablePlotting(viewDrift);

  // Create a 3D canvas and plot both the mesh and drift lines
  TCanvas* c3d = new TCanvas("c3d", "GEM Mesh and Drift Lines", 800, 800);
  c3d->ToggleEventStatus();
  c3d->ToggleToolBar();
  viewMesh->SetCanvas(c3d);
  viewMesh->Plot();
  viewDrift->SetCanvas(c3d);
  viewDrift->Plot();

  app.Run();

  return 0;
}

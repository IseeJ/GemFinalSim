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
    // Define the medium
    MediumMagboltz* gas = new MediumMagboltz();
    gas->SetTemperature(293.15);  
    gas->SetPressure(760.);       
    gas->SetComposition("ar", 90., "ch4", 10.);
    // Define the component (ComponentElmer)
    ComponentElmer* elm = new ComponentElmer("/home/wjaidee/Programs/garfieldpp/Examples/Elmer/newgem/gemcell/mesh.header", "/home/wjaidee/Programs/garfieldpp/Examples/Elmer/newgem/gemcell/mesh.elements", "/home/wjaidee/Programs/garfieldpp/Examples/Elmer/newgem/gemcell/mesh.nodes","/home/wjaidee/Programs/garfieldpp/Examples/Elmer/newgem/gemcell/dielectrics.dat", "/home/wjaidee/Programs/garfieldpp/Examples/Elmer/newgem/gemcell/gemcell.result", "cm");
    // Additional component configurations...
  
    const double pitch = 0.014;
    Sensor* sensor = new Sensor();
    sensor->AddComponent(elm);
    sensor->SetArea(-5 * pitch, -5 * pitch, -0.01, 5 * pitch, 5 * pitch, 0.025);
    // Additional sensor configurations...
    // Initialize avalanche properties
    AvalancheMicroscopic* aval = new AvalancheMicroscopic();
    aval->SetSensor(sensor);
    aval->SetCollisionSteps(100);
    // Visualization setup
    ViewDrift* viewDrift = new ViewDrift();
    viewDrift->SetArea(-2 * pitch, -0.02, 2 * pitch, 0.02);
    aval->EnablePlotting(viewDrift);
    // Simulate multiple electron showers
    const int numElectronShowers = 5; // Simulate 5 electron showers
    for (int i = 0; i < numElectronShowers; ++i) {
        //double startX = -0.5 * pitch + RndmUniform() * pitch;
        //double startY = -0.5 * pitch + RndmUniform() * pitch;
        //double startX = -5 * pitch + RndmUniform() * pitch;
        //double startY = -5 * pitch + RndmUniform() * pitch;
        //const double startZ = 0.02;
        //const double t0 = 0.;
        //const double e0 = 0.1;
        //aval->AvalancheElectron(startX, startY, startZ, t0, e0, 0., 0., 0.);
        // Adjust the starting point to fit within the active area of the sensor
        const double x0 = -0.005 * pitch + RndmUniform() * pitch; // Example range (-4 * pitch, 4 * pitch)
        const double y0 = -0.005 * pitch + RndmUniform() * pitch; // Example range (-4 * pitch, 4 * pitch)
        const double z0 = 0.02;       // Example range (0.01, 0.025)
        const double t0 = 0.;
        const double e0 = 0.1;

        // Start the avalanche
        aval->AvalancheElectron(x0, y0, z0, t0, e0, 0., 0., 0.);



    }

    // Visualize drift lines and other components
    TCanvas* c = new TCanvas("DriftLines", "Drift Lines", 800, 600);
    viewDrift->SetCanvas(c);
    viewDrift->Plot();
    app.Run(kTRUE);
    return 0;
}

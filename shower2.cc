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
    ComponentElmer* elm = new ComponentElmer(
        /* Path to mesh.header */, 
        /* Path to mesh.elements */, 
        /* Path to mesh.nodes */,
        /* Path to dielectrics.dat */, 
        /* Path to gemcell.result */, 
        "cm"
    );
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
        double startX = /* Set the initial X-coordinate */;
        double startY = /* Set the initial Y-coordinate */;
        double startZ = /* Set the initial Z-coordinate */;

        aval->AvalancheElectron(startX, startY, startZ, 0., 0., 0.);
    }

    // Visualize drift lines and other components
    //...

    app.Run(kTRUE);

    return 0;
}


#include <iostream>
#include <cmath>

#include <TCanvas.h>
#include <TApplication.h>
#include <TFile.h>

#include "Garfield/MediumMagboltz.hh"
#include "Garfield/ComponentElmer.hh"
#include "Garfield/Sensor.hh"
#include "Garfield/ViewField.hh"
#include "Garfield/ViewFEMesh.hh"
#include "Garfield/ViewDrift.hh"
#include "Garfield/Plotting.hh"
#include "Garfield/GarfieldConstants.hh"
#include "Garfield/Random.hh"
#include "Garfield/AvalancheMicroscopic.hh"

using namespace Garfield;

void SimulateElectronShowers(ViewDrift* viewDrift, ComponentElmer* elm, int num_showers) {
    // Loop to generate multiple electron showers
    for (int i = 0; i < num_showers; ++i) {
        // Generate electron starting positions for each shower
        // Replace this with your method to set initial electron positions
        double initial_x = 0.0; // Example initial x position
        double initial_y = 0.0; // Example initial y position
        double initial_z = 0.0; // Example initial z position

        // Set the starting point for the drift line
        viewDrift->SetParticle("electron");
        viewDrift->SetViewPoint(initial_x, initial_y, initial_z);

        // Plot the drift line for this electron shower
        viewDrift->Plot();
    }
}

int main(int argc, char* argv[]) {
    TApplication app("app", &argc, argv);

    // Set up the medium
    MediumMagboltz* gas = new MediumMagboltz();
    gas->SetTemperature(293.15);  
    gas->SetPressure(760.);       
    gas->SetComposition("ar", 90., "ch4", 10.);

    // Set up the component and sensor
    ComponentElmer* elm = new ComponentElmer(
    "/home/wjaidee/Programs/garfieldpp/Examples/Elmer/newgem/gemcell/mesh.header", "/home/wjaidee/Programs/garfieldpp/Examples/Elmer/newgem/gemcell/mesh.elements", "/home/wjaidee/Programs/garfieldpp/Examples/Elmer/newgem/gemcell/mesh.nodes", "/home/wjaidee/Programs/garfieldpp/Examples/Elmer/newgem/gemcell/dielectrics.dat", "/home/wjaidee/Programs/garfieldpp/Examples/Elmer/newgem/gemcell/gemcell.result", "cm");
  
    elm->SetGas(gas);

    Sensor* sensor = new Sensor();
    sensor->AddComponent(elm);
    sensor->SetArea(-0.07, -0.07, -0.01, 0.07, 0.07, 0.25);

    // Set up the drift line visualization
    ViewDrift* viewDrift = new ViewDrift();
    viewDrift->SetArea(-0.07, -0.07, 0.07, 0.07);

    // Create the avalanche object and link it to the sensor
    AvalancheMicroscopic* aval = new AvalancheMicroscopic();
    aval->SetSensor(sensor);
    aval->SetCollisionSteps(100);
    aval->EnablePlotting(viewDrift);

    // Set up field visualization, plot potential contour, and geometry
    TCanvas* cGeom = new TCanvas("geom", "Geometry/Avalanche/Fields");
    // ... (Add your field visualization code)

    // Generate and visualize electron showers
    SimulateElectronShowers(viewDrift, elm, 5); // Simulate 5 electron showers

    app.Run(kTRUE);
    return 0;
}

#include <iostream>
#include <TCanvas.h>
#include <TApplication.h>
#include "Garfield/MediumMagboltz.hh"
#include "Garfield/ComponentElmer.hh"
#include "Garfield/Sensor.hh"
#include "Garfield/ViewFEMesh.hh"
#include "Garfield/AvalancheMicroscopic.hh"
#include "Garfield/ViewDrift.hh"
#include "Garfield/DriftLineRKF.hh"
#include "Garfield/Random.hh"

using namespace Garfield;

int main(int argc, char* argv[]) {
    TApplication app("app", &argc, argv);

    // Set relevant LEM parameters.
    // ...

    // Define the medium.
    MediumMagboltz* gas = new MediumMagboltz();
    // ...

    // Import an Elmer-created field map.
    ComponentElmer* elm = new ComponentElmer(/* Elmer file paths */);
    // ...

    const double pitch = 0.014;

    Sensor* sensor = new Sensor();
    sensor->AddComponent(elm);
    sensor->SetArea(/* Set your desired sensor area */);

    AvalancheMicroscopic* aval = new AvalancheMicroscopic();
    aval->SetSensor(sensor);
    aval->SetCollisionSteps(100);

    ViewDrift* viewDrift = new ViewDrift();
    viewDrift->SetArea( -2 * pitch, -0.02, 2 * pitch, 0.02);
    aval->EnablePlotting(viewDrift);

    ViewFEMesh* vFE = new ViewFEMesh();
    const bool plotField = true;

    if (plotField) {
        // ... (code for plotting field contours)
        // ...

        // Electron avalanche and ion tracking section
        // Count the total number of ions produced and the back-flowing ions
        unsigned int nTotal = 0;
        unsigned int nBF = 0;
        constexpr unsigned int nEvents = 10;

        for (unsigned int i = 0; i < nEvents; ++i) {
            // Randomize the initial position
            const double x0 = -0.5 * pitch + RndmUniform() * pitch;
            const double y0 = -0.5 * pitch + RndmUniform() * pitch;
            const double z0 = 0.02;
            const double t0 = 0.;
            const double e0 = 0.1;

            aval->AvalancheElectron(x0, y0, z0, t0, e0, 0., 0., 0.);
            
            int ne = 0, ni = 0;
            aval->GetAvalancheSize(ne, ni);
            
            for (const auto& electron : aval->GetElectrons()) {
                const auto& p0 = electron.path[0];
                // Track ions using drift object
                // drift.DriftIon(p0.x, p0.y, p0.z, p0.t);
                ++nTotal;
                const auto& endpoint = drift.GetIons().front().path.back();
                if (endpoint.z > 0.005) ++nBF;
            }
        }

        std::cout << "Fraction of back-flowing ions: " 
                << double(nBF) / double(nTotal) << "\n";
    }

    app.Run(kTRUE);
    return 0;
}


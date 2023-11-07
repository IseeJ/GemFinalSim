"""# **2. 3D LEM example**


"""### Create the .sif file"""

gemcell_sif_text = """
Check Keywords Warn

! Set drift distance, E fields, and voltage between GEMs
! dist: distance in cm
! Edrift: drift field in V/cm
! Etrans: transfer field in V/cm
! deltaV: voltage (in V) between GEMs
$ldist = 0.2
$udist = 0.5
$Edrift = 50
$Etrans = 1000
$deltaV = 850

$WTuel = 0
$WTucp = 0
$WTlcp = 0
$WTlel = 0

Header
  Mesh DB "." "gemcell"
End

Simulation
  Coordinate System = Cartesian 3D
  Simulation Type = Steady State
  Steady State Max Iterations = 1
  Output File = "gemcell.result"
  Post File = "gemcell.ep"
End

Constants
  Permittivity Of Vacuum = 8.8542e-12
End

Body 1
  Equation = 1
  Material = 1
End

Body 2
  Equation = 1
  Material = 2
End

Body 3
  Equation = 1
  Material = 3
End

Body 4
  Equation = 1
  Material = 3
End

Equation 1
  Active Solvers(1) = 1
  Calculate Electric Energy = True
End

Solver 1
  Equation = Stat Elec Solver
  Variable = Potential
  Variable DOFs = 1
  Procedure = "StatElecSolve" "StatElecSolver"
  Calculate Electric Field = True
  Calculate Electric Flux = False
  Linear System Solver = Iterative
  Linear System Iterative Method = BiCGStab
  Linear System Max Iterations = 1000
  Linear System Abort Not Converged = True
  Linear System Convergence Tolerance = 1.0e-10
  Linear System Preconditioning = ILU1
  Steady State Convergence Tolerance = 5.0e-7
!  Adaptive Mesh Refinement = True
!  Adaptive Remesh = True
!  Adaptive Save Mesh = True
!  Adaptive Error Limit = 1.0e-12
End

! Gas
Material 1
  Relative Permittivity = 1
  Density = 1
End

! Dielectric
Material 2
  Relative Permittivity = 3.23
  Density = 2
End

! Copper
Material 3
  Relative Permittivity = 1.0e10
  Density = 3
End

! Upper copper plate
Boundary Condition 1
  Target Boundaries = 1
  Potential = $-1*Etrans*ldist - deltaV + WTucp
End

! Lower copper plate
Boundary Condition 2
  Target Boundaries = 2
  Potential = $-1*Etrans*ldist + WTlcp
End

! Upper electrode
Boundary Condition 3
  Target Boundaries = 3
  Potential = $-1*Etrans*ldist - deltaV - Edrift*udist + WTuel
End

! Lower electrode
Boundary Condition 4
  Target Boundaries = 4
  Potential = $WTlel
End

! Set up boundary A for hole 1
Boundary Condition 5
  Target Boundaries = 5
End
! Link to half A of hole 2
Boundary Condition 6
  Target Boundaries = 6
  Periodic BC = 5
  Periodic BC Potential = Logical True
End

! Set up boundary B for hole 3
Boundary Condition 7
  Target Boundaries = 7
End
! Link to half B of hole 2
Boundary Condition 8
  Target Boundaries = 8
  Periodic BC = 7
  Periodic BC Potential = Logical True
End

! Set up boundary C for hole 1 side
Boundary Condition 9
  Target Boundaries = 9
End
! Link to the side containing hole 3
Boundary Condition 10
  Target Boundaries = 10
  Periodic BC = 9
  Periodic BC Potential = Logical True
End
"""

gemcell_sif_file = open("gemcell.sif", "w")
gemcell_sif_file.write(gemcell_sif_text)
gemcell_sif_file.close()

"""### Solve for the fields with ElmerSolver"""
"""### Create the file dielectrics.dat"""

gemcell_dielectrics_text = """4
1 1
2 3.23
3 1e10
4 1e10
"""
gemcell_dielectrics_file = open("gemcell/dielectrics.dat", "w")
gemcell_dielectrics_file.write(gemcell_dielectrics_text)
gemcell_dielectrics_file.close()

"""## Import the field map into Garfield++

### Setup
"""

# Set relevant LEM parameters.
# LEM thickness in cm
lem_th = 0.04;
# copper thickness
lem_cpth = 0.0035;
# LEM pitch in cm
lem_pitch = 0.07;
# X-width of drift simulation will cover between +/- axis_x
axis_x = 0.1;
# Y-width of drift simulation will cover between +/- axis_y
axis_y = 0.1;
axis_z = 0.25 + lem_th / 2 + lem_cpth;

# Define the medium.
gas = ROOT.Garfield.MediumMagboltz()
gas.SetTemperature(293.15)
gas.SetPressure(740.)
gas.EnableDrift()
gas.SetComposition("ar", 70., "co2", 30.)

# Read in the 3D field map.
elm = ROOT.Garfield.ComponentElmer(
      "gemcell/mesh.header", "gemcell/mesh.elements", "gemcell/mesh.nodes",
      "gemcell/dielectrics.dat", "gemcell/gemcell.result", "cm")
elm.EnablePeriodicityX()
elm.EnableMirrorPeriodicityY()
elm.SetMedium(0, gas)

# Create a Sensor object.
sensor = ROOT.Garfield.Sensor()
sensor.AddComponent(elm)
sensor.SetArea(-axis_x, -axis_y, -axis_z, axis_x, axis_y, axis_z)

"""### Launch a single avalanche, keeping track of the drift line"""

# Create an avalanche object.
aval = ROOT.Garfield.AvalancheMicroscopic()
aval.SetSensor(sensor)
aval.SetCollisionSteps(100)

# Set up the object for drift line visualization.
viewDrift = ROOT.Garfield.ViewDrift()
viewDrift.SetArea(-axis_x, -axis_y, -axis_z, axis_x, axis_y, axis_z)
aval.EnablePlotting(viewDrift)

# Set up and launch the avalanche.
zi = 0.5 * lem_th + lem_cpth + 0.1
ri = (lem_pitch / 2) * np.random.uniform()
thetai = np.random.uniform() * 2*np.pi
xi = ri * np.cos(thetai)
yi = ri * np.sin(thetai)
aval.AvalancheElectron(xi, yi, zi, 0., 0., 0., 0., 0.)
print("... avalanche complete with ", aval.GetNumberOfElectronEndpoints(), " electron tracks.\n")

"""### Plot the results."""

# Plot the geometry and drift line.
cGeom = ROOT.TCanvas("geom", "Geometry")
viewMesh = ROOT.Garfield.ViewFEMesh()
viewMesh.SetArea(-axis_x, -axis_z, -axis_y, axis_x, axis_z, axis_y)
viewMesh.SetCanvas(cGeom)
viewMesh.SetComponent(elm)
viewMesh.SetPlane(0, -1, 0, 0, 0, 0)
viewMesh.SetFillMesh(True)
viewMesh.SetColor(1,ROOT.kGray)
viewMesh.SetColor(2,ROOT.kYellow + 3)
viewMesh.SetColor(3,ROOT.kYellow + 3)
viewMesh.EnableAxes()
viewMesh.SetXaxisTitle("x (cm)")
viewMesh.SetYaxisTitle("x (cm)")
viewMesh.SetViewDrift(viewDrift)
viewMesh.Plot()
cGeom.Draw()

# Plot the fields.
cFields = ROOT.TCanvas("fields", "Fields")
viewField = ROOT.Garfield.ViewField()
viewField.SetSensor(sensor)
viewField.SetCanvas(cFields)
viewField.SetArea(-axis_x, -axis_z, axis_x, axis_z)
viewField.SetNumberOfContours(20)
viewField.SetNumberOfSamples2d(30, 30)
viewField.SetPlane(0, -1, 0, 0, 0, 0)
viewField.PlotContour("v")
cFields.Draw()

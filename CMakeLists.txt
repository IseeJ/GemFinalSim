cmake_minimum_required(VERSION 3.9 FATAL_ERROR)
project(GEM)
if(NOT TARGET Garfield::Garfield)
  find_package(Garfield REQUIRED)
endif()

# ---Build executable------------------------------------------------------------
<<<<<<< HEAD
<<<<<<< HEAD
add_executable(avalanche avalanche22.cc)
=======
add_executable(avalanche shower2.cc)
>>>>>>> ce596bc11b53ead4769682e591b7aa1500172d4d
=======
add_executable(avalanche avalanche2.cc)
>>>>>>> a4c8ce587b931ca32cb4115993928e6b28a516bf
target_link_libraries(avalanche Garfield::Garfield)

# ---Copy all files locally to the build directory-------------------------------
foreach(_file gemcell/mesh.header gemcell/mesh.elements gemcell/mesh.nodes
              gemcell/dielectrics.dat gemcell/gemcell.result)
  configure_file(${_file} ${_file} COPYONLY)
endforeach()

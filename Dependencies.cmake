# Copyright (c) 2014-2016 Kartik Kumar, Dinamica Srl (me@kartikkumar.com)
# Distributed under the MIT License.
# See accompanying file LICENSE.md or copy at http://opensource.org/licenses/MIT

# Include script to build external library with CMake.
include(ExternalProject)

if(NOT BUILD_DEPENDENCIES)
  find_package(SML)
endif(NOT BUILD_DEPENDENCIES)

if(NOT SML_FOUND)
  message(STATUS "SML will be downloaded when ${CMAKE_PROJECT_NAME} is built")
  ExternalProject_Add(sml-lib
    PREFIX ${EXTERNAL_PATH}/SML
    #--Download step--------------
    URL https://github.com/openastro/sml/archive/master.zip
    TIMEOUT 30
    #--Update/Patch step----------
    UPDATE_COMMAND ""
    PATCH_COMMAND ""
    #--Configure step-------------
    CONFIGURE_COMMAND ""
    #--Build step-----------------
    BUILD_COMMAND ""
    #--Install step---------------
    INSTALL_COMMAND ""
    #--Output logging-------------
    LOG_DOWNLOAD ON
  )
  ExternalProject_Get_Property(sml-lib source_dir)
  set(SML_INCLUDE_DIRS ${source_dir}/include CACHE INTERNAL "Path to include folder for SML")
endif(NOT SML_FOUND)

if(NOT APPLE)
  include_directories(SYSTEM AFTER "${SML_INCLUDE_DIRS}")
else(APPLE)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -isystem \"${SML_INCLUDE_DIRS}\"")
endif(NOT APPLE)

# -------------------------------

if(NOT BUILD_DEPENDENCIES)
  find_package(Astro)
endif(NOT BUILD_DEPENDENCIES)

if(NOT ASTRO_FOUND)
  message(STATUS "Astro will be downloaded when ${CMAKE_PROJECT_NAME} is built")
  ExternalProject_Add(astro-lib
    DEPENDS sml-lib
    PREFIX ${EXTERNAL_PATH}/Astro
    #--Download step--------------
    URL https://github.com/openastro/astro/archive/master.zip
    TIMEOUT 30
    #--Update/Patch step----------
    UPDATE_COMMAND ""
    PATCH_COMMAND ""
    #--Configure step-------------
    CONFIGURE_COMMAND ""
    #--Build step-----------------
    BUILD_COMMAND ""
    #--Install step---------------
    INSTALL_COMMAND ""
    #--Output logging-------------
    LOG_DOWNLOAD ON
  )
  ExternalProject_Get_Property(astro-lib source_dir)
  set(ASTRO_INCLUDE_DIRS ${source_dir}/include CACHE INTERNAL "Path to include folder for Astro")
endif(NOT ASTRO_FOUND)

if(NOT APPLE)
  include_directories(SYSTEM AFTER "${ASTRO_INCLUDE_DIRS}")
else(APPLE)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -isystem \"${ASTRO_INCLUDE_DIRS}\"")
endif(NOT APPLE)

# -------------------------------

if(NOT BUILD_DEPENDENCIES)
  find_package(SGP4)
endif(NOT BUILD_DEPENDENCIES)

if(NOT SGP4_FOUND)
  message(STATUS "SGP4 will be downloaded when ${CMAKE_PROJECT_NAME} is built")
  ExternalProject_Add(sgp4-lib
    PREFIX ${EXTERNAL_PATH}/SGP4
    #--Download step--------------
    URL https://github.com/openastro/sgp4/archive/master.zip
    TIMEOUT 30
    #--Update/Patch step----------
    #--Configure step-------------
    #--Build step-----------------
    BUILD_IN_SOURCE 1
    #--Install step---------------
    INSTALL_COMMAND ""
    #--Output logging-------------
    LOG_DOWNLOAD ON
  )
  ExternalProject_Get_Property(sgp4-lib source_dir)
  set(SGP4_INCLUDE_DIRS ${source_dir} CACHE INTERNAL "Path to include folder for SGP4")
  set(SGP4_LIBRARY_DIR ${source_dir}/libsgp4 CACHE INTERNAL "Path to library folder for SGP4")
  set(SGP4_LIBRARY "sgp4")
endif(NOT SGP4_FOUND)

if(NOT APPLE)
  include_directories(SYSTEM AFTER "${SGP4_INCLUDE_DIRS}")
else(APPLE)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -isystem \"${SGP4_INCLUDE_DIRS}\"")
endif(NOT APPLE)
link_directories(${SGP4_LIBRARY_DIR})

# -------------------------------

if(NOT BUILD_DEPENDENCIES)
  find_package(GSL)
endif(NOT BUILD_DEPENDENCIES)

if(NOT GSL_FOUND)
  message(STATUS "GSL will be downloaded when ${CMAKE_PROJECT_NAME} is built")
  ExternalProject_Add(gsl-lib
    PREFIX ${EXTERNAL_PATH}/GSL
    #--Download step--------------
    URL https://github.com/ampl/gsl/archive/master.zip
    TIMEOUT 30
    #--Update/Patch step----------
    #--Configure step-------------
    #--Build step-----------------
    BUILD_IN_SOURCE 1
    #--Install step---------------
    INSTALL_COMMAND ""
    #--Output logging-------------
    LOG_DOWNLOAD ON
  )
  ExternalProject_Get_Property(gsl-lib source_dir)
  set(GSL_INCLUDE_DIRS ${source_dir} CACHE INTERNAL "Path to include folder for SGP4")
  set(GSL_LIBRARY_DIRS ${source_dir} CACHE INTERNAL "Path to library folder for SGP4")
  set(GSL_LIBRARIES "gsl" "gslcblas")
endif(NOT GSL_FOUND)

if(NOT APPLE)
  include_directories(SYSTEM AFTER "${GSL_INCLUDE_DIRS}")
else(APPLE)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -isystem \"${GSL_INCLUDE_DIRS}\"")
endif(NOT APPLE)
link_directories(${GSL_LIBRARY_DIRS})

# -------------------------------

if(BUILD_TESTS)
  if(NOT BUILD_DEPENDENCIES)
    find_package(CATCH)
  endif(NOT BUILD_DEPENDENCIES)

  if(NOT CATCH_FOUND)
    message(STATUS "Catch will be downloaded when ${CMAKE_PROJECT_NAME} is built")
    ExternalProject_Add(catch
      PREFIX ${EXTERNAL_PATH}/Catch
      #--Download step--------------
      URL https://github.com/philsquared/Catch/archive/master.zip
      TIMEOUT 30
      #--Update/Patch step----------
      UPDATE_COMMAND ""
      PATCH_COMMAND ""
      #--Configure step-------------
      CONFIGURE_COMMAND ""
      #--Build step-----------------
      BUILD_COMMAND ""
      #--Install step---------------
      INSTALL_COMMAND ""
      #--Output logging-------------
      LOG_DOWNLOAD ON
    )
    ExternalProject_Get_Property(catch source_dir)
    set(CATCH_INCLUDE_DIRS ${source_dir}/include CACHE INTERNAL "Path to include folder for Catch")
  endif(NOT CATCH_FOUND)

  if(NOT APPLE)
    include_directories(SYSTEM AFTER "${CATCH_INCLUDE_DIRS}")
  else(APPLE)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -isystem \"${CATCH_INCLUDE_DIRS}\"")
  endif(NOT APPLE)

  if(BUILD_TESTS_WITH_EIGEN)
    if(NOT BUILD_DEPENDENCIES)
      find_package(Eigen3)
    endif(NOT BUILD_DEPENDENCIES)

    if(NOT EIGEN3_FOUND)
      message(STATUS "Eigen will be downloaded when ${CMAKE_PROJECT_NAME} is built")
      ExternalProject_Add(eigen-lib
        PREFIX ${EXTERNAL_PATH}/Eigen
        #--Download step--------------
        URL http://bitbucket.org/eigen/eigen/get/3.2.2.tar.gz
        TIMEOUT 30
        #--Update/Patch step----------
        UPDATE_COMMAND ""
        PATCH_COMMAND ""
        #--Configure step-------------
        CONFIGURE_COMMAND ""
        #--Build step-----------------
        BUILD_COMMAND ""
        #--Install step---------------
        INSTALL_COMMAND ""
        #--Output logging-------------
        LOG_DOWNLOAD ON
      )
      ExternalProject_Get_Property(eigen-lib source_dir)
      set(EIGEN3_INCLUDE_DIR ${source_dir} CACHE INTERNAL "Path to include folder for Eigen")
    endif(NOT EIGEN3_FOUND)

    if(NOT APPLE)
      include_directories(SYSTEM AFTER "${EIGEN3_INCLUDE_DIR}")
    else(APPLE)
      set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -isystem \"${EIGEN3_INCLUDE_DIR}\"")
    endif(NOT APPLE)
  endif(BUILD_TESTS_WITH_EIGEN)
endif(BUILD_TESTS)

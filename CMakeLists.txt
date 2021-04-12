cmake_minimum_required(VERSION 3.1)
project(image_sign VERSION 0.1)
configure_file("${PROJECT_SOURCE_DIR}/include/version.hpp.in" "${PROJECT_SOURCE_DIR}/include/version.hpp")
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(gflags REQUIRED)
find_package(OpenCV REQUIRED)
include_directories(${GFLAGS_INCLUDE_DIR})
include_directories(${OpenCV_INCLUDE_DIRS})

add_executable(image_sign
  "src/main.cpp")
target_include_directories(image_sign PRIVATE "${PROJECT_SOURCE_DIR}/include")
target_link_libraries(image_sign PRIVATE
  ${OpenCV_LIBRARIES}
  ${GFLAGS_LIBRARIES})

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO epezent/implot
    REF v${VERSION}
    SHA512 d33c83762ada55d4e188e975faf0c12d42cb3eb6b63904e6bce5b18d4184a2cdfc14e0b92286717ab86a1361dad7161e24402724f4eda2c0bce5658787d2dbe3
    HEAD_REF master
    PATCHES
        fix-build.patch
)

file(COPY "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" DESTINATION "${SOURCE_PATH}")

if("dllexport" IN_LIST FEATURES)
    vcpkg_replace_string("${SOURCE_PATH}/implot.h" "#define IMPLOT_API" "#define IMPLOT_API __declspec( dllexport )")
endif()

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS_DEBUG
        -DIMPLOT_SKIP_HEADERS=ON
)

vcpkg_cmake_install()

if("dllexport" IN_LIST FEATURES)
    vcpkg_replace_string("${SOURCE_PATH}/implot.h" "#define IMPLOT_API __declspec( dllexport )" "#define IMPLOT_API")
endif()

vcpkg_copy_pdbs()
vcpkg_cmake_config_fixup()

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

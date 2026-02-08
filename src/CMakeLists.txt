add_executable(kratio)

ecm_add_qml_module(kratio
    URI
    dev.jtsimon.kratio
)

target_sources(kratio
    PRIVATE
    main.cpp
    ratiocalculator.h
    ratiocalculator.cpp
)

ecm_target_qml_sources(kratio
    SOURCES
    qml/Main.qml
    qml/RatioCalculatorPage.qml
)

target_link_libraries(kratio
    PRIVATE
    Qt6::Quick
    Qt6::Qml
    Qt6::Gui
    Qt6::QuickControls2
    Qt6::Widgets
    KF6::I18n
    KF6::CoreAddons
    KF6::IconThemes
    KF6::Kirigami
)

install(TARGETS kratio ${KDE_INSTALL_TARGETS_DEFAULT_ARGS})

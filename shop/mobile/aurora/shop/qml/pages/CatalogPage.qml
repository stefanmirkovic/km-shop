import QtQuick 2.0
import Sailfish.Silica 1.0
import AppTheme 1.0
import QtGraphicalEffects 1.0
import "../components" as Components

Page {
    id: catalogPage

    property int tabIndex: 0

    QtObject {
        id: stateCattegories
        property var response
        property string error: ""
        property bool loading: true
    }

    ListModel {
        id: categoriesModel
    }

    QtObject {
        id: stateCollections
        property var response
        property string error: ""
        property bool loading: true
    }

    ListModel {
        id: collectionsModel
    }

    Component.onCompleted: {
        // get categories
        agent.run(
            "kmm.Requests.get.categoriesPublished()",
            function(result) {
                try {
                    var list = JSON.parse(result)
                    stateCattegories.response = list
                    for (var index = 0; index < list.length; index++) {
                        categoriesModel.append(list[index])
                    }
                } catch (e) {
                    stateCattegories.error = error
                }
                stateCattegories.loading = false
            },
            function(error) {
                stateCattegories.error = error
                stateCattegories.loading = false
            }
        )
        // get collections
        agent.run(
            // @todo delay
            "kmm.Requests.get.collectionsPublished(3000)",
            function(result) {
                try {
                    var list = JSON.parse(result)
                    stateCollections.response = list
                    for (var index = 0; index < list.length; index++) {
                        collectionsModel.append(list[index])
                    }
                } catch (e) {
                    stateCollections.error = error
                }
                stateCollections.loading = false
            },
            function(error) {
                stateCollections.error = error
                stateCollections.loading = false
            }
        )
    }

    Components.AppPage {
        id: idAppPage
        header: qsTr("Каталог")
        menuDisabled: state.loading
        selectedPage: "itemMenuCatalog"
        fixed: stateCattegories.loading || stateCollections.loading

        Components.AppTabs {
            id: appTabs
            width: parent.width
            textTab0: qsTr("Категории")
            textTab1: qsTr("Коллекции")
            onTabChanged: tabIndex = appTabs.tab;
        }

        Column {
            id: contentCat
            visible: tabIndex == 0
            opacity: tabIndex == 0 ? 1.0 : 0.9
            width: parent.width
            spacing: appTheme.paddingMedium

            Behavior on opacity {
                NumberAnimation { properties: "opacity"; easing.type: Easing.InOutQuad; duration: 300 }
            }

            Components.AppBlock {
                height: idAppPage.pageH - appTabs.height - appTheme.paddingMedium
                width: parent.width
                borderColor: appTheme.colorVariant1
                visible: stateCattegories.loading || stateCattegories.error !== ""

                Components.BlockLoading {
                    borderColor: appTheme.colorVariant1
                    visible: stateCattegories.loading
                }

                Components.BlockError {
                    color: appTheme.colorVariant1
                    error: stateCattegories.error
                    visible: stateCattegories.error !== ""
                }
            }

            Repeater {
                  model: categoriesModel
                  delegate: Components.AppBlock {
                      width: parent.width
                      borderColor: appTheme.colorVariant1
                      disabled: false

                      Row {
                          width: parent.width
                          spacing: appTheme.paddingLarge

                          Image {
                              id: img
                              source: Qt.resolvedUrl(f4o_1)
                              fillMode: Image.PreserveAspectCrop
                              anchors.verticalCenter: parent.verticalCenter
                              width: 90
                              height: 90
                              layer.enabled: true
                              layer.effect: OpacityMask {
                                  maskSource: Item {
                                      width: img.width
                                      height: img.height
                                      Rectangle {
                                          anchors.centerIn: parent
                                          width: img.adapt ? img.width : Math.min(img.width, img.height)
                                          height: img.adapt ? img.height : width
                                          radius: Math.min(width, height)
                                      }
                                  }
                              }
                          }

                          Rectangle {
                              color: 'transparent'
                              height: iconData.height
                              width: parent.width - img.width - appTheme.paddingLarge
                              anchors.verticalCenter: parent.verticalCenter

                              Column {
                                  id: iconData
                                  width: parent.width
                                  spacing: appTheme.paddingSmall
                                  anchors.top: parent.top
                                  anchors.topMargin: -3

                                  Text {
                                      width: parent.width
                                      text: d4o_1
                                      wrapMode: Text.WordWrap
                                      font.pixelSize: appTheme.fontSizeH6
                                  }

                                  Text {
                                      width: parent.width
                                      text: e4o_1
                                      wrapMode: Text.WordWrap
                                      font.pixelSize: appTheme.fontSizeCaption
                                  }
                              }
                          }
                      }
                  }
           }
        }

        Column {
            id: contentColl
            visible: tabIndex == 1
            opacity: tabIndex == 1 ? 1.0 : 0.9
            width: parent.width
            spacing: appTheme.paddingMedium

            Behavior on opacity {
                NumberAnimation { properties: "opacity"; easing.type: Easing.InOutQuad; duration: 300 }
            }

            Components.AppBlock {
                height: idAppPage.pageH - appTabs.height - appTheme.paddingMedium
                width: parent.width
                borderColor: appTheme.colorVariant1
                visible: stateCollections.loading || stateCollections.error !== ""

                Components.BlockLoading {
                    borderColor: appTheme.colorVariant1
                    visible: stateCollections.loading
                }

                Components.BlockError {
                    color: appTheme.colorVariant1
                    error: stateCollections.error
                    visible: stateCollections.error !== ""
                }
            }

            Repeater {
                  model: collectionsModel
                  delegate: Components.AppBlock {
                      width: parent.width
                      borderColor: appTheme.colorVariant1
                      disabled: false

                      Row {
                          width: parent.width
                          spacing: appTheme.paddingLarge

                          Rectangle {
                              id: iconRect
                              width: 90
                              height: 90
                              color: "transparent"
                              border.color: appTheme.colorVariant1
                              border.width: 2
                              radius: 200

                              Image {
                                  id: img2
                                  source: Qt.resolvedUrl("https://shop-api.keygenqt.com/api/uploads/" + v4o_1)
                                  fillMode: Image.PreserveAspectCrop
                                  anchors.centerIn: parent
                                  width: 50
                                  height: 50
                                  layer.enabled: true
                                  layer.effect: ColorOverlay{
                                      color: appTheme.colorVariant1
                                  }
                              }
                          }


                          Rectangle {
                              color: 'transparent'
                              height: iconData2.height
                              width: parent.width - iconRect.width - appTheme.paddingLarge
                              anchors.verticalCenter: parent.verticalCenter

                              Column {
                                  id: iconData2
                                  width: parent.width
                                  spacing: appTheme.paddingSmall
                                  anchors.top: parent.top
                                  anchors.topMargin: -3

                                  Text {
                                      width: parent.width
                                      text: t4o_1
                                      wrapMode: Text.WordWrap
                                      font.pixelSize: appTheme.fontSizeH6
                                  }

                                  Text {
                                      width: parent.width
                                      text: u4o_1
                                      wrapMode: Text.WordWrap
                                      font.pixelSize: appTheme.fontSizeCaption
                                  }
                              }
                          }
                      }
                  }
           }
        }
    }
}

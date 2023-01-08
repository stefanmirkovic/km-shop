import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components" as Components

Page {
    id: homePage

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height + appTheme.paddingLarge

        VerticalScrollDecorator {}

        PullDownMenu {
            id: pullDownMenu
            topMargin: appTheme.paddingLarge
            bottomMargin: appTheme.paddingLarge

            MenuItem {
                text: qsTr("Каталог")
                onClicked: pageStack.animatorReplace(Qt.resolvedUrl("CatalogPage.qml"), {}, PageStackAction.Replace)
            }
            MenuItem {
                text: qsTr("Корзина")
                onClicked: pageStack.animatorReplace(Qt.resolvedUrl("CartPage.qml"), {}, PageStackAction.Replace)
            }
        }

         Column {
             id: column
             width: parent.width

             PageHeader {
                 title: qsTr("Майшоп")
                 extraContent.children: [
                     Image {
                         source: Qt.resolvedUrl("../icons/toolbar_icon.png")
                         fillMode: Image.PreserveAspectFit
                         anchors.verticalCenter: parent.verticalCenter
                         width: 60
                         height: 60
                     }
                 ]
             }

             Column {
                 width: parent.width - appTheme.paddingLarge * 2
                 spacing: appTheme.paddingMedium
                 anchors.horizontalCenter: parent.horizontalCenter

                 Row {
                     id: iconButtons
                     width: parent.width
                     spacing: appTheme.paddingMedium
                     anchors.horizontalCenter: parent.horizontalCenter

                     Components.AppBlock {
                         width: parent.width / 2 - appTheme.paddingMedium / 2
                         backgroundColor: appTheme.colorVariant2
                         disabled: false

                         onClicked: pageStack.animatorPush(Qt.resolvedUrl("Contact.qml"), {}, PageStackAction.Animated)

                         Row {
                             spacing: appTheme.paddingMedium
                             anchors.horizontalCenter: parent.horizontalCenter

                             Image {
                                 source: "image://theme/icon-m-mail?white"
                                 fillMode: Image.PreserveAspectFit
                                 anchors.verticalCenter: parent.verticalCenter
                                 width: 47
                                 height: 47
                             }
                             Label {
                                 text: qsTr("Контакты")
                                 color: "white"
                                 font.pixelSize: appTheme.fontSizeH6
                             }
                         }
                     }

                     Components.AppBlock {
                         width: parent.width / 2 - appTheme.paddingMedium / 2
                         backgroundColor: appTheme.colorVariant2
                         disabled: false

                         onClicked: pageStack.animatorPush(Qt.resolvedUrl("OrderSearchPage.qml"), {}, PageStackAction.Animated)

                         Row {
                             spacing: appTheme.paddingMedium
                             anchors.horizontalCenter: parent.horizontalCenter

                             Image {
                                 source: "image://theme/icon-m-company?white"
                                 fillMode: Image.PreserveAspectFit
                                 anchors.verticalCenter: parent.verticalCenter
                                 width: 47
                                 height: 47
                             }
                             Label {
                                 text: qsTr("Заказы")
                                 color: "white"
                                 font.pixelSize: appTheme.fontSizeH6
                             }
                         }
                     }
                 }


                 Components.AppBlock {
                     width: parent.width
                     backgroundColor: appTheme.colorVariant1

                     Row {
                         width: parent.width
                         spacing: appTheme.paddingSmall

                         Column {
                             width: parent.width - 180
                             spacing: appTheme.paddingSmall

                             Label {
                                 text: qsTr("В этом сезоне найди лучшее 🔥")
                                 color: "white"
                                 bottomPadding: 4
                                 font.pixelSize: appTheme.fontSizeBody2
                             }

                             Column {
                                 width: parent.width
                                 spacing: appTheme.paddingLarge

                                 Text {
                                     width: parent.width
                                     text: qsTr("Коллекции для вашего стиля")
                                     color: "white"
                                     wrapMode: Text.WordWrap
                                     font.pixelSize: appTheme.fontSizeH4
                                 }

                                 Components.AppButton {
                                     text: qsTr("Начните поиск")
                                     onClicked: console.log("Click")
                                     padding: appTheme.paddingMedium
                                     background: 'black'
                                 }
                             }
                         }

                         Image {
                             source: Qt.resolvedUrl("../icons/girl.png")
                             fillMode: Image.PreserveAspectFit
                             anchors.verticalCenter: parent.verticalCenter
                             width: 180
                             height: 180
                             anchors.bottom: parent.bottom
                         }
                     }
                 }

                 Components.AppBlock {
                     id: contentBlock
                     width: parent.width
                     backgroundColor: appTheme.colorVariant3
                     Component.onCompleted: {
                         agent.run(
                             "kmm.Requests.get.categoriesPublished()",
                             function(result) {
                                 try {
                                     var list = JSON.parse(result)
                                     contentBlock.response = list
                                     for (var index = 0; index < list.length; index++) {
                                         list[index]['bg'] = index < 4 ? "../icons/cat_bg_" +(index + 1)+ ".svg" : "../icons/cat_bg_4.svg"
                                         categoryModel.append(list[index])
                                     }
                                 } catch (e) {
                                     contentBlock.error = error
                                 }
                             },
                             function(error) {
                                 contentBlock.error = error
                             }
                         )
                     }

                     property var response
                     property string error: ""

                     Components.BlockLoading {
                        visible: !contentBlock.response && !contentBlock.error
                     }

                     Components.BlockError {
                        error: contentBlock.error
                        visible: contentBlock.error !== ""
                     }

                     ListModel {
                         id: categoryModel
                     }

                     Column {
                         width: parent.width
                         spacing: appTheme.paddingLarge
                         visible: contentBlock.response !== undefined

                         Row {
                             width: parent.width
                             spacing: 0

                             Label {
                                 id: allLabel
                                 text: qsTr("Топ категорий")
                                 font.pixelSize: appTheme.fontSizeH5
                                 color: "white"
                             }

                             Rectangle {
                                 color: 'transparent'
                                 height: 1
                                 width: parent.width - allLabel.width - allButton.width
                             }

                             Components.AppButton {
                                 id: allButton
                                 text: qsTr("Все")
                                 onClicked: console.log("Click")
                                 padding: appTheme.paddingMedium
                             }
                         }

                         Repeater {
                               id: exampleRepeater
                               model: categoryModel
                               delegate: Components.AppBlock {
                                   width: parent.width
                                   backgroundColor: "white"
                                   bgSource: bg

                                   Label {
                                       text: d4o_1
                                       font.pixelSize: appTheme.fontSizeBody2
                                       bottomPadding: 5
                                   }

                                   Column {
                                       width: parent.width
                                       spacing: appTheme.paddingLarge

                                       Text {
                                           width: parent.width
                                           text: e4o_1
                                           wrapMode: Text.WordWrap
                                           font.pointSize: appTheme.fontSizeBody1
                                       }

                                       Components.AppButton {
                                           text: qsTr("Смотреть")
                                           icon: "image://theme/icon-m-enter-next"
                                           onClicked: console.log("Click")
                                           padding: appTheme.paddingMedium
                                       }
                                   }
                               }
                           }
                     }
                 }
             }
         }
    }
}

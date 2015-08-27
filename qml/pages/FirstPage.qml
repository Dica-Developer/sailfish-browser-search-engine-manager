 /*
  Copyright (C) 2015 Dica-Developer.
  Contact: team@dica-developer.org
  All rights reserved.

  This file is part of sailfish-browser-search-engine-manager.

  sailfish-browser-search-engine-manager is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  sailfish-browser-search-engine-manager is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with sailfish-browser-search-engine-manager.  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import dicadevelopers.utils.Files 1.0
import "../js/searchEngines.js" as SearchEngines

Page {
    // This declaration is necessary for usage of files in searchEngines.js
    Files {
        id: files
    }

    id: page

    SilicaFlickable {
        anchors.fill: parent

        PullDownMenu {
            MenuItem {
                text: qsTr("Add search engine")
                onClicked: pageStack.push(Qt.resolvedUrl("SecondPage.qml"))
            }
        }

        InteractionHintLabel {
            id: noSearchEngines
            anchors.fill: parent
            text: qsTr("You do not have any custom search engines defined. Pulldown to add a new custom search engine")
            visible: searchEngineModel.count === 0
            onVisibleChanged: {
                if (visible) {
                    touchInteractionHint.start()
                } else {
                    touchInteractionHint.stop()
                }
            }
        }


        TouchInteractionHint {
            id: touchInteractionHint
            direction: TouchInteraction.Down
            anchors.horizontalCenter: parent.horizontalCenter
        }

        SilicaListView {
            id: searchEngineList
            anchors.fill: parent
            model: searchEngineModel

            header: PageHeader {
                title: qsTr("Your custom search engines")
            }

            VerticalScrollDecorator {}

            Component.onCompleted: {
                var foundSearchEngines = SearchEngines.readAll();
                for (var i = 0; i < foundSearchEngines.length; i++) {
                    searchEngineModel.append(foundSearchEngines[i])
                }
            }

            delegate: ListItem {
                id: searchEngineListItem

                function remove() {
                    remorseAction(qsTr("Deleting"), function() {
                        if (SearchEngines.deleteSearchEngine(name)) {
                            searchEngineModel.remove(index)
                        } else {
                            // TODO maybe an error message
                        }
                    })
                }

                menu: ContextMenu {
                    MenuItem {
                        text: qsTr("Edit")
                        onClicked: {
                            pageStack.push(Qt.resolvedUrl("SecondPage.qml"), { searchEngineNameText: name, searchEngineUrlText: url, isEdit: true, modelIndex: index })
                        }
                    }
                    MenuItem {
                        text: qsTr("Delete")
                        onClicked: {
                            remove()
                        }
                    }
                }
                Label {
                    x: Theme.horizontalPageMargin
                    id: nameLabel
                    text: name
                    font.pixelSize: Theme.fontSizeMedium
                    truncationMode: TruncationMode.Fade
                    width: parent.width - 2*Theme.horizontalPageMargin
                    maximumLineCount: 1
                }
                Label {
                    x: Theme.horizontalPageMargin
                    anchors {
                        top: nameLabel.bottom
                    }
                    font.pixelSize: Theme.fontSizeExtraSmall
                    truncationMode: TruncationMode.Fade
                    width: parent.width - 2*Theme.horizontalPageMargin
                    maximumLineCount: 1
                    text: url
                }
            }
        }
    }
}

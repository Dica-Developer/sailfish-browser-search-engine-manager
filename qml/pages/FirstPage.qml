 /*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
                            pageStack.push(Qt.resolvedUrl("SecondPage.qml"), {"searchEngineName.text": name, "searchEngineUrl.text": url})
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

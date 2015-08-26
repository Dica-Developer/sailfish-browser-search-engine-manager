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

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height + Theme.paddingLarge

        VerticalScrollDecorator {}

        Column {
            id: column
            anchors {
                left: parent.left;
                right: parent.right
            }
            spacing: Theme.paddingLarge

            PageHeader {
                title: qsTr("Search engine properties")
            }

            TextField {
                id: searchEngineName
                errorHighlight: null === text.match('^[a-zA-Z0-9_\-]+$')
                validator: RegExpValidator {
                    regExp: /^[a-zA-Z0-9_\-]+$/
                }
                anchors {
                    left: parent.left;
                    right: parent.right
                }
                focus: true;
                label: qsTr("Name");
                placeholderText: label
                EnterKey.enabled: text || inputMethodComposing
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: {
                    if (errorHighlight) {
                        searchEngineName.focus = true
                    } else {
                        searchEngineUrl.focus = true
                    }
                }
            }

            TextField {
                id: searchEngineUrl
                anchors {
                    left: parent.left;
                    right: parent.right
                }
                label: qsTr("Url");
                errorHighlight: text.trim() === ''
                placeholderText: qsTr("Url with search place holder e.g. https://duckduckgo.com/?q={searchTerms}")
                EnterKey.enabled: text || inputMethodComposing
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: {
                    if (errorHighlight) {
                        searchEngineUrl.focus = true
                    } else {
                        if (SearchEngines.saveSearchEngine(searchEngineName.text, searchEngineUrl.text)) {
                            searchEngineModel.append({"name": searchEngineName.text, "url": searchEngineUrl.text})
                            pageStack.pop()
                        } else {
                            searchEngineName.focus = true
                        }
                    }
                }
            }
        }
    }
}

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
    property string searchEngineNameText
    property string searchEngineUrlText
    property bool isEdit: false
    property int modelIndex;

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
                text: searchEngineNameText
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
                text: searchEngineUrlText
                id: searchEngineUrl
                anchors {
                    left: parent.left;
                    right: parent.right
                }
                errorHighlight: null === text.match('^(http:\/\/|https:\/\/).+$')
                validator: RegExpValidator {
                    regExp: /^(http:\/\/|https:\/\/).+$/
                }
                label: qsTr("Url");
                placeholderText: qsTr("Url with search place holder e.g. https://duckduckgo.com/?q={searchTerms}")
                EnterKey.enabled: text || inputMethodComposing
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: {
                    if (errorHighlight) {
                        searchEngineUrl.focus = true
                    } else {
                        if (isEdit) {
                            SearchEngines.deleteSearchEngine(searchEngineNameText)
                            searchEngineModel.remove(modelIndex)
                        }
                        var textValue = searchEngineName.text.trim()
                        var urlValue = searchEngineUrl.text.trim()
                        if (SearchEngines.saveSearchEngine(textValue, urlValue)) {
                            searchEngineModel.append({"name": textValue, "url": urlValue})
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

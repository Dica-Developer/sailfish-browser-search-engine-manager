// sailfish-browser supports this with starting from version 1.2.39
var SEARCH_ENGINE_USER_PATH = '/home/nemo/.local/share/org.sailfishos/sailfish-browser/searchEngines';
var DEFAULT_SEARCH_ENGINE_URL = '<OpenSearchDescription xmlns="http://a9.com/-/spec/opensearch/1.1/"><ShortName>%shortName%</ShortName><Description></Description>' +
        '<InputEncoding>UTF-8</InputEncoding><LongName></LongName><Url type="text/html" method="get" template="%urlTemplate%"/>' +
        '</OpenSearchDescription>"';

function readAll() {
    var result = [];
    if (files.exists(SEARCH_ENGINE_USER_PATH)) {
        var foundFiles = files.find(SEARCH_ENGINE_USER_PATH, '*.xml');
        for (var i = 0; i < foundFiles.length; i++) {
            var content = files.read(SEARCH_ENGINE_USER_PATH + '/' + foundFiles[i]);
            result.push({"name": content.match('<ShortName>(.+?)</ShortName>')[1], "url": content.match('template="(.+?)"')[1]});
        }
    }
    return result;
}

function saveSearchEngine(name, url) {
    var searchEngineXml = DEFAULT_SEARCH_ENGINE_URL.replace('%shortName%', name);
    searchEngineXml = searchEngineXml.replace('%urlTemplate%', url);
    if (!files.exists(SEARCH_ENGINE_USER_PATH)) {
        files.mkPath(SEARCH_ENGINE_USER_PATH);
    }
    var fileNameForSearchEngine = SEARCH_ENGINE_USER_PATH + '/' + name + '.xml';
    return files.save(searchEngineXml, fileNameForSearchEngine);
}

function deleteSearchEngine(name) {
    var result = false;
    var fileNameToDelete = SEARCH_ENGINE_USER_PATH + '/' + name + '.xml';
    if (files.exists(fileNameToDelete)) {
        result = files.unlink(fileNameToDelete);
    } else {
        result = true;
    }

    return result;
}

sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'com.equinor.ca.customcomponentsimport',
            componentId: 'ExternalComponentsObjectPage',
            contextPath: '/ExternalComponents'
        },
        CustomPageDefinitions
    );
});
sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'com.equinor.ca.customsolutions',
            componentId: 'SolutionsObjectPage',
            contextPath: '/Solutions'
        },
        CustomPageDefinitions
    );
});
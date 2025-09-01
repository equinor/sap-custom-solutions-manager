sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'com/equinor/ca/customcomponents/test/integration/FirstJourney',
        'com/equinor/ca/customcomponents/test/integration/pages/ComponentsList',
        'com/equinor/ca/customcomponents/test/integration/pages/ComponentsObjectPage'
    ],
    function(JourneyRunner, opaJourney, ComponentsList, ComponentsObjectPage) {
        'use strict';

        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('com/equinor/ca/customcomponents') + '/index.html'
        });

        JourneyRunner.run(
            {
                pages: { 
                    onTheComponentsList: ComponentsList,
                    onTheComponentsObjectPage: ComponentsObjectPage
                }
            },
            opaJourney.run
        );
    }
);
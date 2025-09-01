sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'com/equinor/ca/customcomponentsimport/test/integration/FirstJourney',
		'com/equinor/ca/customcomponentsimport/test/integration/pages/ExternalComponentsList',
		'com/equinor/ca/customcomponentsimport/test/integration/pages/ExternalComponentsObjectPage'
    ],
    function(JourneyRunner, opaJourney, ExternalComponentsList, ExternalComponentsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('com/equinor/ca/customcomponentsimport') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheExternalComponentsList: ExternalComponentsList,
					onTheExternalComponentsObjectPage: ExternalComponentsObjectPage
                }
            },
            opaJourney.run
        );
    }
);
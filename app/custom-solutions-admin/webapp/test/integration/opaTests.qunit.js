sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'com/equinor/ca/customsolutionsadmin/test/integration/FirstJourney',
		'com/equinor/ca/customsolutionsadmin/test/integration/pages/ResourceTypeCodeListMain'
    ],
    function(JourneyRunner, opaJourney, ResourceTypeCodeListMain) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('com/equinor/ca/customsolutionsadmin') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheResourceTypeCodeListMain: ResourceTypeCodeListMain
                }
            },
            opaJourney.run
        );
    }
);
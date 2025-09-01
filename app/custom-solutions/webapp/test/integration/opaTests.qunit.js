sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'com/equinor/ca/customsolutions/test/integration/FirstJourney',
		'com/equinor/ca/customsolutions/test/integration/pages/SolutionsList',
		'com/equinor/ca/customsolutions/test/integration/pages/SolutionsObjectPage'
    ],
    function(JourneyRunner, opaJourney, SolutionsList, SolutionsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('com/equinor/ca/customsolutions') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheSolutionsList: SolutionsList,
					onTheSolutionsObjectPage: SolutionsObjectPage
                }
            },
            opaJourney.run
        );
    }
);
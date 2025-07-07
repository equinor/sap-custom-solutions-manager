sap.ui.define([
    "sap/ui/test/opaQunit"
], function (opaTest) {
    "use strict";

    var Journey = {
        run: function() {

            // Set the global timeout for OPA tests to 2 seconds (2000 milliseconds)
            QUnit.config.testTimeout = 10000;

            QUnit.module("First journey");
   

            opaTest("Start application", function (Given, When, Then) {
                Given.iStartMyApp();
                Then.onTheComponentsList.iSeeThisPage();
            });

            opaTest("Navigate to ObjectPage", function (Given, When, Then) {
                // Note: this test will fail if the ListReport page doesn't show any data
                Then.onTheComponentsList.onTable().iCheckRows();
                When.onTheComponentsList.onTable().iPressRow(0);
                Then.onTheComponentsObjectPage.iSeeThisPage();
            });

            opaTest("Click 'Add rating' button and check that dialog appears", function (Given, When, Then) {
                // Ensure the ObjectPage is loaded
                Then.onTheComponentsObjectPage.iSeeThisPage();
                // Simulate clicking the "Add" button
                When.onTheComponentsObjectPage.iPressAddButton();
                // Check that the dialog appears
                Then.onTheComponentsObjectPage.iSeeRatingDialog();
            });


            opaTest("Give rating and close rating dialog", function (Given, When, Then) {
                When.onTheComponentsObjectPage.iGiveRating(5);
                When.onTheComponentsObjectPage.iGiveRatingComment("Rating comment");
                Then.onTheComponentsObjectPage.ratingIsSetTo(5);
            });

            opaTest("Close the rating dialog", function (Given, When, Then) {
                When.onTheComponentsObjectPage.iCloseRatingDialog();
                Then.onTheComponentsObjectPage.iSeeRatings();
            });



            opaTest("Teardown", function (Given, When, Then) { 
                // Cleanup
                Given.iTearDownMyApp();
            });
        }
    }

    return Journey;
});
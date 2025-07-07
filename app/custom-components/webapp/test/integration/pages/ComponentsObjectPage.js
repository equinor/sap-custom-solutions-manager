sap.ui.define(
  ["sap/fe/test/ObjectPage", "sap/ui/test/actions/Press", "sap/ui/test/Opa5"],
  function (ObjectPage, Press, Opa5) {
    "use strict";

    var CustomPageDefinitions = {
      actions: {
        iPressAddButton: function () {
          return this.waitFor({
            id: "com.equinor.ca.customcomponents::ComponentsObjectPage--fe::CustomAction::Add",
            actions: new Press(),
            errorMessage: "Could not find the 'Add' button.",
          });
        },
        iGiveRating: function (rating) {
          return this.waitFor({
            controlType: "sap.m.RatingIndicator",
            actions: function (oRatingIndicator) {
              oRatingIndicator.setValue(rating);
            },
            errorMessage: "Could not find the rating indicator.",
          });
        },
        iGiveRatingComment: function (comment) {
          return this.waitFor({
            controlType: "sap.m.TextArea",
            actions: function (textArea) {
              textArea.setValue(comment);
            },
            errorMessage: "Could not find the rating indicator.",
          });
        },
        iCloseRatingDialog: function () {
          return this.waitFor({
            controlType: "sap.m.Button",
            matchers: new sap.ui.test.matchers.PropertyStrictEquals({
              name: "text",
              value: "Save",
            }),
            actions: new Press(),
            errorMessage: "Could not find the 'Close' button.",
          });
        },
      },
      assertions: {
        iSeeRatingDialog: function () {
          return this.waitFor({
            controlType: "sap.m.Dialog", //Using controlType to find the dialog since using ID was not working
            matchers: new sap.ui.test.matchers.PropertyStrictEquals({
              //Look for a dialog with the title "Rate package"
              name: "title",
              value: "Rate package",
            }),
            success: function () {
              Opa5.assert.ok(true, "The rating dialog is visible.");
            },
            errorMessage: "The rating dialog did not appear.",
          });
        },
        ratingIsSetTo: function (rating) {
          return this.waitFor({
            controlType: "sap.m.RatingIndicator",
            matchers: new sap.ui.test.matchers.PropertyStrictEquals({
              name: "value",
              value: rating,
            }),
            success: function () {
              Opa5.assert.ok(true, "The rating is set to " + rating);
            },
            errorMessage: "The rating is not set to " + rating,
          });
        },
        iSeeRatings: function () {
          return this.waitFor({
            controlType: "sap.m.Table",
            matchers: new sap.ui.test.matchers.AggregationFilled({
              name: "items",
            }),
            success: function () {
              Opa5.assert.ok(true, "Ratings are visible.");
            },
            errorMessage: "Ratings are not visible.",
          });
        },
      },
    };

    return new ObjectPage(
      {
        appId: "com.equinor.ca.customcomponents",
        componentId: "ComponentsObjectPage",
        contextPath: "/Components",
      },
      CustomPageDefinitions
    );
  }
);

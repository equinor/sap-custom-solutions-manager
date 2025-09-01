sap.ui.define(
    [
        'sap/fe/core/PageController'
    ],
    function(PageController) {
        'use strict';

        return PageController.extend('com.equinor.ca.customsolutionsadmin.ext.main.Main', {
            
            edit: function(oEvent) {
                let mode = oEvent.getParameter("state");;
                this.getView().getModel("ui").setProperty("/isEditable", mode);

            },
            /**
             * Called when a controller is instantiated and its View controls (if available) are already created.
             * Can be used to modify the View before it is displayed, to bind event handlers and do other one-time initialization.
             * @memberOf com.equinor.ca.customsolutionsadmin.ext.main.Main
             */
             onInit: function () {
                 PageController.prototype.onInit.apply(this, arguments); // needs to be called to properly initialize the page controller
             },

            /**
             * Similar to onAfterRendering, but this hook is invoked before the controller's View is re-rendered
             * (NOT before the first rendering! onInit() is used for that one!).
             * @memberOf com.equinor.ca.customsolutionsadmin.ext.main.Main
             */
            //  onBeforeRendering: function() {
            //
            //  },

            /**
             * Called when the View has been rendered (so its HTML is part of the document). Post-rendering manipulations of the HTML could be done here.
             * This hook is the same one that SAPUI5 controls get after being rendered.
             * @memberOf com.equinor.ca.customsolutionsadmin.ext.main.Main
             */
            //  onAfterRendering: function() {
                // this.getModel("ui").setProperty("/isEditable", true);
            //  },

            /**
             * Called when the Controller is destroyed. Use this one to free resources and finalize activities.
             * @memberOf com.equinor.ca.customsolutionsadmin.ext.main.Main
             */
            //  onExit: function() {
            //
            //  }

			// editFlow: {
			// 	onBeforeEdit: function (mParameters) {
			// 		//synchronous access to property value
			// 		if (mParameters?.context.getProperty("DialogProperty")) {
			// 			return this.openDialog("Do you want to edit this really nice... object ?", true);
			// 		}
			// 	},
			// 	onAfterEdit: function (mParameters) {
			// 		//synchronous access to complete data the context points to
			// 		return MessageToast.show(
			// 			"Edit successful. Number of data entries in context: " + Object.entries(mParameters.context.getObject()).length
			// 		);
			// 	},
			// 	onBeforeSave: function (mParameters) {
			// 		//asynchronous access to several property values. Non cached values are requested from the backend
			// 		return mParameters?.context.requestProperty(["DialogProperty", "UIHiddenProperty"]).then((result) => {
			// 			return result[0] ? this.openDialog(result[1], true) : null;
			// 		});
			// 	},
			// 	onAfterSave: function (mParameters) {
			// 		//
			// 		mParameters.context.refresh();
			// 		//asynchronous access to complete data the context points to
			// 		mParameters.context.requestObject().then((contextData) => {
			// 			return MessageToast.show(
			// 				"Save successful. Number of data entries in context: " + Object.entries(contextData).length
			// 			);
			// 		});
			// 	},
			// 	onBeforeDiscard: function (mParameters) {
			// 		if (mParameters?.context.getProperty("DialogProperty")) {
			// 			return this.openDialog("Are you sure you want to discard this draft?");
			// 		}
			// 	}
			// }
        });
    }
);

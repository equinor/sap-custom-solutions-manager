sap.ui.define([
    "sap/m/MessageToast",
    "sap/m/MessageBox"
], function(MessageToast, MessageBox) {
    'use strict';

    return {

        /**
         * Post the text from the feed input
         */
        onPost: function(oEvent) {

            // Get the text input value
			var sValue = oEvent.getParameter("value");
			
            // Create new entry
            let oList = this.byId("commentFeedList");
            let oBinding = oList.getBinding("items");
            let oContext = oBinding.create({
                        "commentText": sValue
                    });
            
            // Display post confirmation
            oContext.created().then(function (){
                MessageToast.show("Comment was saved");
            });
            
            
        },

        /**
         * Delete selected item
         */
        onDeletePressed: function(oEvent) {

            let oFeedListItem = oEvent.getParameter("item");

            oFeedListItem.getBindingContext().delete().then(
                function() {
                    MessageToast.show("Comment was deleted"); 
                }),

                function(oError){
                    let message = "An error occured when deleting the comment" + ( oError.error.message ? " - " + oError.error.message: "" );
                    MessageBox.error(message, {details: oError});
                }; 
        }
    };
});

sap.ui.define([
    "sap/ui/model/json/JSONModel",
    "sap/m/MessageToast",
    "sap/m/MessageBox",
    "sap/m/Dialog",
    "sap/m/library",
    "sap/m/Button",
    "sap/m/Text"
], function(JSONModel, MessageToast, MessageBox, Dialog, mobileLibrary, Button, Text) {
    'use strict';

    return {
        formatRatingType: function(ratingType) {
            switch (ratingType) {
                case 0:
                    return "Clean Core";
                case 1:
                    return "Code Quality";
                default:
                    return "Unknown";
            }

        
        },
        ratePackage: function(binding, bindingsContexts) {

            let ratingModel = new JSONModel({
                codeQualityRating: "0.00",
                codeQualityComment: "",
                cleanCoreRating: "0.00",
                cleanCoreComment: ""
            }); 

            let handler = {
                bindingContext: this.getRouting().getView().getBindingContext(),
                _saveRating: function(type, rating, comment, dialog) {
        
                    let context = this.listBinding.create({
                                                        "ratingType_code": type,
                                                        "rating": parseInt(rating),
                                                        "comment": comment
                                                    });
        
                    context.created().then(
                        function () {
                            MessageToast.show("Rating was saved"); 
                            //Update view so that rating in header is updated
                            this.bindingContext.refresh();
                            dialog.close();
                        }.bind(this), 
                        function (oError) {
                            let message = "An error occured when saving the rating" + ( oError.error.message ? " - " + oError.error.message: "" );
                            MessageBox.error(message, {details: oError});
                    }.bind(this));
        
                },
                saveRatings: function(oEvent) {
    
                    const CLEAN_CORE_RATING = 0; 
                    const CODE_QUALITY_RATING = 1; 
                    
                    this.ratingDialog.then(function(oDialog){
                        let rating = oDialog.getModel("ratingModel").getData();
                        this._saveRating(CLEAN_CORE_RATING, rating.cleanCoreRating.toString(), rating.cleanCoreComment, oDialog);
                        this._saveRating(CODE_QUALITY_RATING, rating.codeQualityRating.toString(), rating.codeQualityComment, oDialog);
                    }.bind(this));
                },
                closeRatingDialog: function() {
                    this.ratingDialog.then(function(oDialog){
                        oDialog.close();
                    }.bind(this));                                
                }               
            };
            
            handler.listBinding = this.byId("com.equinor.ca.customcomponents::ComponentsObjectPage--fe::CustomSubSection::RatingsFeed--ratingsTable").getBinding("items");

            if (!this.ratingDialog) {
                this.ratingDialog = this.loadFragment({
                    id: "ratingDialog",
                    name: "com.equinor.ca.customcomponents.ext.fragment.Rating",
                    controller: handler,
                    // containingView: 
                }).then(function (oDialog){     
                    oDialog.setModel(ratingModel, "ratingModel");
                    return oDialog;
                });
                handler.ratingDialog = this.ratingDialog;
            }

            this.ratingDialog.then(function(oDialog){
                oDialog.setModel(ratingModel, "ratingModel");
                oDialog.open();
            });
        },
        deleteRating: function(binding) {
            let ButtonType = mobileLibrary.ButtonType;
            let DialogType = mobileLibrary.DialogType;
            
            this.oApproveDialog = new Dialog({
                type: DialogType.Message,
                title: "Confirm",
                content: new Text({ text: "Are you sure you want to delete the selected rating(s)?" }),
                beginButton: new Button({
                    type: ButtonType.Reject,
                    text: "Delete",
                    press: function () {
                        binding.getParameter("listItem").getBindingContext().delete().then(
                            function() {
                                MessageToast.show("Rating was deleted"); 
                                //Update view binding and table list binding
                                this.getBindingContext().refresh(); 
                            }.bind(this),
                            function(oError) {
                                let message = "An error occured when deleting the rating" + ( oError.error.message ? " - " + oError.error.message: "" );
                                MessageBox.error(message, {details: oError});
                            }
                        );  
               
                        this.oApproveDialog.close();
                    }.bind(this)
                }),
                endButton: new Button({
                    text: "Cancel",
                    press: function () {
                        this.oApproveDialog.close();
                    }.bind(this)
                })
            });

            this.oApproveDialog.open();
        }
    };
});

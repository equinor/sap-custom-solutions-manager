sap.ui.define([
  "sap/m/MessageToast",
  "sap/m/MessageBox",
], function(MessageToast, MessageBox) {
  'use strict';
  
  // Shared variable moved to the module scope
  var _oDevSystemDialog;
  
  function createADTFragmentController(abapPackage, oContext) {
      return {
          onCancel: function(oEvent) {
            _oDevSystemDialog.close();
          },
          onSelect: function(oEvent) {
              let system = oEvent.getSource().getBindingContext().getObject().code;
              let adtUrl =  `adt://${system}/sap/bc/adt/packages/${abapPackage}`;
              _oDevSystemDialog.close();
              window.open(adtUrl, "_blank");
          }
      };
  }

  return {
      importComponents: function(oEvent) {
          let refreshAction = this.getModel().bindContext("/directImport(...)");

          sap.m.MessageBox.confirm("Are you sure you want to update with components from external systems?", {
          actions: [sap.m.MessageBox.Action.OK, sap.m.MessageBox.Action.CANCEL],
            onClose: function (sAction) {
              if (sAction === sap.m.MessageBox.Action.OK) {
                this.getEditFlow().getView().setBusy(true);
                MessageToast.show("Pulling components from external APIs...");
                refreshAction
                  .execute()
                  .then(
                    function () {
                      MessageToast.show("Components were imported successfully.");
                      this.getModel().refresh();
                    }.bind(this)
                  )
                  .catch(function (oError) {
                    MessageBox.error("An error occurred while importing components: " + oError.message, {
                        title: "Error",
                        details: oError.stack || oError.message,
                    });
                  })
                  .finally(
                    function () {
                      this.getEditFlow().getView().setBusy(false);
                    }.bind(this)
                  );
              } else {
                this.getEditFlow().getView().setBusy(false);
              }
            }.bind(this),
          });

      },
      
      openInEclipse: function() {
          let abapPackage = this.getBindingContext().getObject().name;
          let controller = createADTFragmentController(abapPackage, this);
          
          if (!_oDevSystemDialog) {
              this.loadFragment({
                  name: "com.equinor.ca.customcomponents.ext.fragment.SAPDevSystemDialog",
                  controller: controller                    
              }).then(function(oDialog) {
                  _oDevSystemDialog = oDialog;
                  oDialog.open();
              }.bind(this));
          } else {
              _oDevSystemDialog.open();
          }
      }
  };
});
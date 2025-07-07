sap.ui.define([
    "sap/m/MessageToast",
    "sap/m/MessageBox"
], 
function (MessageToast, MessageBox) {
  "use strict";

  return {
    // Pull components from external APIs
    // This function is called when the user clicks the "Pull Components" button
    pullComponents: function (oEvent) {
      let pullAction = this.getModel().bindContext("/pullComponents(...)");

      sap.m.MessageBox.confirm("Are you sure you want to pull components?", {
        actions: [sap.m.MessageBox.Action.OK, sap.m.MessageBox.Action.CANCEL],
        onClose: function (sAction) {
          if (sAction === sap.m.MessageBox.Action.OK) {
            this.getEditFlow().getView().setBusy(true);
            MessageToast.show("Pulling components from external APIs...");
            pullAction
              .execute()
              .then(
                function () {
                  MessageToast.show("Components were pulled successfully.");
                  this.getModel().refresh();
                }.bind(this)
              )
              .catch(function (oError) {
                MessageBox.error("An error occurred while pulling components: " + oError.message, {
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


    // Import components from the selected contexts
    // This function is called when the user clicks the "Import" button on the table
    importComponents: function (par) {
      let selectedComponents = this.getSelectedContexts();
      let componentsArray = selectedComponents.map(function (context) {
        return context.getProperty("ID");
      });
      let importAction = this.getModel().bindContext("/importComponents(...)");

      importAction.setParameter("componentIds", componentsArray);

      sap.m.MessageBox.confirm(
        "Are you sure you want to import the selected components?",
        {
          actions: [sap.m.MessageBox.Action.OK, sap.m.MessageBox.Action.CANCEL],
          onClose: function (sAction) {
            if (sAction === sap.m.MessageBox.Action.OK) {
              importAction
                .invoke()
                .then(
                  function () {
                    MessageToast.show("Components were imported successfully.");
                    this.getModel().refresh();
                  }.bind(this)
                )
                .catch(function (oError) {
                  MessageToast.show("Error: " + oError.message);
                });
            }
          }.bind(this),
        }
      );
    },
  };
});

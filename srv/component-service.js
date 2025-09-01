const cds = require("@sap/cds");
const constants = require("./model/constants");
const ABAPPackage = require("./model/ABAPPackage");
const fs = require("fs");
const path = require("path");
const LOG = cds.log("custom-components-service");

class ComponentsService extends cds.ApplicationService {
  async init() {
    LOG.info("Starting service initialization...");
    const {
      Components,
      Solutions,
      SolutionResources,
      Ratings,
      ComponentComments,
      ExternalComponents,
    } = this.entities;

    // Connect to external services
    const ABAPPackagesService = await cds.connect.to(
      constants.ABAP_PACKAGES_ONPREM_PROD_SERVICE_NAME
    );

    // If you have more services, add them to this array
    const abapServices = [ABAPPackagesService];

    // Initialize APIs with services
    const apis = [
      new ABAPPackage(abapServices),
      //,new SystemTwoAPI(systemTwo)
    ];

    // ACTION: Pull components from the external APIs into the staging area for the import app 
    this.on("pullComponents", async (req) => {
      const importedComponents = [];

      await DELETE.from(ExternalComponents);
      console.log("Deleted all records from ExternalComponents");

      for (const api of apis) {
        try {
          const components = await api.fetchComponents();

          for (const component of components) {
            const existing = await this.findExistingComponent(component);

            if (existing) {
              component.importStatus_code = "IMPORTED";
            } else {
              component.importStatus_code = "NEW";
            }
            await INSERT.into(ExternalComponents).entries(component);
            importedComponents.push(component);
          }
        } catch (error) {
          console.error(
            `Error processing components from ${api.constructor.name} --- ${error}`
          );
         return req.reject(500, `Error processing components from ${api.constructor.name} --- ${error}`);
        }
      }

      return importedComponents;
    });

    // ACTION: Import components from external APIs directly into Components table
    this.on("directImport", async (req) => {
      console.log("Direct import action");


      let mergedComponents = [];
      for (const api of apis) {
        try {
          const components = await api.fetchComponents();

          for (const component of components) {
            const existing = await this.findExistingComponent(component);

            if (existing) {
              delete component.ID; //Delete the ID to avoid updating it
              await UPDATE(Components).set(component).where({ ID: existing.ID });
              mergedComponents.push({ ...existing, ...component });
            } else {
              component.ID = cds.utils.uuid();
              await INSERT.into(Components).entries(component);
              mergedComponents.push(component);
            }
          }
        } catch (error) {
          console.error(
            `Error processing components from ${api.constructor.name} --- ${error}`
          );
         return req.reject(500, `Error processing components from ${api.constructor.name} --- ${error}`);
        }
      }

      return mergedComponents;
    });

    

    // ACTION: Import components ExternalComponents staging area into Components table
    this.on("importComponents", async (req) => {
      console.log("Import components action");
      let componentIds = req.data.componentIds;
      const externalComponents = await SELECT.from(ExternalComponents).where({
        ID: componentIds,
      });

      let component = {};
      let mergedComponents = [];
      // Loop through each external component and create a new component
      for (const externalComponent of externalComponents) {
        let externalComponentId = externalComponent.ID;

        switch (externalComponent.componentTypeCode) {
          case constants.COMPONENT_TYPES.ABAP:
            component = new ABAPPackage();
            break;
          case constants.COMPONENT_TYPES.CAP:
            //TODO: Implement CAP component type
            break;
          case constants.COMPONENT_TYPES.UI5:
            //TODO : Implement UI5 component type
            break;
          default:
            throw new Error("Unsupported component type");
        }

        //Copy data from externalCOmponent to component
        Object.assign(component, externalComponent);

        //Insert new components and update existing components
        const existing = await this.findExistingComponent(component);

        if (existing) {
          delete component.ID; //Delete the ID to avoid updating it
          await UPDATE(Components).set(component).where({ ID: existing.ID });
          mergedComponents.push({ ...existing, ...component });
        } else {
          component.ID = cds.utils.uuid();
          await INSERT.into(Components).entries(component);
          mergedComponents.push(component);
        }
        await UPDATE(ExternalComponents).set({importStatus_code: "IMPORTED"}).where({ID: externalComponentId});
      }
      return mergedComponents;
    });

    // READ on-premise ABAP packages
    this.on(
      "READ",
      constants.ABAP_PACKAGES_ONPREM_ENTITY,
      async function (req) {
        console.log("READ operation");
        const externalService = await cds.connect.to(
          constants.ABAP_PACKAGES_ONPREM_PROD_SERVICE_NAME
        );
        return externalService.run(req.query);
      }
    );

    // ACTION : Assign component to a solution
    this.on("Assign", async function (req) {
      console.log("ASSIGN action");
      const componentID = req.params[0];
      const solutionID = req.data.solutionID;

      // Update the component to assign it to a solution
      const updateQuery = UPDATE(constants.COMPONENTS_ENTITY)
        .set({ solution_ID: solutionID })
        .where({ ID: componentID });

      await this.run(updateQuery);
      console.log(
        `Component ${componentID} assigned to solution ${solutionID}`
      );

      // Return a success code
      return {
        status: "success",
        message: `Component ${componentID} assigned to solution ${solutionID}.`,
      };
    });

    this.on("assignComponent", async function(req) {
        const solutionID = req.params[0].ID;
        const componentIDs = req.data.components;

            const updateQuery = UPDATE(constants.COMPONENTS_ENTITY)
                .set({ solution_ID: solutionID })
                .where({ ID: { in: componentIDs } });

            await this.run(updateQuery);
            console.log(`Components ${componentIDs.join(', ')} assigned to solution ${solutionID}`);

            return {
                status: 'success',
                message: `${componentIDs.length} components assigned to solution ${solutionID}.`
            };
       
    });

    // ACTION: Unassign component from a solution
    this.on("Unassign", async function (req) {
      console.log("UNASSIGN action");

      const componentID = req.params[0];

      // Update the component to unassign it from a solution
      const updateQuery = UPDATE(constants.COMPONENTS_ENTITY)
        .set({ solution_ID: null })
        .where({ ID: componentID });

      await this.run(updateQuery);
      console.log(`Component ${componentID} unassigned from solution.`);

      // Return a success code
      return {
        status: "success",
        message: `Component ${componentID} unassigned from solution.`,
      };
    });



    // READ: Handlers for virtual rating fields
    this.after('READ', Components, async (components) => {
      const items = Array.isArray(components) ? components : [components];
      
      for (const component of items) {
        // Get latest Clean Core rating
        const [latestCleanCore] = await SELECT
          .from(Ratings)
          .where({ 
            component_ID: component.ID,
            ratingType_code: constants.RATING_TYPES.CLEAN_CORE_RATING 
          })
          .orderBy({ createdAt: 'desc' })
          .limit(1);
          
        // Get latest Code Quality rating
        const [latestCodeQuality] = await SELECT
          .from(Ratings)
          .where({ 
            component_ID: component.ID,
            ratingType_code: constants.RATING_TYPES.CODE_QUALITY_RATING 
          })
          .orderBy({ createdAt: 'desc' })
          .limit(1);
          
        component.latestCleanCoreRating = latestCleanCore?.rating ?? null;
        component.latestCodeQualityRating = latestCodeQuality?.rating ?? null;
      }
    });

    // CREATE: Update the Components table when a new rating is created
    this.after('CREATE', 'Ratings', async (rating) => {
      const component = await SELECT.one.from(Components)
        .where({ ID: rating.component_ID });
      
      if (component) {
        // Update only the relevant rating field based on type
        const updateData = {};
        if (rating.ratingType_code === constants.RATING_TYPES.CLEAN_CORE_RATING) {
          updateData.latestCleanCoreRating = rating.rating;
        } else if (rating.ratingType_code === constants.RATING_TYPES.CODE_QUALITY_RATING) {
          updateData.latestCodeQualityRating = rating.rating;
        }

        if (Object.keys(updateData).length > 0) {
          await UPDATE(Components)
            .where({ ID: component.ID })
            .with(updateData);
        }
      }
    });

    // ACTION: Import test data from db/data/test folder
    this.on("importTestData", async (req) => {
      const testDataDir = path.join(__dirname, "../db/data/test");
      let imported = 0;
      let failed = [];
      try {
        const files = fs.readdirSync(testDataDir).filter(f => f.endsWith('.csv'));
        for (const file of files) {
          const entityName = file.split("-")[1].replace(".csv", "");
          const entity = this.entities[entityName];
          if (!entity) {
            failed.push(file + ': unknown entity');
            continue;
          }
          const filePath = path.join(testDataDir, file);
          const csv = fs.readFileSync(filePath, "utf8");
          const rows = csv.split(/\r?\n/).filter(Boolean);
          if (rows.length < 2) continue; // skip empty
          const headers = rows[0].split(",");
          for (let i = 1; i < rows.length; ++i) {
            const values = rows[i].split(",");
            if (values.length !== headers.length) continue;
            const entry = {};
            headers.forEach((h, idx) => entry[h] = values[idx]);
            try {
              await INSERT.into(entity).entries(entry);
              imported++;
            } catch (e) {
              failed.push(file + ': ' + e.message);
            }
          }
        }
        return `Imported ${imported} records. Failures: ${failed.length ? failed.join('; ') : 'none'}`;
      } catch (err) {
        return req.reject(500, 'Error importing test data: ' + err.message);
      }
    });

    await super.init();
  }

  async findExistingComponent(component) {
    const { Components } = this.entities;

    const allComponents = await SELECT.from(Components).where({
      sourceSystemTypeCode: component.sourceSystemTypeCode,
      componentTypeCode: component.componentTypeCode,
    });

    return allComponents.find((existing) => component.isEqual(existing, component));
  }
}

module.exports = ComponentsService;

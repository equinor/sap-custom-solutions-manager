const constants = require("./constants");
const BaseAPI = require("./BaseAPI");

const LIMIT_OF_COMPONENTS_TO_PULL = 9999;

class ABAPPackage extends BaseAPI {
  constructor(services) {
    super();
    this.services = Array.isArray(services) ? services : [services];
  }

  async fetchComponents() {
    try {
      const allComponents = await Promise.all(
        this.services.map(async (service) => {
          const components = await service.run(
            SELECT.from("ABAPPackages").limit(LIMIT_OF_COMPONENTS_TO_PULL)
          );
          return components.map(comp => this.mapToComponent(comp));
        })
      );
      return this._getUniqueComponents(allComponents.flat());
    } catch (error) {
      console.error('Error fetching components from ABAP Packages service:', error);
      throw new Error('Failed to fetch components from ABAPPackages service');
    }
  }

  _getUniqueComponents(components) {
    const uniqueComponents = [];
    for (const component of components) {
      // Only add if not already present, preserving the first occurrence (from the first service)
      if (!uniqueComponents.some(existing => this.isEqual(existing, component))) {
        uniqueComponents.push(component);
      }
    }
    return uniqueComponents;
  }

  mapToComponent(apiComponent) {
    let props = {
      ID: apiComponent.ID,
      name: apiComponent.ABAPPackage,
      description: apiComponent.ABAPPackageName,
      sourceSystemTypeCode: constants.SOURCE_SYSTEM_TYPES.SAP_ONPREM,
      sourceSystemId: apiComponent.SystemName,
      componentTypeCode: constants.COMPONENT_TYPES.ABAP,
      componentCreatedAt: apiComponent.CreationDate ? new Date(apiComponent.CreationDate).toISOString() : null,
      componentCreatedBy: apiComponent.CreatedByUser,
      componentModifiedAt: apiComponent.LastChangeDate ? new Date(apiComponent.LastChangeDate).toISOString() : null,
      componentModifiedBy: apiComponent.LastChangedByUser,
      componentCreatedByFullName: apiComponent.CreatorFullName,
    };

    let component = new ABAPPackage(); 
    Object.assign(component, props);
    return component;
  }

  isEqual(component1, component2) { 
    return component1.name == component2.name;
  }
}

module.exports = ABAPPackage;

class BaseAPI {
    constructor() {
        if (this.constructor === BaseAPI) {
            throw new Error("Abstract class 'BaseAPI' cannot be instantiated directly");
        }
    }

    async fetchComponents() {
        throw new Error("Method 'fetchComponents()' must be implemented");
    }

    isEqual(component1, component2) {
        throw new Error("Method 'isEqual()' must be implemented");
    }
}

module.exports = BaseAPI; 
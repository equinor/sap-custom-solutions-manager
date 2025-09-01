const cds = require("@sap/cds/lib");
const { default: axios } = require("axios");
const { GET, POST, DELETE, PATCH, expect } = cds.test(__dirname + "../../");

axios.defaults.auth = {
  username: "incident.support@tester.sap.com",
  password: "initial",
};


describe("ComponentService", () => {

  before(async () => {
    await cds.deploy(__dirname + "/../srv/component-service.cds").to("sqlite::memory:");
    await cds.connect.to("ComponentService");
  });

  it("should have some components", async () => {
    const { data } = await GET `/odata/v4/component/Components`;
    expect(data.value).to.be.an("array");
  });

  it("should get all components", async () => {
    const service = await cds.connect.to("ComponentService");
    const { Components } = service.entities;
    expect(await SELECT.from(Components)).to.have.length.greaterThan(0);
  });

  it("should assign a component to a solution", async () => {
    const componentID = "ceeb3963-fe64-48b5-a34b-02685ef46b02";
    const solutionID = "e3b3b3b3-3b3b-3b3b-3b3b-3b3b3b3b3b3b";

    const response = await POST (`/odata/v4/component/Components(${componentID})/Assign`, { solutionID: solutionID } );
    expect(response.status).to.equal(200);
  });

  it("should unassign a component from a solution", async () => {
    const componentID = "ceeb3963-fe64-48b5-a34b-02685ef46b02";

    const response = await  POST(`/odata/v4/component/Components(${componentID})/Unassign`);
    expect(response.status).to.equal(200);
  });

  after(async () => {
    await cds.disconnect();
  });
});

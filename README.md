# Getting Started

SAP Custom Components - manage your components and solutions! 

## What is it? 

The **Custom Solutions** apps tackle the challenge of maintaining an up-to-date inventory of custom components in your SAP landscape.
A **solution** is anything you build to close the gap between a business requirement and the capabilities offered by standard SAP.
Each solution is made up of one or more **components** — custom developments such as ABAP packages, SAP UI5 apps, CAP services, and more.

The suite contains two apps:

1. **Custom Solutions** – 
   Create and maintain solution records. Link each solution to a responsible team and to supporting assets such as documentation, Jira stories, and other resources.

2. **Custom Components** –
   Import collections of components (chiefly ABAP packages) into a central database and associate each one with its solution. You can rate every component for **Clean Core** compliance and **Code Quality**, and add reviewer and general comments.


## License 

The applications use the [CAP framework](https://cap.cloud.sap/docs/), [SAPUI5](https://sapui5.hana.ondemand.com/sdk/#/api) and Fiori Elements. These frameworks require separate licenses and a commercial agreement with SAP for productive use. 

## Required BTP services

The apps are meant to be deployed to and hosted on BTP, and the following services in BTP are required: 

* SAP BTP Cloud Foundry
* BTP HANA database 
* BTP XSUAA authorization service
* BTP destination service 
* BTP applications log
* BTP WorkZone


## Available APIs

The Custom Components app reads components from external APIs. These APIs are maintained in separate Github repositories. The following APIs are currently available: 

* SAP S/4 system - ABAP Packages - https://github.com/equinor/sap-ca-custom-components-api-onpremise

## Structure 

It contains these folders and files, following CAP recommended project layout:

File or Folder | Purpose
---------|----------
`app/` | content for UI frontends goes here
`db/` | your domain models and data go here
`srv/` | your service models and code go here
`package.json` | project metadata and configuration
`readme.md` | this getting started guide


## Install and run 

- Open a new terminal and run 
```
npm install
cds deploy
cds watch
```

## Run with test data 

To populate application with test data, move files in folder `db/data/test` to folder `db/data` and run `cds deploy`

## Connect to your own SAP on-premise system 

The Components app will connect to APIs via BTP Destinations. The destination `CUSTOM-COMPONENTS-S4-BA` exposes the API for S/4 packages. A technical user should be created with access to the relevant S/4 OData API. 

While in development mode, you can connect directly to your S/4 system by creating a file `default-env.json`, for an example see `example-default-env.json`


## Testing 

There are both backend CAP tests and front end tests available. 

### Backend 

To run the CAP units tests in `tests/component-service.test.js`:

1. Run `npm test` from the root folder
   

### Frontend 

To run the OPA tests in folder `test` in the in the `webapp` folder: 

1. Run `cds watch` from the root folder to serve the backend
2. Navigate to app folder, ie. `app/custom-components/webapp`
3. Run `ui5 serve` to host serve the frontend
4. Open browser to `http://localhost:8080/test/testsuite.qunit.html`

Tip: To run the OPA tests more slowly, set the `opaExecutionDelay` parameter: 

`http://localhost:8080/test/integration/opaTests.qunit.html?opaExecutionDelay=1000`


### Deploy to BTP 
``` bash 
npm install 
npm run build 
cf login --sso ## Login to BTP account and space 
npm run deploy
```


using {  cuid } from '@sap/cds/common';
using S4_PROD_ABAP_PACKAGES from './external/S4_PROD_ABAP_PACKAGES.cds';
using {com.equinor.ca.customcomponents as my} from '../db/schema';

service ComponentService {

    type solutionAssignment {
        solutionID: UUID;
        name: String;
        description: String;
    }

    type componentAssignment {
        componentID: UUID;
    }
    
    // Pull components from external APIs into staging area
    @Common.IsActionCritical : true
    function pullComponents() returns array of Components; 
    
    //Import components from staging area 
    action importComponents(componentIds: array of String) returns array of Components;
    
    //Import components from APIs into Components table
    @Common.IsActionCritical : true
    function directImport() returns array of Components;

    //Import test data from db/data/test folder
    function importTestData() returns String;


    @readonly
    entity OnPremABAPPackages as
        projection on S4_PROD_ABAP_PACKAGES.ABAPPackages {
            key ABAPPackage,
                ABAPPackageResponsibleUser,
                ABAPSoftwareComponent,
                ABAPApplicationComponent,
                ABAPNamespace,
                ABAPPackageTargetEnvironment,
                CreatedByUser,
                CreationDate,
                LastChangedByUser,
                LastChangeDate,
                ABAPLanguageVersion,
                ABAPPackageName,
                ABAPSuperpackage,
                ObjectCount,
                CreatorFullName,
                SystemName
        };
    
    entity Components as projection on my.Components actions {
        // Side effect to update the solution entity after assigning a new solution to a component, so that 
        // the correct solution name immeditely appears in the object page 
        // See https://sapui5.hana.ondemand.com/test-resources/sap/fe/core/fpmExplorer/index.html#/advancedFeatures/guidanceSideEffects
        @(
            Common.SideEffects              : {TargetProperties : ['_it/*'], TargetEntities : ['_it/solution']},
            cds.odata.bindingparameter.name : '_it'
        )
        action Assign(solutionID: solutionAssignment:solutionID) returns String;        


        // Show popup to confirm unassigning a component from a solution
        @(
            Common.IsActionCritical : true
        )
        //Side effect to update the solution entity after unassigning a solution from a component
        @(
            Common.SideEffects              : {TargetProperties : ['_it/*'], TargetEntities : ['_it/solution']},
            cds.odata.bindingparameter.name : '_it'
        )
        action Unassign() returns String;
    }
    
    extend projection Components with {    
        @Common.Label : 'Solution name'    
        solution.name as SolutionName //Needed to allow navigation to solution by clicking solution name
    }
    
    entity ComponentComments as projection on my.ComponentComments;
    entity Ratings as projection on my.Ratings;
    entity SolutionResources as projection on my.SolutionResources;
    entity ExternalComponents as projection on my.ExternalComponents;
        
    @odata.draft.enabled
    entity Solutions as projection on my.Solutions actions {
        @(
            Common.SideEffects : {TargetProperties : ['_it/*'], TargetEntities : ['_it/components']},
            cds.odata.bindingparameter.name : '_it'
        )
        action assignComponent(
            @(
                title: 'Assign to components',
                Common: {
                    ValueList: {
                        CollectionPath: 'Components',
                        SearchSupported: true,
                        Parameters: [
                            {
                                $Type: 'Common.ValueListParameterInOut',
                                LocalDataProperty: 'components',
                                ValueListProperty: 'ID'
                            },
                            {
                                $Type: 'Common.ValueListParameterDisplayOnly',
                                ValueListProperty: 'name'
                            },
                            {
                                $Type: 'Common.ValueListParameterDisplayOnly',
                                ValueListProperty: 'description'
                            }
                        ]
                    }
                },
            ) 
            components: array of componentAssignment:componentID
        ) returns String;
    };

    @readonly
    entity SAPDevelopmentSystemCodeList as projection on my.SAPDevelopmentSystemCodeList; 
    
}

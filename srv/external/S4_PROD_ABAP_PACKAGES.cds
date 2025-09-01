/* checksum : 9778c8d7710b492e7a058a388b1a231e */
@cds.external : true
@Aggregation.ApplySupported : { Transformations: [ 'aggregate', 'groupby', 'filter' ], Rollup: #None }
@Common.ApplyMultiUnitBehaviorForSortingAndFiltering : true
@Capabilities.FilterFunctions : [
  'eq',
  'ne',
  'gt',
  'ge',
  'lt',
  'le',
  'and',
  'or',
  'contains',
  'startswith',
  'endswith',
  'any',
  'all'
]
@Capabilities.SupportedFormats : [ 'application/json', 'application/pdf' ]
@PDF.Features : {
  DocumentDescriptionReference: '../../../../default/iwbep/common/0001/$metadata',
  DocumentDescriptionCollection: 'MyDocumentDescriptions',
  ArchiveFormat: true,
  Border: true,
  CoverPage: true,
  FitToPage: true,
  FontName: true,
  FontSize: true,
  Margin: true,
  Padding: true,
  Signature: true,
  HeaderFooter: true,
  ResultSizeDefault: 20000,
  ResultSizeMaximum: 20000
}
@Capabilities.KeyAsSegmentSupported : true
@Capabilities.AsynchronousRequestsSupported : true
service S4_PROD_ABAP_PACKAGES {};

@cds.external : true
@cds.persistence.skip : true
@Common.Label : 'Custom ABAP Objects'
@Capabilities.SearchRestrictions.Searchable : false
@Capabilities.InsertRestrictions.Insertable : false
@Capabilities.DeleteRestrictions.Deletable : false
@Capabilities.UpdateRestrictions.Updatable : false
@Capabilities.UpdateRestrictions.QueryOptions.SelectSupported : true
entity S4_PROD_ABAP_PACKAGES.ABAPObjects {
  @Common.IsUpperCase : true
  @Common.Label : 'Program ID'
  @Common.Heading : 'PgID'
  @Common.QuickInfo : 'Program ID in Requests and Tasks'
  key ABAPObjectCategory : String(4) not null;
  @Common.IsUpperCase : true
  @Common.Label : 'Object Type'
  @Common.Heading : 'Obj.'
  @Common.QuickInfo : 'Object Type in Object Directory'
  key ABAPObjectType : String(4) not null;
  @Common.IsUpperCase : true
  @Common.Label : 'Object Name'
  @Common.QuickInfo : 'Object Name in Object Directory'
  key ABAPObject : String(40) not null;
  @Common.IsUpperCase : true
  @Common.Label : 'Original System'
  @Common.Heading : 'Original'
  @Common.QuickInfo : 'Original System of Object'
  ABAPSourceSystem : String(10) not null;
  @Common.IsUpperCase : true
  @Common.Label : 'Person Responsible'
  @Common.Heading : 'Person Responsible for Repository Object'
  @Common.QuickInfo : 'Person Responsible for a Repository Object'
  ABAPObjectResponsibleUser : String(12) not null;
  @Common.IsUpperCase : true
  @Common.Label : 'Package'
  ABAPPackage : String(30) not null;
  @Common.Label : 'Generation Flag'
  @Common.Heading : 'Gen.'
  @Common.QuickInfo : 'Generation flag'
  ABAPObjectGenerationCode : Boolean not null;
  @Common.Label : 'Original Language'
  @Common.Heading : 'L'
  @Common.QuickInfo : 'Original Language in Repository objects'
  ABAPObjectMasterLanguage : String(2) not null;
  @Common.IsUpperCase : true
  @Common.Label : 'Deployment Target'
  ABAPObjectDeploymentTarget : String(1) not null;
  @Common.Label : 'Object Deleted'
  @Common.QuickInfo : 'Deletion Flag'
  ABAPObjectIsDeleted : Boolean not null;
  @Common.Label : 'Created On'
  @Common.QuickInfo : 'Object Created On'
  CreationDate : Date;
  @Common.Label : 'Full Name'
  @Common.QuickInfo : 'Full Name of Person'
  CreatedByFullName : String(80) not null;
  ObjectDescription : String(75) not null;
};

@cds.external : true
@cds.persistence.skip : true
@Common.Label : 'ABAP Object Types'
@Capabilities.SearchRestrictions.Searchable : false
@Capabilities.InsertRestrictions.Insertable : false
@Capabilities.DeleteRestrictions.Deletable : false
@Capabilities.UpdateRestrictions.Updatable : false
@Capabilities.UpdateRestrictions.QueryOptions.SelectSupported : true
entity S4_PROD_ABAP_PACKAGES.ABAPObjectTypes {
  key ObjectCategory : String(4) not null;
  @Common.IsUpperCase : true
  @Common.Label : 'Object'
  @Common.QuickInfo : 'Object Name'
  key ObjectType : String(30) not null;
  ObjectDescription : String(75) not null;
};

@cds.external : true
@cds.persistence.skip : true
@Common.Label : 'ABAP packages'
@Capabilities.SearchRestrictions.Searchable : false
@Capabilities.InsertRestrictions.Insertable : false
@Capabilities.DeleteRestrictions.Deletable : false
@Capabilities.UpdateRestrictions.Updatable : false
@Capabilities.UpdateRestrictions.QueryOptions.SelectSupported : true
entity S4_PROD_ABAP_PACKAGES.ABAPPackages {
  @Common.IsUpperCase : true
  @Common.Label : 'Package'
  key ABAPPackage : String(30) not null;
  @Common.IsUpperCase : true
  @Common.Label : 'Person Responsible'
  @Common.QuickInfo : 'Person responsible for a package'
  ABAPPackageResponsibleUser : String(12) not null;
  @Common.IsUpperCase : true
  @Common.Label : 'Software Component'
  ABAPSoftwareComponent : String(30) not null;
  @Common.IsUpperCase : true
  @Common.Label : 'Applic. Component'
  @Common.QuickInfo : 'Application Component'
  ABAPApplicationComponent : String(20) not null;
  @Common.IsUpperCase : true
  @Common.Label : 'Namespace'
  ABAPNamespace : String(10) not null;
  @Common.IsUpperCase : true
  @Common.Label : 'Target'
  @Common.QuickInfo : 'Target Environment'
  ABAPPackageTargetEnvironment : String(1) not null;
  @Common.IsUpperCase : true
  @Common.Label : 'Created By'
  @Common.QuickInfo : 'Author'
  CreatedByUser : String(12) not null;
  @Common.Label : 'Created On'
  CreationDate : Date;
  @Common.IsUpperCase : true
  @Common.Label : 'Last changed by'
  LastChangedByUser : String(12) not null;
  @Common.Label : 'Changed On'
  LastChangeDate : Date;
  @Common.IsUpperCase : true
  @Common.Label : 'Language Version'
  @Common.Heading : 'ABAP Language Version'
  @Common.QuickInfo : 'ABAP Language Version'
  ABAPLanguageVersion : String(1) not null;
  @Common.Label : 'Short Description'
  @Common.QuickInfo : 'Short Description of Repository Objects'
  ABAPPackageName : String(60) not null;
  @Common.IsUpperCase : true
  @Common.Label : 'Superpackage'
  ABAPSuperpackage : String(30) not null;
  ObjectCount : Integer not null;
  @Common.Label : 'Full Name'
  @Common.QuickInfo : 'Full Name of Person'
  CreatorFullName : String(80) not null;
  @Common.IsUpperCase : true
  @Common.Label : 'Original System'
  @Common.Heading : 'Original'
  @Common.QuickInfo : 'Original System of Object'
  SystemName : String(10) not null;
  _Objects : Association to many S4_PROD_ABAP_PACKAGES.ABAPObjects {  };
};


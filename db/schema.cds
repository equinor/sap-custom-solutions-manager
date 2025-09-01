using { managed, cuid, sap.common.CodeList} from '@sap/cds/common';
namespace com.equinor.ca.customcomponents;

// @readonly This annotation breaks the assign solution actions
aspect component {
  @Common.Label: 'Name'
  name  : String;
  @Common.Label: 'Description'
  description : String;
  @Common.Label: 'Source System Type'
  sourceSystemTypeCode: String;
  @Common.Label: 'Source System ID'
  sourceSystemId: String; 
  @Common.Label: 'Component Type' 
  componentTypeCode: String;
  @Common.Label: 'Created At'
  componentCreatedAt  : Timestamp;
  @Common.Label: 'Created By'
  componentCreatedBy  : String;      
  @Common.Label: 'Modified At'
  componentModifiedAt : Timestamp;
  @Common.Label: 'Modified By'
  componentModifiedBy : String;   
  @Common.Label: 'Created By Full Name'
  componentCreatedByFullName : String;
  sourceSystemType: Association to SystemTypeCodeList on sourceSystemTypeCode;
  componentType: Association to ComponentTypeCodeList on componentTypeCode;
  solution: Association to one Solutions;
}

entity RatingTypeCodeList : CodeList {
  @Common.Text : { $value: name, ![@UI.TextArrangement]: #TextOnly }
  key code : Integer @Common.Label : 'Code';
}


entity ComponentTypeCodeList : CodeList {
  @Common.Text : { $value: name, ![@UI.TextArrangement]: #TextOnly }
  key code : String(50) @Common.Label : 'Code';
}

entity SystemTypeCodeList : CodeList {
  @Common.Text : { $value: name, ![@UI.TextArrangement]: #TextOnly }
  key code : String(50) @Common.Label : 'Code';
}

entity TeamCodeList : CodeList {
  @Common.Text : { $value: name, ![@UI.TextArrangement]: #TextOnly }
  key code : String(50) @Common.Label : 'Code';
}

entity ResourceTypeCodeList : CodeList {
  @Common.Text : { $value: name, ![@UI.TextArrangement]: #TextOnly }
  key code : String(50) @Common.Label : 'Code';
}

entity ImportStatusCodeList : CodeList {
  @Common.Text : { $value: name, ![@UI.TextArrangement]: #TextOnly }
  key code : String(50) @Common.Label : 'Code';
}

entity SAPDevelopmentSystemCodeList : CodeList {
  @Common.Text : { $value: name, ![@UI.TextArrangement]: #TextOnly }
  key code : String(50) @Common.Label : 'Code';
} 

entity Solutions : managed {
  @UI.Hidden
  key ID : UUID;
  @Common.Label: 'Name'
  name  : String;
  @Common.Label: 'Description'  
  description : String;
  owner : String;
  team : Association to TeamCodeList; 
  solutionCreatedByFullName : String;
  resources: Composition of many SolutionResources on resources.solution = $self;
  components: Association to many Components on components.solution = $self;
}

entity SolutionResources: managed {
  key ID : UUID;
  type: Association to one ResourceTypeCodeList;
  description : String;
  @Common.Label: 'Link'
  @HTML5.LinkTarget : '_blank'
  link: String; 
  solution: Association to one Solutions;
}

entity Components : cuid, managed, component {
  solution: Association to Solutions;  
  comments: Composition of many ComponentComments on comments.component = $self;
  ratings: Composition of many Ratings on ratings.component = $self;
  virtual latestCleanCoreRating : Integer;
  virtual latestCodeQualityRating : Integer;
}

entity ComponentComments : managed {
  key ID : UUID;
  commentText : String;
  component : Association to Components;
  createdByFullName : String;
}

entity Ratings : managed {
  key ID : UUID;
  rating : Integer;
  comment: String;
  component : Association to one Components;
  ratingType : Association to one RatingTypeCodeList;
  createdByFullName : String;
}

entity ExternalComponents : managed, cuid, component {
    importStatus: Association to one ImportStatusCodeList;
}


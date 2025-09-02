using ComponentService as service from '../srv/component-service';

// Value help for assigning a Component to a Solution
annotate service.Solutions with {
  ID @(Common: {
    Text           : name,
    TextArrangement: #TextOnly
  })
};

annotate service.componentAssignment {
  componentID @(
    Common.Label                   : 'Assign to component',
    Common.ValueList               : {
      $Type         : 'Common.ValueListType',
      CollectionPath: 'Components',
      Parameters    : [
        {
          $Type            : 'Common.ValueListParameterOut',
          LocalDataProperty: 'componentID',
          ValueListProperty: 'ID'
        },
        {
          $Type            : 'Common.ValueListParameterDisplayOnly',
          ValueListProperty: 'name'
        },
        {
          $Type            : 'Common.ValueListParameterDisplayOnly',
          ValueListProperty: 'description'
        }
      ],
      Label         : 'Choose a Component'
    },
    Common.ValueListWithFixedValues: false
  );
};

annotate service.solutionAssignment {
  solutionID @(
    Common.Label                   : 'Assign to solution',
    Common.ValueList               : {
      $Type         : 'Common.ValueListType',
      CollectionPath: 'Solutions',
      Parameters    : [
        {
          $Type            : 'Common.ValueListParameterOut',
          LocalDataProperty: 'solutionID',
          ValueListProperty: 'ID'
        },
        {
          $Type            : 'Common.ValueListParameterDisplayOnly',
          ValueListProperty: 'name'
        },
        {
          $Type            : 'Common.ValueListParameterDisplayOnly',
          ValueListProperty: 'description'
        }
      ],
      Label         : 'Choose a Solution'
    },
    Common.ValueListWithFixedValues: false
  );
};

annotate service.ExternalComponents with {
  createdAt @(
    Common.Label: 'Pulled On'
  );
  createdBy @(
    Common.Label: 'Pulled By'
  );
  modifiedAt @(
    UI.Hidden : true
  );
  modifiedBy @(
    UI.Hidden : true
  )
};

annotate  service.Components with {
  ID @(
    Common.Label: 'Component ID',
    Common.Text           : name,
    Common.TextArrangement: #TextOnly,
    UI.Hidden : true,
  );
  solution @(
    UI.Hidden : true,
  );
  latestCleanCoreRating @(
    Common.Label : 'Latest Clean Core Rating',
    UI.Hidden : false,
  );
  latestCodeQualityRating @(
    Common.Label : 'Latest Code Quality Rating',
    UI.Hidden : false,
  );
};



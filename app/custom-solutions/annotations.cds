using ComponentService as service from '../../srv/component-service';
using from '../../db/schema';

annotate service.Solutions with @(   
     UI.HeaderFacets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'name',
            Target : '@UI.DataPoint#name',
            Label : 'Solution Name',
        }
    ],
    UI.DataPoint #name : {
        $Type : 'UI.DataPointType',
        Value : name,
        Title : 'Solution Name',
    },
    UI.DataPoint #description : {
        $Type : 'UI.DataPointType',
        Value : description,
        Title : 'Solution Description',
    },
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'Name',
                Value : name,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Description',
                Value : description,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Owner',
                Value : owner,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Team',
                Value : team_code,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Created by',
                Value : solutionCreatedByFullName,
            },
            {
                $Type : 'UI.DataField',
                Value : createdAt,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Components',
            ID : 'Components',
            Target : 'components/@UI.LineItem#Components',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Resources',
            ID : 'Resources',
            Target : 'resources/@UI.LineItem#Resources',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'Name',
            Value : name,
            ![@UI.Importance] : #High,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Description',
            Value : description,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Owner',
            Value : owner,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Team',
            Value : team_code,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Created by',
            Value : solutionCreatedByFullName,
        },
    ],
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : name,
        },
        TypeName : 'Solution',
        TypeNamePlural : 'Solutions',
        TypeImageUrl : 'sap-icon://applicaton'
    },
    UI.SelectionPresentationVariant #table : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem',
            ],
            SortOrder : [
                {
                    $Type : 'Common.SortOrderType',
                    Property : name,
                    Descending : false,
                },
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
    },
    UI.SelectionFields : [
        name,
        team_code,
    ],
    UI.Identification : [
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'ComponentService.assignComponent',
            Label : 'Assign Components',
        },
    ],
);

annotate service.Solutions with {
    team @(
        Common.Text : {
            $value : team.name,
            ![@UI.TextArrangement] : #TextOnly,
        },
        Common.Label : 'Team',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'TeamCodeList',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : team_code,
                    ValueListProperty : 'code',
                },
            ],
            Label : 'Team',
        },
        Common.ValueListWithFixedValues : true,
    )
};

annotate service.Solutions with {
    description @UI.MultiLineText : true;
};

annotate service.Solutions with {
    solutionCreatedByFullName @Common.FieldControl : #ReadOnly
};
annotate service.Components with @(
    UI.LineItem #Components : [
       {
            $Type : 'UI.DataFieldWithUrl',
            Value : name,
            Label: 'View Solution',
            Url: {
                $edmJson : {
                $Apply: [ '/site/developertools#component-display?&/Components({componentID})?layout=TwoColumnsMidExpanded',
                    {
                    $LabeledElement : {
                        $Apply    : [{$Path : 'ID' }],
                        $Function : 'odata.concat'
                    },
                    $Name           : 'componentID'
                    }
                ],
                $Function : 'odata.fillUriTemplate'
                }
            }
        },        {
            $Type : 'UI.DataField',
            Value : sourceSystemId,
        },
        {
            $Type : 'UI.DataField',
            Value : sourceSystemTypeCode,
        },
        {
            $Type : 'UI.DataField',
            Value : description,
        },
    ]
);

annotate service.SolutionResources with @(
    UI.LineItem #Resources : [
        {
            $Type : 'UI.DataField',
            Value : type_code,
            Label : 'Type',
        },
        {
            $Type            : 'UI.DataFieldWithUrl',
            Url              : link, //Target, when pressing the text
            Value            : link, //Visible text            
            Label            : 'Link',
        },
        {
            $Type : 'UI.DataField',
            Value : description,
            Label : 'Description',
        },
    ]
);

annotate service.ResourceTypeCodeList with {
    code @Common.Text : {
        $value : name,
        ![@UI.TextArrangement] : #TextFirst,
    }
};

annotate service.SolutionResources with {
    type @(
        Common.ValueListWithFixedValues : true,
        Common.Text : type.name,
    )
};

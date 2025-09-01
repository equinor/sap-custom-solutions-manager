using ComponentService as service from '../../srv/component-service';
using from '../../db/schema';


annotate service.ExternalComponents with @(
    UI.FieldGroup #GeneratedGroup: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: name,
            },
            {
                $Type: 'UI.DataField',
                Value: description,
            },
            {
                $Type: 'UI.DataField',
                Value: sourceSystemTypeCode,
            },
            {
                $Type: 'UI.DataField',
                Value: sourceSystemId,
            },
            {
                $Type: 'UI.DataField',
                Value: componentTypeCode,
            },
            {
                $Type: 'UI.DataField',
                Value: componentCreatedAt,
            },
            {
                $Type: 'UI.DataField',
                Value: componentCreatedBy,
            },
            {
                $Type: 'UI.DataField',
                Value: componentModifiedAt,
            },
            {
                $Type: 'UI.DataField',
                Value: componentModifiedBy,
            },
            {
                $Type: 'UI.DataField',
                Value: componentCreatedByFullName,
            },
        ],
    },
    UI.Facets                    : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'GeneratedFacet1',
        Label : 'General Information',
        Target: '@UI.FieldGroup#GeneratedGroup',
    }, ],
    UI.LineItem                  : [
        {
            $Type : 'UI.DataField',
            Value : importStatus_code,
            Label : 'Import status',
            ![@UI.Importance] : #High,
        },
        {
            $Type: 'UI.DataField',
            Value: name,
            ![@UI.Importance] : #High,
        },
        {
            $Type: 'UI.DataField',
            Value: description,
        },
        {
            $Type: 'UI.DataField',
            Value: sourceSystemTypeCode,
        },
        {
            $Type: 'UI.DataField',
            Value: sourceSystemId,
        },
        {
            $Type: 'UI.DataField',
            Value: componentTypeCode,
        },
        {
            $Type : 'UI.DataField',
            Value : importStatus.name,
        }
    ],
    UI.HeaderInfo                : {
        Title         : {
            $Type: 'UI.DataField',
            Value: name,
        },
        TypeName      : 'Component',
        TypeNamePlural: 'Components',
        Description   : {
            $Type: 'UI.DataField',
            Value: description,
        },
        TypeImageUrl  : 'sap-icon://database',
    },
    UI.SelectionFields : [
        importStatus_code,
    ],
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
                    Property : importStatus_code,
                    Descending : false,
                },
                {
                    $Type : 'Common.SortOrderType',
                    Property : name,
                    Descending : false,
                },
                {
                    $Type : 'Common.SortOrderType',
                    Property : componentCreatedAt,
                    Descending : true,
                },
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
    },
);
annotate service.ExternalComponents with {
    importStatus @(
        Common.Text : {
            $value : importStatus_code,
            ![@UI.TextArrangement] : #TextSeparate
        },
        Common.Label : 'Import status',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'ImportStatusCodeList',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : importStatus_code,
                    ValueListProperty : 'code',
                },
            ],
            Label : 'Import status',
        },
        Common.ValueListWithFixedValues : true,
    )
};

annotate service.ImportStatusCodeList with {
    name @Common.Text : descr
};

annotate service.ImportStatusCodeList with {
    code @(
        Common.Label : 'Import status',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'ImportStatusCodeList',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : code,
                    ValueListProperty : 'name',
                },
            ],
            Label : 'Import status',
        },
        Common.ValueListWithFixedValues : true,
        Common.Text : name,
    )
};

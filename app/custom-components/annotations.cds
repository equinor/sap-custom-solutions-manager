using from '../../srv/component-service';
using from '../../db/schema';
annotate ComponentService.Components with @(
    UI.SelectionFields : [
        componentTypeCode,
        sourceSystemTypeCode,
        name,
        componentCreatedBy
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : name,
            ![@UI.Importance] : #High,
        },
        {
            $Type : 'UI.DataField',
            Value : description,
        },       
        {
            $Type : 'UI.DataFieldWithUrl',
            Value : SolutionName,
            Label: 'Solution',
            Url: {
                $edmJson : {
                $Apply: [ '/site/developertools#solution-display?&/Solutions(ID={solutionID_List},IsActiveEntity=true)',
                    {
                    $LabeledElement : {
                        $Apply    : [{$Path : 'solution_ID'}],
                        $Function : 'odata.concat'
                    },
                    $Name           : 'solutionID_List'
                    }
                ],
                $Function : 'odata.fillUriTemplate'
                }
            }
        },
        {
            $Type : 'UI.DataFieldForAnnotation',
            Target : '@UI.DataPoint#latestCleanCoreRating',
        },
        {
            $Type : 'UI.DataFieldForAnnotation',
            Target : '@UI.DataPoint#latestCodeQualityRating',
        },
        {
            $Type : 'UI.DataField',
            Value : componentCreatedAt,
        },
        {
            $Type : 'UI.DataField',
            Value : componentCreatedByFullName,
        },
        {
            $Type : 'UI.DataField',
            Value : componentModifiedAt,
        },
        {
            $Type : 'UI.DataField',
            Value : componentModifiedBy,
        },
        {
            $Type : 'UI.DataField',
            Value : componentTypeCode,
        },
        {
            $Type : 'UI.DataField',
            Value : sourceSystemId,
        },
        {
            $Type : 'UI.DataField',
            Value : sourceSystemTypeCode,
        },
    ],
    UI.HeaderFacets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'name',
            Target : '@UI.DataPoint#name',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'description',
            Target : '@UI.DataPoint#description',
        }
    ],
    UI.FieldGroup #HeaderForm : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : componentCreatedAt,
            },
            {
                $Type : 'UI.DataField',
                Value : componentModifiedBy,
            },
            {
                $Type : 'UI.DataField',
                Value : componentModifiedAt,
            },
            {
                $Type : 'UI.DataField',
                Value : componentCreatedBy,
            },
            {
                $Type : 'UI.DataField',
                Value : componentTypeCode,
            },
            {
                $Type : 'UI.DataField',
                Value : ID,
                Label : 'ID',
            },
            {
                $Type : 'UI.DataField',
                Value : modifiedAt,
            },
            {
                $Type : 'UI.DataField',
                Value : modifiedBy,
            },
            {
                $Type : 'UI.DataField',
                Value : name,
            },
            {
                $Type : 'UI.DataField',
                Value : solution_ID,
                Label : 'solution_ID',
            },
            {
                $Type : 'UI.DataField',
                Value : sourceSystemId,
            },
            {
                $Type : 'UI.DataField',
                Value : sourceSystemTypeCode,
            },
        ],
    },
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : name,
        },
        TypeName : 'Component',
        TypeNamePlural : 'Components',
        Description : {
            $Type : 'UI.DataField',
            Value : description,
        },
        TypeImageUrl : 'sap-icon://database',
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'General Information',
            ID : 'GeneralInformation',
            Target : '@UI.FieldGroup#GeneralInformation',
        },
    ],
    UI.FieldGroup #GeneralInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : description,
            },
            {
                $Type : 'UI.DataField',
                Value : componentCreatedByFullName,
                Label : 'Created by',
            },
            {
                $Type : 'UI.DataField',
                Value : componentCreatedBy,
            },
            {
                $Type : 'UI.DataField',
                Value : componentCreatedAt,
            },
            {
                $Type : 'UI.DataField',
                Value : componentModifiedAt,
            },
            {
                $Type : 'UI.DataFieldWithUrl',
                Value : SolutionName,
                Label: 'View Solution',
                Url: {
                    $edmJson : {
                    $Apply: [ '/site/developertools#solution-display?&/Solutions(ID={solutionID_Object},IsActiveEntity=true)',
                        {
                        $LabeledElement : {
                            $Apply    : [{$Path : 'solution_ID'}],
                            $Function : 'odata.concat'
                        },
                        $Name           : 'solutionID_Object'
                        }
                    ],
                    $Function : 'odata.fillUriTemplate'
                    }
                }
            }

        ],
    },
    UI.DataPoint #name : {
        $Type : 'UI.DataPointType',
        Value : name,
        Title : 'Component Name',
    },
    UI.DataPoint #description : {
        $Type : 'UI.DataPointType',
        Value : description,
        Title : 'Component Description',
    },
    UI.DataPoint #componentCreatedBy : {
        $Type : 'UI.DataPointType',
        Value : componentCreatedBy,
        Title : 'Creator',
    },
    UI.DataPoint #componentCreatedAt : {
        $Type : 'UI.DataPointType',
        Value : componentCreatedAt,
        Title : 'Created At',
    },
    UI.DeleteHidden : true,
    UI.Identification : [
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'ComponentService.Assign',
            Label : 'Assign',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'ComponentService.Unassign',
            Label : 'Unassign',
        }
    ],
    UI.DataPoint #componentCreatedByFullName : {
        $Type : 'UI.DataPointType',
        Value : componentCreatedByFullName,
        Title : 'Created by',
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
    UI.DataPoint #latestCleanCoreRating : {
        Value : latestCleanCoreRating,
        Visualization : #Rating,
        TargetValue : 5,
    },
    UI.DataPoint #latestCodeQualityRating : {
        Value : latestCodeQualityRating,
        Visualization : #Rating,
        TargetValue : 5,
    },
);

annotate ComponentService.ComponentTypeCodeList with {
    code @Common.Text : name
};

annotate ComponentService.Components with {
    componentTypeCode @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'ComponentTypeCodeList',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : componentTypeCode,
                    ValueListProperty : 'code',
                },
            ],
        },
        Common.ValueListWithFixedValues : true
)};

annotate ComponentService.SystemTypeCodeList with {
    code @Common.Text : name
};

annotate ComponentService.Components with {
    sourceSystemTypeCode @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'SystemTypeCodeList',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : sourceSystemTypeCode,
                    ValueListProperty : 'code',
                },
            ],
        },
        Common.ValueListWithFixedValues : true
)};

annotate ComponentService.Components with {
    name @(
        Common.Label : 'Component Name',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Components',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : name,
                    ValueListProperty : 'name',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'sourceSystemId',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'componentCreatedAt',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
        Common.Text : {
            $value : description,
            ![@UI.TextArrangement] : #TextSeparate
        },
    )
};

annotate ComponentService.Components with {
    componentCreatedBy @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Components',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : componentCreatedBy,
                    ValueListProperty : 'componentCreatedBy',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'description',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'sourceSystemTypeCode',
                },
            ],
        },
        Common.ValueListWithFixedValues : true
)};

annotate ComponentService.ComponentComments with @(
    UI.LineItem #Commentstable : [
        {
            $Type : 'UI.DataField',
            Value : component.comments.commentText,
            Label : 'commentText',
        },
        {
            $Type : 'UI.DataField',
            Value : component.comments.component_ID,
            Label : 'component_ID',
        },
        {
            $Type : 'UI.DataField',
            Value : component.comments.createdBy,
            Label : 'createdBy',
        },
        {
            $Type : 'UI.DataField',
            Value : component.comments.createdAt,
            Label : 'createdAt',
        },
        {
            $Type : 'UI.DataField',
            Value : component.comments.ID,
            Label : 'ID',
        },
        {
            $Type : 'UI.DataField',
            Value : component.comments.modifiedAt,
        },
        {
            $Type : 'UI.DataField',
            Value : component.comments.modifiedBy,
        },
    ]
);



annotate ComponentService.SystemTypeCodeList with @(
    UI.DataPoint #name : {
        $Type : 'UI.DataPointType',
        Value : name,
        Title : 'name',
    },
    UI.DataPoint #descr : {
        $Type : 'UI.DataPointType',
        Value : descr,
        Title : 'descr',
    },
    UI.DataPoint #code : {
        $Type : 'UI.DataPointType',
        Value : code,
        Title : 'code',
    }
);

annotate ComponentService.ComponentTypeCodeList with @(
    UI.DataPoint #code : {
        $Type : 'UI.DataPointType',
        Value : code,
        Title : 'code',
    },
    UI.DataPoint #descr : {
        $Type : 'UI.DataPointType',
        Value : descr,
        Title : 'descr',
    }
);

annotate ComponentService.Ratings with @(
    UI.LineItem #Ratings : [
        {
            $Type : 'UI.DataFieldForAnnotation',
            Target : '@UI.DataPoint#rating',
            Label : 'Rating',
        },
        {
            $Type : 'UI.DataField',
            Value : comment,
            Label : 'Comment',
        },
        {
            $Type : 'UI.DataField',
            Value : ratingType.name,
            Label : 'Type',
        },
        {
            $Type : 'UI.DataField',
            Value : createdAt,
        },
        {
            $Type : 'UI.DataField',
            Value : createdBy,
        },
    ],
    UI.DataPoint #rating : {
        Value : rating,
        Visualization : #Rating,
        TargetValue : 5,
    },
    UI.SelectionPresentationVariant #Ratings : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem#Ratings',
            ],
            SortOrder : [
                {
                    $Type : 'Common.SortOrderType',
                    Property : createdAt,
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
    UI.LineItem #RatingsTable : [
        {
            $Type : 'UI.DataFieldForAnnotation',
            Target : '@UI.DataPoint#rating1',
            Label : 'rating',
        },
        {
            $Type : 'UI.DataField',
            Value : comment,
            Label : 'comment',
        },
    ],
    UI.DataPoint #rating1 : {
        Value : rating,
        Visualization : #Rating,
        TargetValue : 5,
    },
    UI.SelectionPresentationVariant #RatingsTable : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem#RatingsTable',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
    },
);
annotate ComponentService.RatingTypeCodeList with {
    name @Common.Text : {
        $value : descr,
        ![@UI.TextArrangement] : #TextOnly
    }
};




using AdminService as service from '../../srv/admin-service';

annotate service.ResourceTypeCodeList with @(
    UI.LineItem #tableMacro : [
        {
            $Type : 'UI.DataField',
            Value : code,
        },
        {
            $Type : 'UI.DataField',
            Value : name,
        },
        {
            $Type : 'UI.DataField',
            Value : descr,
        },
    ]
);

annotate service.ComponentTypeCodeList with @(
    UI.LineItem #tableMacro : [
        {
            $Type : 'UI.DataField',
            Value : code,
        },
        {
            $Type : 'UI.DataField',
            Value : name,
        },
        {
            $Type : 'UI.DataField',
            Value : descr,
        },
    ]
);

annotate service.TeamCodeList with @(
    UI.LineItem #tableMacro : [
        {
            $Type : 'UI.DataField',
            Value : code,
        },
        {
            $Type : 'UI.DataField',
            Value : name,
        },
        {
            $Type : 'UI.DataField',
            Value : descr,
        },
    ]
);

annotate service.SystemTypeCodeList with @(
    UI.LineItem #tableMacro : [
        {
            $Type : 'UI.DataField',
            Value : code,
        },
        {
            $Type : 'UI.DataField',
            Value : name,
        },
        {
            $Type : 'UI.DataField',
            Value : descr,
        },
    ]
);

annotate service.SAPDevelopmentSystemCodeList with @(
    UI.LineItem #tableMacro : [
        {
            $Type : 'UI.DataField',
            Value : code,
        },
        {
            $Type : 'UI.DataField',
            Value : name,
        },
        {
            $Type : 'UI.DataField',
            Value : descr,
        },
    ]
);


annotate service.ResourceTypeCodeList with {
    code @Common.Text : {
        $value : name,
        ![@UI.TextArrangement] : #TextSeparate,
    }
};

annotate service.ComponentTypeCodeList with {
    code @Common.Text : {
        $value : name,
        ![@UI.TextArrangement] : #TextSeparate,
    }
};

annotate service.SystemTypeCodeList with {
    code @Common.Text : {
        $value : name,
        ![@UI.TextArrangement] : #TextSeparate,
    }
};

annotate service.TeamCodeList with {
    code @Common.Text : {
        $value : name,
        ![@UI.TextArrangement] : #TextSeparate,
    }
};

annotate service.SAPDevelopmentSystemCodeList with {
    code @Common.Text : {
        $value : name,
        ![@UI.TextArrangement] : #TextSeparate,
    }
};

annotate service.ResourceTypeCodeList with @(Capabilities: {InsertRestrictions: {RequiredProperties: [code,name,descr]}});
annotate service.ComponentTypeCodeList with @(Capabilities: {InsertRestrictions: {RequiredProperties: [code,name,descr]}});
annotate service.SystemTypeCodeList with @(Capabilities: {InsertRestrictions: {RequiredProperties: [code,name,descr]}});
annotate service.TeamCodeList with @(Capabilities: {InsertRestrictions: {RequiredProperties: [code,name,descr]}});
annotate service.SAPDevelopmentSystemCodeList with @(Capabilities: {InsertRestrictions: {RequiredProperties: [code,name,descr]}});


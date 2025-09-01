using {com.equinor.ca.customcomponents as my} from '../db/schema';


service AdminService {

entity ResourceTypeCodeList as projection on my.ResourceTypeCodeList;
entity ComponentTypeCodeList as projection on my.ComponentTypeCodeList;
entity SystemTypeCodeList as projection on my.SystemTypeCodeList;
entity TeamCodeList as projection on my.TeamCodeList;
entity SAPDevelopmentSystemCodeList as projection on my.SAPDevelopmentSystemCodeList;

}
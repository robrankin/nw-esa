/*
Version: 3
*/
module ${module_id};

<#if module_debug>@Audit('stream')</#if>
@Name('${module_id}_Alert')

@RSAAlert(oneInSeconds=${module_suppress?c}, identifiers={"ip_src"})
select * from 
pattern @SuppressOverlappingMatches
[
every a= Event(threat_source='third party publicized iocs' AND (medium=1 OR medium=32 OR device_type IS NULL OR device_type!='rsaecat')) -> b= Event(medium=32 AND device_type='rsaecat' AND (ip_src=a.ip_dst OR ip_src=a.ip_src)) where timer:within(${time_window?c} seconds)
];

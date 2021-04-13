#GET https://dev.azure.com/{organization}/{project}/_apis/serviceendpoint/endpoints?type={type}&authSchemes={authSchemes}&endpointIds={endpointIds}&owner={owner}&includeFailed={includeFailed}&includeDetails={includeDetails}&api-version=5.1-preview.2
#create service connection
[CmdletBinding()]
param (
    [Parameter(mandatory = $true)]
    [string]$Token,

    [Parameter(mandatory = $true)]
    [string]$Organization,

    [Parameter(mandatory = $true)]
    [object]$Object,

    [Parameter(mandatory = $true)]
    [string]$ProjectName
     
)
$Uri = ('https://dev.azure.com/{0}/{1}/_apis/serviceendpoint/endpoints?api-version=5.1-preview.2' -f $Organization, $ProjectName)
$SecureToken = [system.convert]::ToBase64String([system.text.encoding]::ASCII.GetBytes(":$($Token)"))
$Params = @{
    Uri         = $uri
    Headers     = @{
        Authorization = "Basic $SecureToken"
    } 
    method      = "POST"
    ContentType = "application/json"
}
$value = Invoke-RestMethod @Params
$objects = $value.value
$objects
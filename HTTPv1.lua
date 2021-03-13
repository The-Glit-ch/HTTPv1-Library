--Glit_ches was here
--
--Couple notes I like to make
--
--Lua makes all of this so easy god dam
--
--
local HTTPv1 = {}

--Service
local HTTPService = game:GetService("HttpService")--This is SOOO much easier than UE4. Doing that in UE4 would require so much cpp code

--ModuleStartUp
IsHTTPEnabled = HTTPService:GetAsync('https://github.com/The-Glit-ch')--Due to roblox not having a "HTTP.IsEnabled" value I had to make my own
if IsHTTPEnabled ~= nil then
	IsHTTPEnabled = true
	print("HTTP is enabled expect no HTTP errors in 'HTTPv1'")
else
	IsHTTPEnabled = false
	warn("Warning: HTTP Service not enabled. To enable go to Home->Game Settings->Security->Allow HTTP Requests")
	return HTTPv2
end

--Vars
IsHTTPEnabled = IsHTTPEnabled
ShowWarnings = true --Should it show warn(). By default this would be set to true but it can be changed to your liking

--Functions
function HTTPv2.GetAndDecode(Url,NoCache,Headers)
	--Url: The web address you are requesting data from(Type: String)(Required)
		--NoCache: Whether the request stores (caches) the response(Type: Bool)(Optional)
			--Headers:Used to specify some HTTP request headers(Type: Variant)(Optional)
	
	--Info can be found here -> https://developer.roblox.com/en-us/api-reference/function/HttpService/GetAsync
	
	--Were just checking our inputs here
	assert(Url,"Error: Missing parameter 'Url'")
	assert(type(Url)=="string","Error: Url is not 'string' type. Please enter in a valid string or use 'string()'")
	
	if ShowWarnings == true then
		if NoCache == nil then
			warn("'NoCache' input value not provided. Defaulting to 'false'")
		end
		if Headers == nil then
			warn("'Headers' input value not provided. Defaulting to 'nil'")
		end
	end
	
	--
	local ServerResponse,DecodedMessage = pcall(function()
		local ServerResponse = HTTPService:GetAsync(Url,NoCache,Headers)
		local Decoded = HTTPService:JSONDecode(ServerResponse)
		return ServerResponse,Decoded
	end)
	return ServerResponse,DecodedMessage
end

function HTTPv2.EncodeAndPost(Url,Data,ContentType,Compress,Headers)
	--Url:The destination address for the data(Type: String)--(Required)
		--Data:The data being sent(Type: Table)--(Required)
			--ContentType:Modifies the value in the Content-Type header sent with the request(Type: HttpContentType)--(Optional)
				--Compress:Determines whether the data is compressed (gzipped) when sent(Type: Bool)--(Optional)
					--Headers:Used to specify some HTTP request headers(Type: Variant)--(Optional)
	
	--Info can be found here -> https://developer.roblox.com/en-us/api-reference/function/HttpService/PostAsync
	
	--Again we check our inputs
	assert(Url,"Error: Missing parameter 'Url'")
	assert(type(Url)=="string","Error: Url is not 'string' type. Please enter in a valid string or use 'string()'")
	assert(Data,"Error: Missing parameter 'Data'")
	assert(type(Data)=="table","Error: Data is not 'table' type. Please enter in a valid table")
	
	if ShowWarnings == true then
		if ContentType == nil then
			warn("'ContentType' input value not provided. Defaulting to 'ApplicationJson'")
		end
		if Compress == nil then
			warn("'Compress' input value not provided. Defaulting to 'false'")
		end
		if Headers == nil then
			warn("'Headers' input value not provided. Defaulting to 'nil'")
		end
	end
	
	--
	local Res = pcall(function()
		local EncodedData = HTTPService:JSONEncode(Data)
		local HTTPPostResponse = HTTPService:PostAsync(Url,EncodedData,ContentType,Compress,Headers)
		return HTTPPostResponse
	end)
	return Res
end

function HTTPv2.UrlEncode(UnSafeUrl)
		--UnSafeUrl:The string (URL) to encode(Type: String)(Required)
	
	--Info can be found here -> https://developer.roblox.com/en-us/api-reference/function/HttpService/UrlEncode
	
	assert(UnSafeUrl,"Error: Missing parameter 'Url'. How did you mess that up. It's just a one parameter function")
	assert(type(UnSafeUrl)=="string","Error: Url is not 'string' type. Please enter in a valid string or use 'string()'")
	local SafeUrl = HTTPService:UrlEncode(UnSafeUrl)
	return SafeUrl
end

function HTTPv2.GGUID(GenerateCurlyBraces)
		--GenerateCurlyBraces:Whether the returned string should be wrapped in {curly braces}(Type: Bool)(Required)
	
	--Info can be found here -> https://developer.roblox.com/en-us/api-reference/function/HttpService/GenerateGUID
	
	assert(GenerateCurlyBraces,"Error: Missing parameter 'GenerateCurlyBraces'. How did you mess that up. It's just a one parameter function")
	assert(type(GenerateCurlyBraces)=="boolean","Error: GenerateCurlyBraces is not 'boolean' type. Please enter in a valid boolean")
	local Str = HTTPService:GenerateGUID(GenerateCurlyBraces)
	return Str
end

return HTTPv1

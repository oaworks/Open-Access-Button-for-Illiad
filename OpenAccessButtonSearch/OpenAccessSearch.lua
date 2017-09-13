-- About GoogleScholarSearch.lua
--
-- GoogleScholarSearch.lua does a Google Scholar search for the PhotoArticleTitle for articles.
-- autoSearch (boolean) determines whether the search is performed automatically when a request is opened or not.
--
-- "f" is the formname on google.com
-- "q" is the text box name on google.com

local autoSearch = GetSetting("AutoSearch");

local interfaceMngr = nil;
local oaButtonForm = {};
oaButtonForm.Form = nil;
oaButtonForm.Browser = nil;
oaButtonForm.RibbonPage = nil;

require "Atlas.AtlasHelpers";

function Init()
	if GetFieldValue("Transaction", "RequestType") == "Article" then
		interfaceMngr = GetInterfaceManager();

		-- Create a form
		oaButtonForm.Form = interfaceMngr:CreateForm ("OA Button Search", "Script");

		-- Create browser
		oaButtonForm.Browser = oaButtonForm.Form:CreateBrowser("OA Button Search", "OA Button Search Browser", "OA Button Search");

		-- Since we didn't create a ribbon explicitly before creating our browser, it will have created one using the name we passed the CreateBrowser method.  We can retrieve that one and add our buttons to it.
		oaButtonForm.RibbonPage = oaButtonForm.Form:GetRibbonPage("OA Button Search");

		-- Create buttons
		oaButtonForm.RibbonPage:CreateButton("Search", GetClientImage("Search32"), "Search", "OA Button");

		-- After we add all of our buttons and form elements, we can show the form.
		oaButtonForm.Form:Show();

		if autoSearch then
			Search();
		end
	end
end

function Search()
	oaButtonForm.Browser:Navigate("http://dev.openaccessbutton.org/?from=illiad&url=" .. AtlasHelpers.UrlEncode(GetFieldValue("Transaction", "PhotoArticleTitle")));
end

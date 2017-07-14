-- About GoogleScholarSearch.lua
--
-- GoogleScholarSearch.lua does a Google Scholar search for the PhotoArticleTitle for articles.
-- autoSearch (boolean) determines whether the search is performed automatically when a request is opened or not.
--
-- "f" is the formname on google.com
-- "q" is the text box name on google.com

local autoSearch = GetSetting("AutoSearch");

local interfaceMngr = nil;
local browser = nil;

function Init()
	if GetFieldValue("Transaction", "RequestType") == "Article" then
		interfaceMngr = GetInterfaceManager();

		-- Create browser
		browser = interfaceMngr:CreateBrowser("Google Scholar Search", "Google Scholar Search", "Script");

		-- Create buttons
		browser:CreateButton("Search", GetClientImage("Search32"), "Search", "Google Scholar");

		browser:Show();

		if autoSearch then
			Search();
		end
	end
end

function Search()
	browser:Navigate("http://scholar.google.com/scholar?q=" .. GetFieldValue("Transaction", "PhotoArticleTitle"));
end

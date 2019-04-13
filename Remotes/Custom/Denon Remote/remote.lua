-- https://github.com/unifiedremote/Docs/blob/master/libs/http.md
local http = libs.http;
-- to parse xml
local data = libs.data;

--/goform/formMainZone_MainZoneXml.xml
--/goform/formMainZone_MainZoneXml.xml?ZoneName=ZONE2
--/goform/formNetAudio_StatusXml.xml
--/goform/formMainZone_MainZoneXmlStatus.xml
--/goform/formZone2_Zone2XmlStatus.xml
--/goform/formMainZone_MainZoneXmlStatusLite.xml
--/goform/formZone2_Zone2XmlStatusLite.xml



--@help Command turn on the AVR
actions.on = function ()
	http.get("http://" .. settings.ip .. "/MainZone/index.put.asp?cmd0=PutZone_OnOff%2FON", function (err, resp) 
		print(err);
		print(resp);
	end);
end
--@help Command turn off the AVR
actions.off = function ()
	http.get("http://" .. settings.ip .. "/MainZone/index.put.asp?cmd0=PutZone_OnOff%2FOFF", function (err, resp) 
		print(err);
		print(resp);
	end);
end
--@help Command Volume Up
actions.volumeup = function ()
	http.get("http://" .. settings.ip .. "/MainZone/index.put.asp?cmd0=PutMasterVolumeBtn/>", function (err, resp) 
		print(err);
		print(resp);
	end);
end
--@help Command Volume Down
actions.volumedown = function ()
	http.get("http://" .. settings.ip .. "/MainZone/index.put.asp?cmd0=PutMasterVolumeBtn/<", function (err, resp) 
		print(err);
		print(resp);
	end);
end
--@help Command 5 select input 1
actions.input1 = function ()
	http.get("http://" .. settings.ip .. "/MainZone/index.put.asp?cmd0=PutZone_InputFunction%2F" .. input1, function (err, resp) 
		print(err);
		print(resp);
	end);
end
--@help Command 6 select input 2
actions.input2 = function ()
	http.get("http://" .. settings.ip .. "/MainZone/index.put.asp?cmd0=PutZone_InputFunction%2FSAT%2F" .. input2, function (err, resp) 
		print(err);
		print(resp);
	end);
end
--@help Command 7 select input 3
actions.input3 = function ()
	http.get("http://" .. settings.ip .. "/MainZone/index.put.asp?cmd0=PutZone_InputFunction%2F" .. input3, function (err, resp) 
		print(err);
		print(resp);
	end);
end
--@help Command 8 volume slider TODO: add read from AVR current state
actions.volumeupdate = function (progress)
	print("progress was changed to " .. progress);
	vol = progress - 80
	http.get("http://" .. settings.ip .. "/MainZone/index.put.asp?cmd0=PutMasterVolumeSet/" .. vol, function (err, resp) 
		print(err);
		print(resp);
	end);
	vol = vol + 80;
	layout.volumeupdate.progress = vol;
end
--@help Command 9 TODO: on launch read current values and update after 10s
actions.launch = function ()
	layout.Input1.text = settings.input1;
	layout.Input2.text = settings.input2;
	layout.Input3.text = settings.input3;
	layout.Input1zone2.text = settings.input1zone2;
	layout.Input2zone2.text = settings.input2zone2;
	layout.Input3zone2.text = settings.input3zone2;
	vol = -40
	layout.volumeupdate.progress = vol;
	tid = libs.timer.timeout(launch, 10000);

	http.get("http://" .. settings.ip .. "/goform/formMainZone_MainZoneXmlStatusLite.xml", function (err, resp) 
		print(err);
		root = data.fromxml(resp);
		vol = root.children[4].text;
		vol = vol + 80;
		layout.volumeupdate.progress = vol;
	end);
	http.get("http://" .. settings.ip .. "/goform/formZone2_Zone2XmlStatusLite.xml", function (err, resp) 
		print(err);
		root = data.fromxml(resp);
		vol = root.children[4].text;
		vol = vol + 80;
		layout.volumeupdateZone2.progress = vol;
	end);
end
--@help Command 10 Toggle playback state of media center
actions.playpause = function()
	keyboard.press("mediaplaypause");
end
actions.refresh = function ()
	http.get("http://" .. settings.ip .. "/goform/formMainZone_MainZoneXmlStatusLite.xml", function (err, resp) 
		print(err);
		root = data.fromxml(resp);
		power = root.children[1].text;
		if (power == "ON") then
			layout.On.color = "#33aa33";
			layout.Off.color = "#222222";
		else
			layout.On.color = "#222222";
			layout.Off.color = "#ff5566";
		end
		input = root.children[2].text;
		if (input == settings.input1) then
			layout.Input1.color = "#33aa33";
			layout.Input2.color = "#222222";
			layout.Input3.color = "#222222";
		elseif (input == settings.input2) then
			layout.Input1.color = "#222222";
			layout.Input2.color = "#33aa33";
			layout.Input3.color = "#222222";
		elseif (input == settings.input3) then
			layout.Input1.color = "#222222";
			layout.Input2.color = "#222222";
			layout.Input3.color = "#33aa33";
		end
		vol = root.children[4].text;
		vol = vol + 80;
		layout.volumeupdate.progress = vol;
	end);
	http.get("http://" .. settings.ip .. "/goform/formZone2_Zone2XmlStatusLite.xml", function (err, resp) 
		print(err);
		root = data.fromxml(resp);
		power = root.children[1].text;
		power = root.children[1].text;
		if (power == "ON") then
			layout.OnZone2.color = "#33aa33";
			layout.OffZone2.color = "#222222";
		else
			layout.OnZone2.color = "#222222";
			layout.OffZone2.color = "#ff5566";
		end
		input = root.children[2].text;
		if (input == settings.input1) then
			layout.Input1Zone2.color = "#33aa33";
			layout.Input2Zone2.color = "#222222";
			layout.Input3Zone2.color = "#222222";
		elseif (input == settings.input2) then
			layout.Input1Zone2.color = "#222222";
			layout.Input2Zone2.color = "#33aa33";
			layout.Input3Zone2.color = "#222222";
		elseif (input == settings.input3) then
			layout.Input1Zone2.color = "#222222";
			layout.Input2Zone2.color = "#222222";
			layout.Input3Zone2.color = "#33aa33";
		end
		vol = root.children[4].text;
		vol = vol + 80;
		layout.volumeupdateZone2.progress = vol;
	end);
end
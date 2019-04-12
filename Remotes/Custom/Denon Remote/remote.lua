-- https://github.com/unifiedremote/Docs/blob/master/libs/http.md
local http = libs.http;

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
	layout.volumeupdate.progress = vol;
	http.get("http://" .. settings.ip .. "/MainZone/index.put.asp?cmd0=PutMasterVolumeSet/" .. vol, function (err, resp) 
		print(err);
		print(resp);
	end);
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
end
--@help Command 10 Toggle playback state of media center
actions.playpause = function()
	keyboard.press("mediaplaypause");
end
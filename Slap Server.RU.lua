if not game:IsLoaded() then
    game.Loaded:Wait()
end
wait(1)
local args = {
    [1] = "\208\154\209\130\208\190 \209\133\208\190\209\135\208\181\209\130 \208\189\208\176 \208\186\209\128\209" ..
        "\131\209\130\208\190\208\185 \209\129\208\181\209\128\208\178\208\181\209\128 \208\191" ..
        "\208\190 \209\129\208\187\208\181\208\191 \208\177\208\176\209\130\208\187\209\129 " ..
        "(500+\209\131\209\135\208\176\209\129\209\130\208\189\208\184\208\186\208\190\208\178)" ..
        " \208\191\208\184\209\129\208\176\209\130\209\140 \208\178 \208\187\209\129 \208\180\208" ..
        "\181\208\186\209\129\208\190\209\128\208\180 "..DiscordName,
    [2] = "All"
}

game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(unpack(args))
wait(0.5)
HttpService = cloneref(game:GetService("HttpService"))
MarketplaceService = cloneref(game:GetService("MarketplaceService"))
TeleportService = cloneref(game:GetService("TeleportService"))
queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
PlaceId, JobId = game.PlaceId, game.JobId
local servers = {}
local req = httprequest({Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", PlaceId)})
local body = HttpService:JSONDecode(req.Body)
if body and body.data then
    for i, v in next, body.data do
        if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= JobId then
            table.insert(servers, 1, v.id)
        end
    end
end
if #servers > 0 then
    TeleportService:TeleportToPlaceInstance(PlaceId, servers[math.random(1, #servers)], game.Players.LocalPlayer)
else
    return 
end

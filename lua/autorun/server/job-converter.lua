if not file.Exists('darkrp-jobs', 'DATA') then
    file.CreateDir('darkrp-jobs')
    file.Write("darkrp-jobs/jobs.txt", "")
end

local newfile = file.Open( "darkrp-jobs/lits.txt", "r", "DATA" )

local jobStringFormat = [[
TEAM_EXAMPLE = DarkRP.createJob("%s", {
    color = Color(255, 255, 255, 255),
    model = {
        "models/player/Group03/Female_01.mdl",
        "models/player/Group03/Female_02.mdl"
    },
    description = '[This text will serve as the description of this team.]',
    weapons = {"weapon_p2282"},
    command = "example",
    max = 0.7,
    salary = 45,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "%s"
})

]]

local jobTables = {}
local newTable = {}

local count = 1
while true do
  local line = newfile:ReadLine()
  if line == nil then break end
  table.insert(newTable, string.Split(line, ","))
  count = count + 1
end

for k, v in pairs(newTable) do
    for j, d in pairs(newTable[k]) do
        table.insert(jobTables, string.Split(d, ":"))
    end
end

for k, v in pairs(jobTables) do

    if istable(v) then

        if table.IsEmpty(v) then
            table.remove(jobTables, k)
        else

            for k2, v2 in pairs(v) do

                if not v2 or v2 == nil or v2 == " " then
                    table.remove(v, k2)
                end

            end

        end
    end

end

PrintTable(jobTables)

for l, x in pairs(jobTables) do
    jobTitle = string.Trim( jobTables[l][2], " " )
    jobCategory = string.Trim(jobTables[l][1], " ")
    jobs = string.format(jobStringFormat, jobTitle, jobCategory)
    file.Append("darkrp-jobs/jobs.txt", jobs)
end
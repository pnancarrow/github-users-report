# Set OCTOKIT_ACCESS_TOKEN to authenticate

require "octokit"
require "csv"

Octokit.auto_paginate = true
teams = Octokit.org_teams "virtru"

CSV.open("export-teams.csv", "wb") do |csv|
  csv << ["team name", "team description", "users"]
  teams.each do |t|
    members = Octokit.team_members t[:id]
    members.each do |m|
      csv << [t[:name], t[:description], m[:login]]
    end
  end
end

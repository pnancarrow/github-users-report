# Set OCTOKIT_ACCESS_TOKEN to authenticate

require "octokit"
require "csv"

ORGANIZATION = ""

Octokit.auto_paginate = true
members = Octokit.org_members ORGANIZATION, :role => "member"
admins = Octokit.org_members ORGANIZATION, :role => "admin"
collaborators = Octokit.outside_collaborators ORGANIZATION

CSV.open("export-members.csv", "wb") do |csv|
  csv << ["type","username", "name", "email"]
  
  members.each do |m|
    user = Octokit.user m[:login]
    csv << [:member, m[:login], user.name, user.email]
  end
  
  admins.each do |a|
    user = Octokit.user a[:login]
    csv << [:admin, a[:login], user.name, user.email]
  end
  
  collaborators.each do |c|
    user = Octokit.user c[:login]
    csv << [:collaborator, c[:login], user.name, user.email]
  end
end

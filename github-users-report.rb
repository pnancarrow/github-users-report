require "octokit"
require "csv"

# Add you Github organization name here
ORG = ""
DATE = String(Date.today)
FILE = "github-users-" + DATE + ".csv"

Octokit.auto_paginate = true

members = Octokit.org_members ORG, :role => "member"
admins = Octokit.org_members ORG, :role => "admin"
collaborators = Octokit.outside_collaborators ORG
teams = Octokit.org_teams ORG

User = Struct.new(:type, :username, :full_name, :email, :teams)
Team = Struct.new(:username, :name)

def users
  @users ||= []
end

def teams_assigned
  @teams_assigned ||= []
end

def find_user_by_username(username)
  users.detect { |user| user[:username] == username }
end

puts "*** Generating List of Users ***"
members.each do |m|
  user = Octokit.user m[:login]
  users << User.new(:member, m[:login], user.name, user.email, nil)
end
  
admins.each do |a|
  user = Octokit.user a[:login]
  users << User.new(:admin, a[:login], user.name, user.email, nil)
end
  
collaborators.each do |c|
  user = Octokit.user c[:login]
  users << User.new(:collaborator, c[:login], user.name, user.email, nil)
end

puts "*** Generating List of Teams ***"
teams.each do |t|
  teammembers = Octokit.team_members t[:id]
  teammembers.each do |tm| 
    teams_assigned << Team.new(tm[:login], t[:name])
  end
end

puts "*** Processing Assigned Teams ***"
teams_assigned.each do |ta|
  user = find_user_by_username(ta[:username])
  if user[:teams].nil?
    user[:teams] = ta[:name]
  else
    user[:teams] = user[:teams] + ", " + ta[:name]
  end
end

puts "****** Creating CSV File ******"
CSV.open(FILE, "wb") do |csv|
  csv << ["type","username", "name", "email", "teams"]
  users.each do |u|
    csv << [u[:type], u[:username], u[:full_name], u[:email], u[:teams]]
  end
end

puts "Review Users in " + FILE + "!"

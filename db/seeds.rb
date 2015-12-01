# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

books = [
  ["魔法学徒", "蓝晶", "3000000", "fiction"],
  ["流氓高手1", "无罪", "1500000", "game"],
  ["亵渎", "烟雨江南", "2270000", "fiction"],
  ["Test1", "蓝晶", "3000000", "fiction"],
  ["Test2", "无罪", "1500000", "game"],
  ["Test3", "烟雨江南", "2270000", "fiction"],
  ["Test1", "蓝晶", "3000000", "fiction"],
  ["Test2", "无罪", "1500000", "game"],
  ["Test3", "烟雨江南", "2270000", "fiction"],
  ["Test1", "蓝晶", "3000000", "fiction"],
  ["Test2", "无罪", "1500000", "game"],
  ["Test3", "烟雨江南", "2270000", "fiction"],
  ["Test1", "蓝晶", "3000000", "fiction"],
  ["Test2", "无罪", "1500000", "game"],
  ["Test3", "烟雨江南", "2270000", "fiction"],
  ["Test1", "蓝晶", "3000000", "fiction"],
  ["Test2", "无罪", "1500000", "game"],
  ["Test3", "烟雨江南", "2270000", "fiction"]
]

admin = {
	username: "perpherior",
  email: "admin@perpherior.com",
  password: "123123123"
}

Admin.create username: admin[:username], email: admin[:email], password: admin[:password]

current_admin = Admin.find_by(email: admin[:email])

books.each do |name, author, word_count, category|
  Book.create name: name, author: author, word_count: word_count, category: category, admin_id: 1
end
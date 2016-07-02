# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
c = Channel.create(title: 'Sinfest', link: 'http://www.sinfest.net', description: 'Strip dealing with contemporary issues and religion. Created by Tatsuya Ishida.', channel_type: Channel.channel_types[:sinfest], last_build_date: Time.now)
ChannelImage.create(title: 'Sinfest', url: 'http://www.sinfest.net/favicon.ico', link: 'http://www.sinfest.net', width: 16, height: 16, channel: c)
ChannelItem.create(title: 'July 1, 2016: Sweep 5', link: 'http://www.sinfest.net/view.php?date=2016-07-01', guid: "sinfest.#{SecureRandom.uuid}", pubdate: '2016-07-01', description: '<img src="http://www.sinfest.net/btphp/comics/2016-07-01.gif" border="0" alt="July 1, 2016: Sweep 5" />', channel: c)
